class Mailbox {
  final String onionAddress;
  final String pin;
  bool isOnline;

  Mailbox({
    required this.onionAddress,
    required this.pin,
    this.isOnline = false,
  });

  Mailbox copyWith({String? onionAddress, String? pin, bool? isOnline}) {
    return Mailbox(
      onionAddress: onionAddress ?? this.onionAddress,
      pin: pin ?? this.pin,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Mailbox && other.onionAddress == onionAddress;
  }

  @override
  int get hashCode => onionAddress.hashCode;
}
