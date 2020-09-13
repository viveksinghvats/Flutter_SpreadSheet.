class ProductDetail {
  String title;
  String variant;
  String quantity;
  String price;

  ProductDetail(this.title, this.variant, this.quantity, this.price);

  factory ProductDetail.fromJson(dynamic json) {
    return ProductDetail("${json['title']}", "${json['variant']}",
        "${json['quantity']}", "${json['price']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'title': title,
        'variant': variant,
        'quantity': quantity,
        'price': price
      };
}

class CurrentLocation {
  String latitude;
  String longitude;
  CurrentLocation(this.longitude, this.latitude);
  factory CurrentLocation.fromJson(dynamic json) {
    return CurrentLocation(
      "${json['longitude']}",
      "${json['latitude']}",
    );
  }
  Map toJson() => {
        'longitude': longitude,
        'latitude': latitude,
      };
}
