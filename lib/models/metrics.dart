class Metrics {
  final double cpu;
  final double memory;
  final double responseTime;
  final bool online;

  Metrics({
    required this.cpu,
    required this.memory,
    required this.responseTime,
    required this.online,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      cpu: (json["cpu"] ?? 0).toDouble(),
      memory: (json["memory"] ?? 0).toDouble(),
      responseTime: (json["responseTime"] ?? 0).toDouble(),
      online: json["online"] ?? false,
    );
  }
}