class Interest {
  final String id;
  final String name;
  final String? image;

  Interest({
    required this.id,
    required this.name,
    this.image,
  });

  static List<Interest> interestsList = [
    Interest(
      id: '1',
      name: '🏋️‍♂️ Sports and Fitness',
      image: 'assets/images/interests/sports_and_fitness.png',
    ),
    Interest(
      id: '2',
      name: '🎸 Music and Performing Arts',
      image: 'assets/images/interests/music_and_performing_arts.png',
    ),
    Interest(
      id: '3',
      name: '💻 Technology and Coding',
      image: 'assets/images/interests/technology_and_coding.png',
    ),
    Interest(
      id: '4',
      name: '🔬 Science and Research',
      image: 'assets/images/interests/science_and_research.png',
    ),
    Interest(
      id: '5',
      name: '📖 Literature and Writing',
      image: 'assets/images/interests/literature_and_writing.png',
    ),
    Interest(
      id: '6',
      name: '🎨 Art and Design',
      image: 'assets/images/interests/art_and_design.png',
    ),
    Interest(
      id: '7',
      name: '🤝 Social Events and Networking',
      image: 'assets/images/interests/social_events_and_networking.png',
    ),
    Interest(
      id: '8',
      name: '🙏 Volunteering and Community Service',
      image: 'assets/images/interests/volunteering_and_community_service.png',
    ),
    Interest(
      id: '9',
      name: '✈️ Travel and Adventure',
      image: 'assets/images/interests/travel_and_adventure.png',
    ),
    Interest(
      id: '10',
      name: '🎮 Gaming and Esports',
      image: 'assets/images/interests/gaming_and_esports.png',
    ),
    Interest(
      id: '11',
      name: '🌱 Environmental and Sustainability',
      image: 'assets/images/interests/environmental_and_sustainability.png',
    ),
    Interest(
      id: '12',
      name: '💼 Business and Entrepreneurship',
      image: 'assets/images/interests/business_and_entrepreneurship.png',
    ),
    Interest(
      id: '13',
      name: '🈳 Languages and Cultures',
      image: 'assets/images/interests/languages_and_cultures.png',
    ),
    Interest(
      id: '14',
      name: '🥘 Food and Cooking',
      image: 'assets/images/interests/food_and_cooking.png',
    ),
    Interest(
      id: '15',
      name: '👩‍⚕️ Health and Wellness',
      image: 'assets/images/interests/health_and_wellness.png',
    ),
  ];
}
