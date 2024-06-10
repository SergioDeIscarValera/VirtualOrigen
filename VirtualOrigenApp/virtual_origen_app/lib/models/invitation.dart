class Invitation {
  final String fromEmail;
  final String fromProfileImage;
  final String ownerId;
  final String propertyName;
  final String propertyId;
  final bool state;
  final bool isNew;

  Invitation({
    required this.fromEmail,
    required this.fromProfileImage,
    required this.ownerId,
    required this.propertyName,
    required this.propertyId,
    required this.state,
    required this.isNew,
  });

  Invitation copyWith({
    String? fromEmail,
    String? fromProfileImage,
    String? ownerId,
    String? propertyName,
    String? propertyId,
    bool? state,
    bool? isNew,
  }) {
    return Invitation(
      fromEmail: fromEmail ?? this.fromEmail,
      fromProfileImage: fromProfileImage ?? this.fromProfileImage,
      ownerId: ownerId ?? this.ownerId,
      propertyName: propertyName ?? this.propertyName,
      propertyId: propertyId ?? this.propertyId,
      state: state ?? this.state,
      isNew: isNew ?? this.isNew,
    );
  }
}
