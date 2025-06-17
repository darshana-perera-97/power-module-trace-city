class LiveData {
  final DateTime time;
  final int battery, current, key, livepower, totalpower, voltage;
  final bool deviceStatus;

  LiveData({
    required this.time,
    required this.battery,
    required this.current,
    required this.key,
    required this.livepower,
    required this.totalpower,
    required this.voltage,
    required this.deviceStatus,
  });

  factory LiveData.fromJson(Map<String, dynamic> json) {
    final d = json['data'];
    return LiveData(
      time: DateTime.parse(json['time'] as String),
      battery: d['battery'] as int,
      current: d['current'] as int,
      key: d['key'] as int,
      livepower: d['livepower'] as int,
      totalpower: d['totalpower'] as int,
      voltage: d['voltage'] as int,
      deviceStatus: json['deviceStatus'] as bool,
    );
  }
}
