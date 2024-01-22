// ignore_for_file: non_constant_identifier_names

class UserMatrix {
  final String user_id;
  final String home_server;
  final String access_token;
  final String device_id;

  UserMatrix({
    required this.user_id,
    required this.home_server,
    required this.access_token,
    required this.device_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'home_server': home_server,
      'access_token': access_token,
      'device_id': device_id,
    };
  }

  factory UserMatrix.fromJson(Map<String, dynamic> json) {
    return UserMatrix(
      user_id: json['user_id'] as String,
      home_server: json['home_server'] as String,
      access_token: json['access_token'] as String,
      device_id: json['device_id'] as String,
    );
  }
}
