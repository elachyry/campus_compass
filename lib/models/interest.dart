class Interest {
  final String id;
  final String name;

  Interest({
    required this.id,
    required this.name,
  });

  static List<Interest> interestsList = [
    Interest(
      id: '1',
      name: '🏋️‍♂️ Sports and Fitness',
    ),
    Interest(
      id: '2',
      name: '🎸 Music and Performing Arts',
    ),
    Interest(
      id: '3',
      name: '💻 Technology and Coding',
    ),
    Interest(
      id: '4',
      name: '🔬 Science and Research',
    ),
    Interest(
      id: '5',
      name: '📖 Literature and Writing',
    ),
    Interest(
      id: '6',
      name: '🎨 Art and Design',
    ),
    Interest(
      id: '7',
      name: '🤝 Social Events and Networking',
    ),
    Interest(
      id: '8',
      name: '🙏 Volunteering and Community Service',
    ),
    Interest(
      id: '9',
      name: '✈️ Travel and Adventure',
    ),
    Interest(
      id: '10',
      name: '🎮 Gaming and Esports',
    ),
    Interest(
      id: '11',
      name: '🌱 Environmental and Sustainability',
    ),
    Interest(
      id: '12',
      name: '💼 Business and Entrepreneurship',
    ),
    Interest(
      id: '13',
      name: '🈳 Languages and Cultures',
    ),
    Interest(
      id: '14',
      name: '🥘 Food and Cooking',
    ),
    Interest(
      id: '15',
      name: '👩‍⚕️ Health and Wellness',
    ),
  ];

  toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      id: json['id'],
      name: json['name'],
    );
  }
}
