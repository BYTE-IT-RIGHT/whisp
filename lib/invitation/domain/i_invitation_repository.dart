import 'package:dartz/dartz.dart';
import 'package:flick/common/domain/failure.dart';

abstract class IInvitationRepository {
  Future<Either<Failure, Unit>> sendInvitationResponse(
    String onionAddress, {
    required bool accepted,
  });
}

