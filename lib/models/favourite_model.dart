class FavouriteModel {
  String? favouriteItemId;
  String? favouriteItemName;
  String? favouriteItemImage;
  int? favouriteItemPrice;
  String? favouriteItemDescription;

  FavouriteModel({
    this.favouriteItemId,
    this.favouriteItemName,
    this.favouriteItemImage,
    this.favouriteItemDescription,
    this.favouriteItemPrice,
  });
  FavouriteModel.fromMap(Map<String, dynamic> map) {
    favouriteItemId = map['favouriteItemId'];
    favouriteItemName = map['favouriteItemName'];
    favouriteItemImage = map['favouriteItemImage'];
    favouriteItemPrice = map['favouriteItemPrice'];
    favouriteItemDescription = map['favouriteItemDescription'];
  }
  Map<String, dynamic> toMap() {
    return {
      'favouriteItemId': favouriteItemId,
      'favouriteItemName': favouriteItemName,
      'favouriteItemImage': favouriteItemImage,
      'favouriteItemPrice': favouriteItemPrice,
      'favouriteItemDescription': favouriteItemDescription,
    };
  }
}
