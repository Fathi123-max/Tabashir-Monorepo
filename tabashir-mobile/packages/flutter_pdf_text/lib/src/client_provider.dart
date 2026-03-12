import 'package:http/http.dart' show Client;

class ClientProvider {
  final Client _client;
  static ClientProvider? _instance;

  factory ClientProvider({Client? client}) =>
      _instance ?? (_instance = ClientProvider._create(client));

  /// defaults to the standard dart http client
  ClientProvider._create(Client? client) : _client = client ?? Client();

  Client get client => _client;
}
