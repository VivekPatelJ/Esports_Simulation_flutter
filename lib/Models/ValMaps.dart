class Valmaps {
  final String displayName;
  final String splash;
  final String tacticalDescription;

  Valmaps({
    required this.displayName,
    required this.tacticalDescription,
    required this.splash,
  });

  factory Valmaps.fromJson(Map<String, dynamic> json) {
    return Valmaps(
      displayName: json['displayName'] ?? "Unknown",
      tacticalDescription: json['tacticalDescription'] ?? "No description available",
      splash: json['splash'] ?? "",
    );
  }
}
