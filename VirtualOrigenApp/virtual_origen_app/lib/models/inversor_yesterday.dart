class InversorYerserday {
  final String propertyId;
  final DateTime dateTime;
  final double battery; // 0-100
  final int consumption; // Watts
  final int gain; // Watts

  InversorYerserday({
    required this.propertyId,
    required this.dateTime,
    required this.battery,
    required this.consumption,
    required this.gain,
  });
}
