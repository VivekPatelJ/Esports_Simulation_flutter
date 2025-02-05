class Valmaps {
  final String displayName;
  final String tacticalDescription;
  final String splash;

  Valmaps({
    required this.displayName,
    required this.tacticalDescription,
    required this.splash,
  });

  // ✅ Factory method to convert JSON into Valmaps object
  factory Valmaps.fromJson(Map<String, dynamic> json) {
    return Valmaps(
      displayName: json['displayName'] ?? "Unknown Map",
      tacticalDescription: json['tacticalDescription'] ?? "No Description",
      splash: json['splash'] ?? "",
    );
  }

  // ✅ Convert Valmaps object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'tacticalDescription': tacticalDescription,
      'splash': splash,
    };
  }
}
