class AppConfig {
  static const String endpointUrl = String.fromEnvironment(
    'ENDPOINT_URL',
    defaultValue: 'https://dev-be-membership.lugu.id',
  );
  static const String baseUrl = '$endpointUrl/api/';
  static const String imageUrl = '$endpointUrl/storage/image';
  static const String fileUrl = '$endpointUrl/storage/files';
  static const String repoCode = String.fromEnvironment(
    'REPOSITORY_CODE',
    defaultValue: 'BG_POSD',
  );

  //POS
  static const String endpointPostUrl = String.fromEnvironment(
    'ENDPOINT_POST_URL',
    defaultValue: 'https://dev.pos.billiardgarage.com',
  );
  static const String posBaseUrl = '$endpointPostUrl/api/';
  static const String dummyToken =
      '130|nLm8duAqPA4t57LbF7VdA7fYhdSRVzpzqG1hAzFMa164a780';
  static const String usernamePOS = String.fromEnvironment('USERNAME_POS');
  static const String passwordPOS = String.fromEnvironment('PASSWORD_POS');
}
