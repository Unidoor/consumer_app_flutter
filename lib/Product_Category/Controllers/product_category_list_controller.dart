import 'package:get/get.dart';
import 'package:unidoor_ecommerce/Product_Category/Models/product_category_list_models.dart';
import 'package:unidoor_ecommerce/Product_Category/Services/product_category_list_api.dart';

class ProductCategoryListController extends GetxController {
  var productCategoryList = RxList<Datum>().obs;
  var productCategoryPrimaryList = RxList<Datum>().obs;
  var productCategorySearchList = RxList<Datum>().obs;
  RxBool isProductSearchTapped = false.obs;
  RxString productSearchString = ''.obs;
  // var isChecked = false.obs;
  // var counterKg = 1.obs;
  // var counterGram = 500.obs;
  var isLoading = true.obs;
  var cartCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // isChecked.value = false;
    fetchProductCategoryList();
  }

  void clearProductSearchResult() {
    productCategoryList.value.clear();

    productCategoryPrimaryList.value.forEach((element) {
      productCategoryList.value.add(element);
    });
  }

  void fetchFilterProductsResults(String val) {
    productCategoryList.value.clear();

    final String filterProductString = val.toLowerCase();
    if (productCategoryPrimaryList != null) {
      final temProductFilterList = productCategoryPrimaryList.value
          .where((value) =>
              value.category.toLowerCase().contains(filterProductString))
          .toList();
      temProductFilterList.forEach((element) {
        productCategoryList.value.add(element);
      });
    } else {}
  }

  void fetchProductSearchResultsList(String val) {
    productCategoryList.value.clear();

    final String searchProductString = val.toLowerCase();

    if (productCategoryPrimaryList != null) {
      final tempProductSearchList = productCategoryPrimaryList.value
          .where(
              (value) => value.name.toLowerCase().contains(searchProductString))
          .toList();
      tempProductSearchList.forEach((element) {
        productCategoryList.value.add(element);
      });
    }
  }

  void fetchProductCategoryList() async {
    isLoading(true);
    var productCategoryListJson =
        await ProductCategoryListAPI.getProductCategoryList();
    // productCategoryListJson.forEach((element) {
    //   element.isChecked = isChecked.value;
    //   print("ischecked from controller = ${element.isChecked}");
    // });
    for (Datum datum in productCategoryListJson) {
      datum.isChecked = false;
      datum.quantityGram = 500;
      datum.quantityKg = 1;
      productCategoryList.value.add(datum);
      productCategoryPrimaryList.value.add(datum);
    }
    isLoading(false);
  }

  void refreshUi(bool value, int index) {
    productCategoryList.update((val) {
      productCategoryList.value.asMap().forEach((key, valu) {
        if (key == index) {
          print("value = $value index= $index");
          if (value) {
            cartCount.value = cartCount.value + 1;
          } else {
            if (cartCount.value == 0) {
              cartCount.value = 0;
            } else {
              cartCount.value = cartCount.value - 1;
            }
          }
          productCategoryList.value[index].isChecked = value;
        }
      });
      // productCategoryList.value
      //     .indexWhere((element) => element.isChecked = value, index);
    });
  }

  //Quantity Kilo Increment + button
  void countIncrementKg(int iKilo, index) {
    int kgCount = 0;
    if (iKilo >= 0) {
      kgCount = iKilo + 1;
      print("kilo incr = $kgCount");
    } else {
      kgCount = 0;
    }
    countKg(kgCount, index);
  }

////Quantity Gram Increment + button
  void countIncrementGram(int iGram, index) {
    int gramCount = 0;
    if (iGram >= 0 && iGram <= 900) {
      gramCount = iGram + 50;
    } else {
      gramCount = 50;
    }
    countGram(gramCount, index);
  }

  //Quantity Kilo Decrement - button
  void countDecrementKg(int dKilo, index) {
    int kgCount = 0;
    if (dKilo >= 1) {
      kgCount = dKilo - 1;
      print("kilo dec = $kgCount");
    } else {
      kgCount = 0;
    }

    countKg(kgCount, index);
  }

  //Quantity Gram Decrement - button
  void countDecrementGram(int dGram, index) {
    int gramCount = 0;
    if (dGram >= 50) {
      gramCount = dGram - 50;
    } else {
      gramCount = 0;
    }
    countGram(gramCount, index);
  }

  //Update quantity kilo to the model class
  void countKg(int kilo, int index) {
    productCategoryList.update((val) {
      productCategoryList.value.asMap().forEach((key, valu) {
        if (key == index) {
          if (kilo >= 0) {
            productCategoryList.value[index].quantityKg = kilo;
          } else {
            productCategoryList.value[index].quantityKg = 0;
          }
        }
      });
    });
  }

  // Update the Quantity gram to the model class
  void countGram(int gram, int index) {
    productCategoryList.update((val) {
      productCategoryList.value.asMap().forEach((key, valu) {
        if (key == index) {
          if (gram >= 50 || gram <= 999) {
            productCategoryList.value[index].quantityGram = gram;
          } else {
            productCategoryList.value[index].quantityGram = 0;
          }
        }
      });
    });
  }
}
