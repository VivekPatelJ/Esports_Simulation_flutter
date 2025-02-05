class ValAgents {
  final String displayName;
  final String description;
  final String displayIconSmall;
  final String background;
  final List<String> backgroundGradientColors;

  ValAgents(
      {required this.displayName,
      required this.description,
      required this.displayIconSmall,
      required this.background,
      required this.backgroundGradientColors});

  factory ValAgents.fromJson(Map<String, dynamic> json) {
    return ValAgents(
      displayName: json['displayName'] ?? 'Unknown Agent',
      description: json['description'] ?? 'No description available.',
      displayIconSmall: (json['displayIconSmall'] != null &&
              json['displayIconSmall'].toString().isNotEmpty)
          ? json['displayIconSmall']
          : 'https://via.placeholder.com/150', // ✅ Default image URL
      background: (json['background'] != null &&
              json['background'].toString().isNotEmpty)
          ? json['background']
          : 'https://via.placeholder.com/300',
      backgroundGradientColors: List<String>.from(
          json['backgroundGradientColors'] ??
              []), // ✅ Default background image URL
    );
  }
}
