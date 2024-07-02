class Club {
  final String id;
  final String name;
  final String description;
  final String location;
  final String logoUrl;
  final String coverUrl;

  Club({
    required this.id,
    required this.name,
    required this.location,
    required this.logoUrl,
    required this.coverUrl,
    required this.description,
  });

  static List<Club> clubs = [
    Club(
      id: '1',
      name: 'Club 1',
      description: 'Description 1',
      location: 'Location 1',
      logoUrl: 'https://via.placeholder.com/150',
      coverUrl: 'https://via.placeholder.com/150',
    ),
    Club(
      id: '2',
      name: 'Club 2',
      description: 'Description 2',
      location: 'Location 2',
      logoUrl: 'https://via.placeholder.com/150',
      coverUrl: 'https://via.placeholder.com/150',
    ),
    Club(
      id: '3',
      name: 'Club 3',
      description: 'Description 3',
      location: 'Location 3',
      logoUrl: 'https://via.placeholder.com/150',
      coverUrl: 'https://via.placeholder.com/150',
    ),
  ];

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      location: json['location'],
      logoUrl: json['logoUrl'],
      coverUrl: json['coverUrl'],
    );
  }

 Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'logoUrl': logoUrl,
      'coverUrl': coverUrl,
    };
  }
}
