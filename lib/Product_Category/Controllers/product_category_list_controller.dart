import 'package:get/get.dart';
import 'package:unidoor_ecommerce/Product_Category/Models/product_category_list_models.dart';
import 'package:unidoor_ecommerce/Product_Category/Services/product_category_list_api.dart';

class ProductCategoryListController extends GetxController {
  var productCategoryList = RxList<Datum>().obs;
  var isChecked = false.obs;
  var isExpandedList = false.obs;

  @override
  void onInit() {
    super.onInit();
    print(" expandeble list = $isExpandedList");
    fetchProductCategoryList();
  }

  void fetchProductCategoryList() async {
    var productCategoryListJson =
        await ProductCategoryListAPI.getProductCategoryList();
    for (Datum datum in productCategoryListJson) {
      productCategoryList.value.add(datum);
    }
  }
}
