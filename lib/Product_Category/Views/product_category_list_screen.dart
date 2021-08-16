import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/Product_Category/Controllers/product_category_list_controller.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/widgets/capitalize_string.dart';

class ProductCategoryListScreen extends StatelessWidget {
  ProductCategoryListController productCategoryListController =
      Get.put(ProductCategoryListController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            leadingWidth: 30,
            centerTitle: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select products",
                  textAlign: TextAlign.left,
                ),
                Text(
                  productCategoryListController.productCategoryList.value.length
                      .toString(),
                  style: TextStyle(fontSize: 14.0),
                )
              ],
            ),
            actions: [
              // productCategoryListController.productCategoryList
              //     .value[index].offerPercentage !=
              //     0.0?Image(
              //   image: AssetImage("assets/images/discount_icon.png"),
              // ):SizedBox.shrink(),
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Badge(
                  badgeColor: kWhiteColor,
                  badgeContent: Text(
                    '0',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: productCategoryListController
                      .productCategoryList.value.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image(
                                height: 100,
                                image: NetworkImage(
                                    productCategoryListController
                                        .productCategoryList
                                        .value[index]
                                        .imageUrl),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(5),
                            //   decoration: BoxDecoration(
                            //     color: Colors.green,
                            //     borderRadius: BorderRadius.all(
                            //       Radius.circular(20),
                            //     ),
                            //   ),
                            //   child: Text(
                            //     "Data",
                            //     style: TextStyle(color: kWhiteColor),
                            //   ),
                            // ),
                          ],
                        ),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  productCategoryListController
                                      .productCategoryList
                                      .value[index]
                                      .name
                                      .inCaps,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                productCategoryListController
                                                .productCategoryList
                                                .value[index]
                                                .cost %
                                            1 ==
                                        0
                                    ? Text(
                                        '\u{20B9} ${productCategoryListController.productCategoryList.value[index].cost.toInt()}/${productCategoryListController.productCategoryList.value[index].unit}',
                                        style: TextStyle(color: kPriceColor),
                                      )
                                    : Text(
                                        '\u{20B9} ${productCategoryListController.productCategoryList.value[index].cost}/${productCategoryListController.productCategoryList.value[index].unit}',
                                        style: TextStyle(color: kPriceColor),
                                      ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "\u{20B9} ${productCategoryListController.productCategoryList.value[index].strikedCost.toString()}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              child: productCategoryListController
                                          .productCategoryList
                                          .value[index]
                                          .description
                                          .length >
                                      15
                                  ? productCategoryListController
                                          .isExpandedList.value
                                      ? Row(
                                          children: [
                                            Text(
                                              productCategoryListController
                                                  .productCategoryList
                                                  .value[index]
                                                  .description
                                                  .substring(0, 20),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                productCategoryListController
                                                    .isExpandedList
                                                    .value = false;
                                                print(
                                                    "Expanded List = ${productCategoryListController.isExpandedList.value}");
                                              },
                                              child: Text(
                                                "..more".allInCaps,
                                                style: TextStyle(
                                                    color: kMoreOrLess),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                productCategoryListController
                                                    .productCategoryList
                                                    .value[index]
                                                    .description,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                productCategoryListController
                                                    .isExpandedList
                                                    .value = true;
                                                print(
                                                    "Expanded List = ${productCategoryListController.isExpandedList.value}");
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "less".allInCaps,
                                                    style: TextStyle(
                                                        color: kMoreOrLess),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons
                                                        .keyboard_arrow_up),
                                                    onPressed: () {
                                                      productCategoryListController
                                                          .isExpandedList
                                                          .value = true;
                                                      print(
                                                          "Expanded List = ${productCategoryListController.isExpandedList.value}");
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                  : Text(
                                      productCategoryListController
                                          .productCategoryList
                                          .value[index]
                                          .description,
                                    ),
                            ),
                          ],
                        ),
                        trailing: productCategoryListController
                                .productCategoryList.value[index].outOfStock
                            ? Text(
                                "Out of stock",
                                style: TextStyle(
                                    color: kOutOfStock,
                                    fontStyle: FontStyle.italic),
                              )
                            : Checkbox(
                                value: productCategoryListController
                                    .isChecked.value,
                                onChanged: (value) {}),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: productCategoryListController
                                        .productCategoryList
                                        .value[index]
                                        .offerPercentage !=
                                    0.0
                                ? Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: kOfferText,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      productCategoryListController
                                          .productCategoryList
                                          .value[index]
                                          .offerPercentage
                                          .toString(),
                                      style: TextStyle(color: kWhiteColor),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Divider(
                          thickness: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(30),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      color: kPrimaryColor,
                      onPressed: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Next",
                              style: TextStyle(color: kWhiteColor),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: kWhiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
