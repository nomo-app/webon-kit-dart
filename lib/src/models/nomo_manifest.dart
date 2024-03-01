// ignore_for_file: non_constant_identifier_names

class NomoManifest {
  final String? min_nomo_version;
  final String nomo_manifest_version;
  final String webon_id;
  final String webon_name;
  final String webon_url;
  final String webon_version;

  NomoManifest({
    required this.min_nomo_version,
    required this.nomo_manifest_version,
    required this.webon_id,
    required this.webon_name,
    required this.webon_url,
    required this.webon_version,
  });

  factory NomoManifest.fromJson(Map<String, dynamic> json) {
    return NomoManifest(
      min_nomo_version: json['min_nomo_version'],
      nomo_manifest_version: json['nomo_manifest_version'],
      webon_id: json['webon_id'],
      webon_name: json['webon_name'],
      webon_url: json['webon_url'],
      webon_version: json['webon_version'],
    );
  }
}
