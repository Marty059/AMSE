class MediaModel {
  final String imageUrl;
  final String title;
  final String description;

  const MediaModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

const series = [
  MediaModel(
    imageUrl: 'assets/imgs/stranger-things.jpg',
    title: 'Stranger Things',
    description: 'Test',
  ),
];

const films = [
  MediaModel(
    imageUrl: 'assets/imgs/dragon.jpg',
    title: 'Dragon',
    description: 'Test',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/Private_Ryan.jpg',
    title: 'Il faut sauver le soldat Ryan',
    description: 'Test',
  ),
];
