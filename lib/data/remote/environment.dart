class Environments {
  static const String PRODUCTION = 'https://fakestoreapi.com';
  static const String DEV = 'https://fakestoreapi.com';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static const List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.DEV,
      'url': 'https://fakestoreapi.com/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'https://fakestoreapi.com',
    },
  ];

  static String? getEnvironments() {
    return _availableEnvironments
        .firstWhere(
          (d) => d['env'] == _currentEnvironments,
        )
        .values
        .last
        .toString();
  }
}
