class CardModel {
  final int id;
  final String profileName;
  final String profileDesc;
  final String profileImage;
  final String desctiption;
  final String imagePath;
  final String createdAt;

  CardModel(this.id, this.profileName, this.profileDesc, this.profileImage,
      this.desctiption, this.imagePath, this.createdAt);
}

final List<CardModel> cards = [
  CardModel(
      1,
      'Agus Pacul',
      'Cijerah, Bandung Kulon, Bandung',
      'https://cdn.lorem.space/images/face/.cache/150x150/rachel-mcdermott-0fN7Fxv1eWA-unsplash.jpg',
      'Ini bukan sembarang kopi, Bung! Kehebatan kopi ini setidaknya bisa kita lihat dari riwayatnya.',
      'https://www.abadikini.com/media/files/2017/07/kopi-aroma-606x470.jpg',
      '2023-02-01 15:30'),
  CardModel(
      2,
      'Ujang Kored',
      'Babakan Asem, Conggeang, Sumedang',
      'https://cdn.lorem.space/images/face/.cache/150x150/reza-biazar-eSjmZW97cH8-unsplash.jpg',
      'Kegiatan perbaikan jalan di Desa Babakan Asem',
      'https://sumedangtandang.com/upload/foto/perbaikan_jalan.jpg',
      '2023-02-01 19:28'),
  CardModel(
      3,
      'Juned',
      'Cikondang, Bojongpicung, Cianjur',
      'https://api.lorem.space/image/face?w=150&h=150',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      'https://upload.wikimedia.org/wikipedia/commons/e/ec/Cikondang%2C_Bojongpicung%2C_Cianjur_Regency%2C_West_Java%2C_Indonesia_-_panoramio.jpg?20170416213049',
      '2023-02-01 20:17'),
];
