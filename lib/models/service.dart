class Service {
  final String id;
  final String title;
  final String description;
  final String coverUrl;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
  });

  static List<Service> services = [
    Service(
      id: '1',
      title: 'Request a Golf Cart',
      description:
          'Get around campus effortlessly! Request a golf cart for quick and convenient transportation to your destination. Easy, reliable, and just a tap away!',
      coverUrl: 'assets/images/logo/service1.jpg',
    )
  ];

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverUrl: json['coverUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverUrl': coverUrl,
    };
  }
}
