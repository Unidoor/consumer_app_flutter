import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:unidoor_ecommerce/Product_Category/Controllers/product_category_list_controller.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/widgets/capitalize_string.dart';

ProductCategoryListController productCategoryListController =
    Get.put(ProductCategoryListController());
List deliveryList = ["Delivery", "Self Pickup"];

class ProductCategoryListScreen extends StatelessWidget {
  final lessIcon = String.fromCharCode(0xe356);
  bool isOfferAvail = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      isOfferAvail = productCategoryListController.productCategoryList.value
          .toList()
          .where((element) => element.offerPercentage > 0.0)
          .toList()
          .isNotEmpty;
      return Scaffold(
        appBar: AppBar(
          backgroundColor:
              productCategoryListController.isProductSearchTapped.value
                  ? kWhiteColor
                  : kPrimaryColor,
          leadingWidth: 30,
          centerTitle: false,
          leading: productCategoryListController.isProductSearchTapped.value
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: kLightColor,
                  ),
                  onPressed: () {
                    productCategoryListController.clearProductSearchResult();
                    productCategoryListController.isProductSearchTapped.value =
                        false;
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: kWhiteColor,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
          title: productCategoryListController.isProductSearchTapped.value
              ? TextField(
                  autofocus: true,
                  onChanged: (val) {
                    productCategoryListController.productSearchString.value =
                        val;
                    productCategoryListController
                        .fetchProductSearchResultsList(val);
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select products",
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "${productCategoryListController.productCategoryList.value.length.toString()} products",
                      style: TextStyle(fontSize: 14.0),
                    )
                  ],
                ),
          actions: productCategoryListController.isProductSearchTapped.value
              ? null
              : <Widget>[
                  isOfferAvail
                      ? Image(
                          image: AssetImage("assets/images/discount_icon.png"),
                        )
                      : SizedBox.shrink(),
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                    ),
                    onPressed: () {
                      displayModalBottomSheet(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      productCategoryListController
                          .isProductSearchTapped.value = true;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Badge(
                      badgeColor: kWhiteColor,
                      badgeContent: Container(
                        child: Text(
                          '${productCategoryListController.cartCount.value}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
        ),
        body: !productCategoryListController.isLoading.value
            ? SafeArea(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      child: ListView.builder(
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
                                ],
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productCategoryListController
                                            .productCategoryList
                                            .value[index]
                                            .name
                                            .inCaps,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
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
                                              style:
                                                  TextStyle(color: kPriceColor),
                                            )
                                          : Text(
                                              '\u{20B9} ${productCategoryListController.productCategoryList.value[index].cost}/${productCategoryListController.productCategoryList.value[index].unit}',
                                              style:
                                                  TextStyle(color: kPriceColor),
                                            ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "\u{20B9} ${productCategoryListController.productCategoryList.value[index].strikedCost.toString()}",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ReadMoreText(
                                    productCategoryListController
                                        .productCategoryList
                                        .value[index]
                                        .description,
                                    trimLines: 1,
                                    style: TextStyle(color: kBlack),
                                    colorClickableText: kMoreOrLess,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'MORE',
                                    trimExpandedText: 'LESS',
                                  ),
                                  // Container(
                                  //   child: productCategoryListController
                                  //               .productCategoryList
                                  //               .value[index]
                                  //               .description
                                  //               .length >
                                  //           15
                                  //       ? productCategoryListController
                                  //               .isExpandedList.value
                                  //           ? Row(
                                  //               children: [
                                  //                 Text(
                                  //                   productCategoryListController
                                  //                       .productCategoryList
                                  //                       .value[index]
                                  //                       .description
                                  //                       .substring(0, 20),
                                  //                   maxLines: 1,
                                  //                   overflow: TextOverflow.ellipsis,
                                  //                   softWrap: false,
                                  //                 ),
                                  //                 InkWell(
                                  //                   onTap: () {
                                  //                     productCategoryListController
                                  //                         .isExpandedList
                                  //                         .value = false;
                                  //                     print(
                                  //                         "Expanded List = ${productCategoryListController.isExpandedList.value}");
                                  //                   },
                                  //                   child: Text(
                                  //                     "..more".allInCaps,
                                  //                     style: TextStyle(
                                  //                         color: kMoreOrLess),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           : Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.end,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.end,
                                  //               children: [
                                  //                 Expanded(
                                  //                   child: Text(
                                  //                     productCategoryListController
                                  //                         .productCategoryList
                                  //                         .value[index]
                                  //                         .description,
                                  //                   ),
                                  //                 ),
                                  //                 InkWell(
                                  //                     onTap: () {
                                  //                       productCategoryListController
                                  //                           .isExpandedList
                                  //                           .value = true;
                                  //                       print(
                                  //                           "Expanded List = ${productCategoryListController.isExpandedList.value}");
                                  //                     },
                                  //                     child: RichText(
                                  //                       text: TextSpan(
                                  //                         text: 'less'.allInCaps,
                                  //                         style: TextStyle(
                                  //                           color: kMoreOrLess,
                                  //                           fontSize: 18.0,
                                  //                         ),
                                  //                         children: [
                                  //                           TextSpan(
                                  //                             text:
                                  //                                 String.fromCharCode(
                                  //                                     0xe356),
                                  //                             style: TextStyle(
                                  //                               fontFamily:
                                  //                                   'MaterialIcons', //<-- fontFamily
                                  //                               fontSize: 18.0,
                                  //                               color: kMoreOrLess,
                                  //                             ),
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     )
                                  //                     // Text(
                                  //                     //   "less {0xe356}".allInCaps,
                                  //                     //   style: TextStyle(
                                  //                     //       color: kMoreOrLess),
                                  //                     // ),
                                  //                     ),
                                  //               ],
                                  //             )
                                  //       : Text(
                                  //           productCategoryListController
                                  //               .productCategoryList
                                  //               .value[index]
                                  //               .description,
                                  //         ),
                                  // ),
                                ],
                              ),
                              trailing: productCategoryListController
                                      .productCategoryList
                                      .value[index]
                                      .outOfStock
                                  ? Container(
                                      width: 60,
                                      child: Text(
                                        "Out of stock",
                                        style: TextStyle(
                                            color: kOutOfStock,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return ClipRRect(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(2),
                                            ),
                                            child: SizedBox(
                                              width: Checkbox.width,
                                              height: Checkbox.width,
                                              child: Container(
                                                decoration: new BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          3),
                                                ),
                                                child: Theme(
                                                  data: ThemeData(
                                                    unselectedWidgetColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: Checkbox(
                                                    // value: _isChecked[index],
                                                    value:
                                                        productCategoryListController
                                                            .productCategoryList
                                                            .value[index]
                                                            .isChecked,
                                                    activeColor: kPrimaryColor,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        productCategoryListController
                                                            .productCategoryList
                                                            .value[index]
                                                            .isChecked = value;
                                                        productCategoryListController
                                                            .refreshUi(
                                                                value, index);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                productCategoryListController
                                            .productCategoryList
                                            .value[index]
                                            .offerPercentage !=
                                        0.0
                                    ? Flexible(
                                        flex: 6,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 15, left: 20),
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: kOfferText,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            "${productCategoryListController.productCategoryList.value[index].offerPercentage.toString()}% OFF",
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 12.0),
                                          ),
                                        ),
                                      )
                                    : Flexible(
                                        flex: 6,
                                        child: Container(
                                          width: 90,
                                        ),
                                      ),
                                productCategoryListController
                                            .productCategoryList
                                            .value[index]
                                            .isChecked &&
                                        !productCategoryListController
                                            .productCategoryList
                                            .value[index]
                                            .outOfStock
                                    ? Flexible(
                                        flex: 3,
                                        child: Container(
                                          // padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: kQuantityButton),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    productCategoryListController
                                                        .countDecrementKg(
                                                            productCategoryListController
                                                                .productCategoryList
                                                                .value[index]
                                                                .quantityKg,
                                                            index);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: kQuantityButton,
                                                    size: 16,
                                                  )),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2, vertical: 3),
                                                decoration: BoxDecoration(
                                                    // borderRadius: BorderRadius.circular(3),
                                                    color: kQuantityButton),
                                                child: Text(
                                                  '${productCategoryListController.productCategoryList.value[index].quantityKg} kg',
                                                  style: TextStyle(
                                                      color: kWhiteColor,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    productCategoryListController
                                                        .countIncrementKg(
                                                            productCategoryListController
                                                                .productCategoryList
                                                                .value[index]
                                                                .quantityKg,
                                                            index);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: kQuantityButton,
                                                    size: 16,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(
                                  width: 10,
                                ),
                                productCategoryListController
                                            .productCategoryList
                                            .value[index]
                                            .isChecked &&
                                        !productCategoryListController
                                            .productCategoryList
                                            .value[index]
                                            .outOfStock
                                    ? Flexible(
                                        flex: 4,
                                        child: Container(
                                          // padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: kQuantityButton),
                                              color: Theme.of(context)
                                                  .accentColor),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    productCategoryListController
                                                        .countDecrementGram(
                                                            productCategoryListController
                                                                .productCategoryList
                                                                .value[index]
                                                                .quantityGram,
                                                            index);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: kQuantityButton,
                                                    size: 16,
                                                  )),
                                              Center(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 3),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                      // borderRadius: BorderRadius.circular(3),
                                                      color: kQuantityButton),
                                                  child: Text(
                                                    '${productCategoryListController.productCategoryList.value[index].quantityGram} g',
                                                    style: TextStyle(
                                                        color: kWhiteColor,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    productCategoryListController
                                                        .countIncrementGram(
                                                            productCategoryListController
                                                                .productCategoryList
                                                                .value[index]
                                                                .quantityGram,
                                                            index);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: kQuantityButton,
                                                    size: 16,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox.shrink(),
                                Flexible(flex: 3, child: Container())
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 1.5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          color: kPrimaryColor,
                          onPressed: () {
                            selectDeliveryMode(context);
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: TextStyle(color: kWhiteColor),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    });
  }
}

void selectDeliveryMode(context) {
  // List deliveryItems = ["delivery", "self pickup"];
  showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(
                      2,
                      (int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "${deliveryList[index]}",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              trailing: Radio<int>(
                                value: index,
                                groupValue: selectedRadio,
                                onChanged: (int value) {
                                  setState(() => selectedRadio = value);
                                },
                                activeColor: kPrimaryColor,
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Confirm"),
                  ),
                ],
              );
            },
          ),
        );
      });
}

void displayModalBottomSheet(context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 180,
          margin: EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => productCategoryListController.isLoading.value != true
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productCategoryListController
                              .productCategoryPrimaryList.value.length,
                          itemBuilder: (context, i) => InkWell(
                            onTap: () {
                              productCategoryListController
                                      .productSearchString.value =
                                  productCategoryListController
                                      .productCategoryPrimaryList.value[i].name;
                              productCategoryListController
                                  .fetchFilterProductsResults(
                                      productCategoryListController
                                          .productCategoryPrimaryList
                                          .value[i]
                                          .category);
                              print(
                                  "selcted category: ${productCategoryListController.productCategoryList.value[i].name}");
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                        productCategoryListController
                                            .productCategoryPrimaryList
                                            .value[i]
                                            .imageUrl),
                                  ),
                                  Text(
                                    productCategoryListController
                                        .productCategoryPrimaryList
                                        .value[i]
                                        .name
                                        .inCaps,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontSize: 18, color: kBlack),
                                  ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ],
          ),
        );
      });
}
