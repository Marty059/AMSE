class MediaModel {
  final String imageUrl;
  final String title;
  final String realisateur;

  const MediaModel({
    required this.imageUrl,
    required this.title,
    required this.realisateur,
  });
}

const series = [
  MediaModel(
    imageUrl: 'assets/imgs/stranger-things.jpg',
    title: 'Stranger Things',
    realisateur: 'Test',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/mandalorian.jpg',
    title: 'The Mandalorian',
    realisateur: 'Test',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/peaky-blinders.webp',
    title: 'Peaky Blinders',
    realisateur: 'Test',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/witcher.webp',
    title: 'The Witcher',
    realisateur: 'Test',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/la-casa-de-papel.webp',
    title: 'La Casa de Papel',
    realisateur: 'Test',
  ),
];

const films = [
  MediaModel(
    imageUrl: 'assets/imgs/dragon.jpg',
    title: 'Dragon',
    realisateur: 'Dean DeBlois',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/Private_Ryan.jpg',
    title: 'Il faut sauver le soldat Ryan',
    realisateur: 'Steven Spielberg',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/interstellar.jpg',
    title: 'Interstellar',
    realisateur: 'Christopher Nolan',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/inception.webp',
    title: 'Inception',
    realisateur: 'Christopher Nolan',
  ),
  MediaModel(
    imageUrl: 'assets/imgs/inglourious-basterds.jpg',
    title: 'Inglourious Basterds',
    realisateur: 'Quentin Tarantino',
  ),
];
