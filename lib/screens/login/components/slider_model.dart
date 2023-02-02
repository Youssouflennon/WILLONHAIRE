class SliderModel {
  String? image;
  String? text;
  String? productImage;
  int? kBackgroundColor;

  SliderModel(this.image, this.text,
      this.productImage, this.kBackgroundColor);

  SliderModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    kBackgroundColor = json['kBackgroundColor'];
    text = json['text'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['kBackgroundColor'] = this.kBackgroundColor;
    data['text'] = this.text;
    data['productImage'] = this.productImage;
    return data;
  }
}

List<SliderModel> slides =
    slideData.map((item) => SliderModel.fromJson(item)).toList();

var slideData = [
  {
    "image": "assets/images/background-3.jpeg",
    "kBackgroundColor": 0xFF0088FF,
    "text": "Bienvenue chez WillOnHair",
    "productImage": "assets/images/logoWillOnHair.png"
  },
  {
    "image": "assets/images/background-2.jpeg",
    "kBackgroundColor": 0xFFAC0B4C,
    "text": "Bienvenue chez WillOnHair",
    "productImage": "assets/images/logoWillOnHair.png"
  }
];
