import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whisp/TOR/domain/i_tor_repository.dart';
import 'package:whisp/common/domain/failure.dart';
import 'package:whisp/local_storage/domain/i_local_storage_repository.dart';
import 'package:whisp/mailbox/domain/i_mailbox_repository.dart';

@LazySingleton(as: IMailboxRepository)
class MailboxRepository implements IMailboxRepository {
  final ITorRepository _torRepository;
  final ILocalStorageRepository _localStorageRepository;

  MailboxRepository(this._torRepository, this._localStorageRepository);

  @override
  Future<Either<Failure, Unit>> addMailbox({
    required String onionAddress,
    required String pin,
  }) async {
    try {
      final result = await _torRepository.post(
        'http://$onionAddress/pair',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pin': pin}),
      );

      return await result.fold(
        (failure) {
          log('addMailbox connection error: $failure');
          return left(MailboxConnectionError());
        },
        (response) async {
          if (response.statusCode == 200) {
            try {
              final body = jsonDecode(response.body) as Map<String, dynamic>;
              final success = body['success'] as bool? ?? false;

              if (success) {
                await _localStorageRepository.setMailbox(
                  onionAddress: onionAddress,
                  pin: pin,
                );
                return right(unit);
              } else {
                return left(MailboxAuthenticationError());
              }
            } catch (e) {
              log('addMailbox parse error: $e');
              return left(UnexpectedError());
            }
          } else if (response.statusCode == 401) {
            return left(MailboxAuthenticationError());
          } else {
            return left(MailboxConnectionError());
          }
        },
      );
    } catch (e) {
      log('addMailbox unexpected error: $e');
      return left(UnexpectedError());
    }
  }

  List<Map<String, dynamic>> _messageMapsFromDecoded(dynamic decoded) {
    List<dynamic>? raw;
    if (decoded is List<dynamic>) {
      raw = decoded;
    } else if (decoded is Map<String, dynamic>) {
      final nested = decoded['messages'] ?? decoded['data'];
      if (nested is List<dynamic>) raw = nested;
    }
    if (raw == null) return [];

    final out = <Map<String, dynamic>>[];
    for (final item in raw) {
      if (item is Map<String, dynamic>) {
        out.add(item);
      } else if (item is Map) {
        out.add(Map<String, dynamic>.from(item));
      }
    }
    return out;
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> downloadQueuedMessages({
    required String onionAddress,
    required String pin,
  }) async {
    try {
      final result = await _torRepository.post(
        'http://$onionAddress/download',
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'pin': pin}),
      );

      return await result.fold(
        (failure) {
          log('downloadQueuedMessages connection error: $failure');
          return left(MailboxConnectionError());
        },
        (response) {
          if (response.statusCode == 401) {
            return left(MailboxAuthenticationError());
          }
          if (response.statusCode != 200) {
            log(
              'downloadQueuedMessages HTTP ${response.statusCode}: ${response.body}',
            );
            return left(MailboxConnectionError());
          }
          try {
            final decoded = jsonDecode(response.body);
            return right(_messageMapsFromDecoded(decoded));
          } catch (e) {
            log('downloadQueuedMessages parse error: $e');
            return left(UnexpectedError());
          }
        },
      );
    } catch (e) {
      log('downloadQueuedMessages unexpected error: $e');
      return left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, bool>> pingMailbox(String onionAddress) async {
    try {
      final result = await _torRepository.post(
        'http://$onionAddress/ping',
        headers: {'Content-Type': 'application/json'},
      );

      return result.fold(
        (failure) {
          log('pingMailbox error: $failure');
          return right(false);
        },
        (response) {
          final statusCode = response.statusCode;
          return right(statusCode >= 200 && statusCode < 300);
        },
      );
    } catch (e) {
      log('pingMailbox unexpected error: $e');
      return right(false);
    }
  }

  @override
  Future<void> pingAllMailboxes() async {
    final mailboxAddress = _localStorageRepository.getMailboxAddress();
    if (mailboxAddress != null && mailboxAddress.isNotEmpty) {
      await pingMailbox(mailboxAddress);
    }
  }
}
