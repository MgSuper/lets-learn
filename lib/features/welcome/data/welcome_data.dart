class Welcome {
  String image, title, description;
  Welcome({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Welcome> welcomeData = [
  Welcome(
    image: 'assets/welcome/efficiency.png',
    title: 'Embark on a Journey of Learning and Growth with Us',
    description:
        'Discover a world of knowledge and new skills waiting to be explored. Dive into our learning platform and unlock endless possibilities for personal and professional growth. Start your journey today!',
  ),
  Welcome(
    image: 'assets/welcome/efficiency.png',
    title: 'Master Your Skills Through Hands-On Practice',
    description:
        'Put your learning into action with interactive exercises and practical tasks. Dive into real-world scenarios, hone your abilities, and watch your skills soar!',
  ),
  Welcome(
    image: 'assets/welcome/efficiency.png',
    title: 'Congratulations! Let\'s Start Your Learning Journey!',
    description:
        'Your hard work pays off! Celebrate your progress and achievements as you continue to learn and grow with us. Well done!',
  ),
];
