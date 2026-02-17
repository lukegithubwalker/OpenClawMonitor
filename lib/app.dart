import "dart:async";
import "package:flutter/material.dart";
import "models/metrics.dart";
import "services/ws_service.dart";
import "ui/widgets/three_panel.dart";
import "ui/widgets/status_cards.dart";
import "ui/widgets/charts_panel.dart";
import "ui/widgets/alert_panel.dart";
import "ui/widgets/control_panel.dart";

class ClawScopeApp extends StatefulWidget {
  const ClawScopeApp({super.key});

  @override
  State<ClawScopeApp> createState() => _ClawScopeAppState();
}

class _ClawScopeAppState extends State<ClawScopeApp> {
  final ws = WsService();

  Metrics? metrics;
  String alert = "";
  bool dark = true;
  bool connected = false;

  List<double> cpuHistory = [];
  List<double> memHistory = [];

  StreamSubscription? sub;
  int retryCount = 0;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  void _connect() {
    try {
      final channel = ws.connect();
      setState(() => connected = true);

      sub = channel.stream.listen((msg) {
        final data = ws.parse(msg);
        _update(data);
        retryCount = 0;
      }, onError: (_) {
        _scheduleReconnect("WebSocket error. Retrying...");
      }, onDone: () {
        _scheduleReconnect("WebSocket closed. Retrying...");
      });
    } catch (_) {
      _scheduleReconnect("Failed to connect. Retrying...");
    }
  }

  void _scheduleReconnect(String message) {
    setState(() {
      connected = false;
      alert = message;
    });

    retryCount++;
    final delay = Duration(seconds: (2 * retryCount).clamp(2, 20));
    Future.delayed(delay, _connect);
  }

  void _update(Metrics m) {
    setState(() {
      metrics = m;
      cpuHistory = [...cpuHistory, m.cpu].take(30).toList();
      memHistory = [...memHistory, m.memory].take(30).toList();
      if (!m.online) alert = "ALERT: OpenClaw is offline!";
      else alert = "";
    });
  }

  void _sendControl(String action) async {
    // Placeholder for REST endpoint call
  }

  @override
  Widget build(BuildContext context) {
    final m = metrics;
    return MaterialApp(
      theme: dark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ClawScope"),
          actions: [
            Icon(
              connected ? Icons.cloud_done : Icons.cloud_off,
              color: connected ? Colors.greenAccent : Colors.redAccent,
            ),
            IconButton(
              icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => setState(() => dark = !dark),
            )
          ],
        ),
        body: m == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AlertPanel(alert: alert),
                    StatusCards(
                      online: m.online,
                      cpu: m.cpu,
                      memory: m.memory,
                      responseTime: m.responseTime,
                    ),
                    const SizedBox(height: 16),
                    ThreePanel(cpu: m.cpu, mem: m.memory),
                    const SizedBox(height: 16),
                    ChartsPanel(cpuHistory: cpuHistory, memHistory: memHistory),
                    const SizedBox(height: 16),
                    ControlPanel(onAction: _sendControl),
                  ],
                ),
              ),
      );
  }
}