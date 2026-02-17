import "../config.dart";

class AuthService {
  static Map<String, String> headers() => {
    "Authorization": "Bearer \\${AppConfig.apiKey}",
    "Content-Type": "application/json",
  };
}