class APIEndPoint {
  static String get currencyEndpoint => "/api/exrates/rates";

  static String get currencyInfoEndpoint => "/api/exrates/currencies";

  static String trends(int id) => "/API/ExRates/Rates/Dynamics/$id";
}
