class AuthCredentialDto {
  final String idToken;
  final String provider; // 'google' or 'apple'
  final String providerId;
  final String? email;
  final String? displayName;
  final String? photoURL;

  const AuthCredentialDto({
    required this.idToken,
    required this.provider,
    required this.providerId,
    this.email,
    this.displayName,
    this.photoURL,
  });

  factory AuthCredentialDto.fromJson(Map<String, dynamic> json) {
    return AuthCredentialDto(
      idToken: json['idToken'] as String,
      provider: json['provider'] as String,
      providerId: json['providerId'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'provider': provider,
      'providerId': providerId,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
    };
  }
}
