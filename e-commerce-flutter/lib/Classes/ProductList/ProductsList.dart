import 'package:oneaddress/Classes/ProductList/Product.dart';
import 'package:oneaddress/Classes/ProductList/ProductGroup.dart';

final String pg1MainImage = "https://mallenbaker.net/perch/resources/zara2.jpg";
final String pg1Color1Image =
    "https://i.pinimg.com/originals/87/aa/d5/87aad5ffd9258406ab6006e036841b1f.jpg";
final String pg1Color2Image =
    "https://effortlesstyle.com/wp-content/uploads/2014/12/2753242704_1_1_1.jpg";
final String pg1Color3Image =
    "https://effortlesstyle.com/wp-content/uploads/2014/12/2753242704_1_1_1.jpg";
final String pg2MainImage =
    "https://cdn.shopify.com/s/files/1/0027/3367/0473/products/LS-6042-Wine_7_1480x_d79dc908-c9df-4766-88f3-eedf6dec629f_2000x.jpg?v=1567527088";
final String pg2Color1Image = "https://cdn.shopify"
    ".com/s/files/1/0027/3367/0473/products/IMG_5095_2000x.JPG?v=1571244245s";
final String pg2Color2Image =
    "https://i.pinimg.com/originals/08/42/51/08425161e15fe81007bdd6116bc66f1c.jpg";
final String pg2Color3Image =
    "https://i.pinimg.com/originals/29/08/3c/29083cefb386b762373362de8388f78d.jpg";
final String pg2Color4Image =
    "https://images-na.ssl-images-amazon.com/images/I/71niS7BThEL._AC_UY550_.jpg";

//images for Coats
final String coat1 = "http://cdn.aboutstatic"
    ".com/file/ef2ad6d864ddec5a9491d6cbceef6ad7?quality=70&progressive=1&width=800&height=800&trim=1&brightness=0.95";
final String coat2 =
    "http://cdn.aboutstatic.com/file/3a0de67d9f0e21723ddc8359efffd73b?quality=70&progressive=1&width=800&height=800";
final String coat3 =
    "http://cdn.aboutstatic.com/file/01378a3470c1be4c44c6d95f9efdedc0?quality=70&progressive=1&width=800&height=800";
final String coat4 =
    "http://cdn.aboutstatic.com/file/f7a58fa52963fafda562742738ccf3e0?quality=70&progressive=1&width=800&height=800";
final String coat5 =
    "http://cdn.aboutstatic.com/file/43a3150333f8dd3b6bec6f83b6798ea4?quality=70&progressive=1&width=800&height=800";

//images for jackets
final String jacket1 =
    "https://i.factcool.com/cache2/1400x1400/catalog/products/90/90ceac_woox-button-orange.jpg";
final String jacket2 =
    "https://i.factcool.com/cache2/1400x1400/catalog/products/75/754fc0_woox-button-orange-2.jpg";
final String jacket3 =
    "https://i.factcool.com/cache2/1400x1400/catalog/products/82/8214a7_woox-button-orange-3.jpg";
final String jacket4 =
    "https://i.factcool.com/cache2/1400x1400/catalog/products/62/62b436_aaa.jpg";
final String jacket5 =
    "https://i.factcool.com/cache2/1400x1400/catalog/products/43/431153_aaaa.jpg";

class ProductsList {
  List<ProductGroup> products;

  ProductsList({this.products});

  List<ProductGroup> getProductList() {
    return this.products;
  }
}
