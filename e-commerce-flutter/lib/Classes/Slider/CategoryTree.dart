import 'Category.dart';
import 'SubCategory.dart';

final String kidChild1 = "https://comps.canstockphoto"
    ".com/happy-kids-with-shopping-bags-stock-photo_csp15675329.jpg";
final String kidChild2 = "https://previews.123rf"
    ".com/images/photosvit/photosvit1806/photosvit180606241/103683740-change-my-style-child-cute-fashionista-shopping-kid-happy-shopping-in-mall-kid-girl-happy-smiling-fa.jpg";
final String kidChild3 = "https://d1jsfzvla7f7c6.cloudfront"
    ".net/contents/PL_Y4_Y5_TIPS_115.jpg";
final String kidChild4 = "https://previews.123rf"
    ".com/images/prometeus/prometeus1705/prometeus170500271/77756097-happy-little-girl-goes-shopping-kid-s-fashion-modern-children-seasonal-sale-shopping-.jpg";

final String womanChild1 = "https://image.freepik"
    ".com/free-photo/happy-young-woman-shopping_1098-1119.jpg";
final String womanChild2 = "https://previews.123rf"
    ".com/images/hasloo/hasloo1407/hasloo140700505/29846097-woman-shopping-concept-collage-with-different-shopping-symbols-around-girl.jpg";
final String womanChild3 = "https://previews.123rf"
    ".com/images/elenathewise/elenathewise1012/elenathewise101200085/8436658-young-smiling-black-woman-holding-colorful-shopping-bags.jpg";
final String womanChild4 = "https://previews.123rf"
    ".com/images/piksel/piksel1606/piksel160600017/57753581-woman-shopping-in-a-clothing-store.jpg";

final String manChild1 = "https://previews.123rf"
    ".com/images/asjack/asjack1601/asjack160100172/50579952-handsome-man-in-suit-with-shopping-bag.jpg";
final String manChild2 =
    "https://2w6kxc22rrr9mabqt1mglgait6-wpengine.netdna-ssl.com/wp-content/uploads/2017/12/man-shopping-1024x580.jpg";
final String manChild3 =
    "https://lh3.googleusercontent.com/proxy/HN04A6DPEJxFcgFp_mPMGn3WAWle_XtGA9C0V3lTGxesGhUw6LNX8Z4Ca1fO0vZCYsrnEYb1wtjnY51MdIOj8sc_esPOmN2drJnaIyNolHEe5WCOVrAgha-U_YVM_5s28h4bPIXYTy7x6hADoH2Wior99IfQ_w_VLByjK744Ldbw6Q4YYKg";
final String manChild4 =
    "https://blogstoread.com/wp-content/uploads/2018/09/mens-fashion.jpg";

final String manImage =
    "https://cdn.shoplightspeed.com/shops/614394/files/16602530/hensleys-custom-shirt-for-the-sharp-dressed-man.jpg";
final String womanImage =
    "https://i.udemycdn.com/course/750x422/1302526_a118_4.jpg";
final String childImage =
    "https://www.verywellfamily.com/thmb/9qRaXCymQpgBu1-q4gNMRBidkNg=/500x350/filters:no_upscale():max_bytes(150000):strip_icc()/184224077-56a777d25f9b58b7d0eabd26.jpg";

class CategoryTree {
  List<Category> tree;

  CategoryTree({this.tree});

  getCategoryList() {
    return this.tree;
  }
}
