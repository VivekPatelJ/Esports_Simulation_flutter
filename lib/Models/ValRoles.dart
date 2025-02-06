class Role {
  final String displayIcon;

  Role({
    required this.displayIcon,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      displayIcon: json['displayIcon'] ?? 'https://via.placeholder.com/150',
    );
  }
}