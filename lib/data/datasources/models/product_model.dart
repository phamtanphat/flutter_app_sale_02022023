class Product {
  String id = "";
  String name = "";
  String address = "";
  num price = 0;
  String imageUrl = "";
  num quantity = 0;
  List<String> gallery =  List.empty();

  Product(
      this.id,
      this.name,
      this.address,
      this.price,
      this.imageUrl,
      this.quantity,
      this.gallery
  );
}