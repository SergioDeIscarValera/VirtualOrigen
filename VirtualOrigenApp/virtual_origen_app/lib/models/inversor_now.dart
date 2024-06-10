class InversorNow {
  final double battery; // 0-100
  final int consumption; // Watts
  final int gain; // Watts

  InversorNow({
    required this.battery,
    required this.consumption,
    required this.gain,
  });

  InversorNow.defaultConstructor()
      : battery = 0,
        consumption = 0,
        gain = 0;
}
