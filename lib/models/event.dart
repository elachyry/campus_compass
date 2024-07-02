class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrl,
  });

  static List<Event> events = [
    Event(
      id: '1',
      title: 'Event 1',
      description: 'Description 1',
      date: DateTime.now(),
      location: 'Location 1',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Event(
      id: '2',
      title: 'Event 2',
      description: 'Description 2',
      date: DateTime.now(),
      location: 'Location 2',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Event(
      id: '3',
      title: 'Event 3',
      description: 'Description 3',
      date: DateTime.now(),
      location: 'Location 3',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      imageUrl: json['imageUrl'],
    );
  }
  
 Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'imageUrl': imageUrl,
    };
  }
}
