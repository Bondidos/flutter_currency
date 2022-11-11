enum HTTPMethod { get, post, delete, put, patch }

extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "GET";
      case HTTPMethod.post:
        return "POST";
      case HTTPMethod.delete:
        return "DELETE";
      case HTTPMethod.patch:
        return "PATCH";
      case HTTPMethod.put:
        return "PUT";
    }
  }
}

abstract class APIRequestRepresentable {
  String get url;

  String get baseUrl;

  String get path;

  HTTPMethod get method;

  Map<String, String>? get headers;

  Map<String, String>? get query;

  dynamic get body;
}
