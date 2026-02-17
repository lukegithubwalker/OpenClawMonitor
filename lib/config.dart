class AppConfig {
  static const String apiBaseUrl =
      String.fromEnvironment("API_BASE_URL", defaultValue: "https://example.com/api");
  static const String wsUrl =
      String.fromEnvironment("WS_URL", defaultValue: "wss://example.com/ws");
  static const String apiKey =
      String.fromEnvironment("API_KEY", defaultValue: "CHANGE_ME");
}