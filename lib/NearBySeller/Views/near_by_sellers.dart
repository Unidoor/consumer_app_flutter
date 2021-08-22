import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/NearBySeller/Controllers/near_by_seller_controller.dart';
import 'package:unidoor_ecommerce/NearBySeller/Models/status_list.dart';
import 'package:unidoor_ecommerce/NearBySeller/Views/seller_rating_stars.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/customer_individual_chat_screen/Views/customer_individual__screen_views.dart';
import 'package:logger/logger.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Controllers/seller_category_controller.dart';
import 'package:unidoor_ecommerce/widgets/capitalize_string.dart';

var statusList = {
  0: ['Williams Anders', 'images/boy.png', 3.0, 4.5, '1 minute ago', false],
  1: [
    'Mom',
    'images/cliffside-unsplash.jpg',
    1.0,
    0.0,
    '20 minutes ago',
    false
  ],
  2: ['Hannah', 'images/woman2.png', 5.0, 2.5, '28 minutes ago', false],
  3: ['Dad', 'images/man.png', 2.0, 3.5, '53 minutes ago', false],
  4: [
    'Cayne Don',
    'images/flower.jpg',
    4.0,
    3.0,
    'Today 04:30 pm',
    false,
  ],
  5: [
    'Abby Gale',
    'images/plant-unsplash.jpg',
    1.0,
    0.0,
    'Today 03.30 pm',
    false
  ],
};
final NearBySellerController nearBySellerController =
    Get.put(NearBySellerController());
final SellerCategoryController sellerCategoryController =
    Get.put(SellerCategoryController());

class NearBySellers extends StatelessWidget {
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      nearBySellerController.sellerNearBySearchList.value.forEach((element) {
        print('${element.name}');
      });
      print(nearBySellerController.searchString.value);
      // print(
      //     "length= ${nearBySellerController.sellerNearBySearchList.value.length != 0 ? nearBySellerController.sellerNearBySearchList.value[0].name : 'no value '}");

      return Scaffold(
        floatingActionButton: bottomButtons(),
        appBar: AppBar(
          backgroundColor: nearBySellerController.isSearchTapped.value
              ? Colors.white
              : Theme.of(context).primaryColor,
          leading: nearBySellerController.isSearchTapped.value
              ? IconButton(
                  onPressed: () {
                    nearBySellerController.clearSearchResult();
                    nearBySellerController.isSearchTapped.value = false;
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                  ),
                )
              : null,
          title: nearBySellerController.isSearchTapped.value
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(border: InputBorder.none),
                  onChanged: (String value) {
                    nearBySellerController.searchString.value = value;
                    nearBySellerController.fetchSearchResults(value);
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Add shops',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
          actions: nearBySellerController.isSearchTapped.value
              ? null
              : <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        size: 30.0,
                      ),
                      onPressed: () {
                        displayModalBottomSheet(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      onPressed: () =>
                          nearBySellerController.isSearchTapped.value = true,
                      icon: Icon(
                        Icons.search,
                        size: 30.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 30.0,
                    ),
                  ),
                ],
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: nearBySellerController.isLoading.value != true
                    ? ListView.builder(
                        itemCount: nearBySellerController
                            .sellerNearByList.value.length,
                        itemBuilder: (context, i) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) =>
                                        CustomerIndividualChatScreen(
                                            name: nearBySellerController
                                                .sellerNearByList.value[i].name,
                                            imageUrl: nearBySellerController
                                                .sellerNearByList
                                                .value[i]
                                                .imageUrl,
                                            status: nearBySellerController
                                                .sellerNearByList
                                                .value[i]
                                                .open)));
                          },
                          child: Column(
                            children: <Widget>[
                              // new Divider(
                              //   height: 10.0,
                              // ),
                              ListTile(
                                leading: DottedBorder(
                                  color: Colors.teal.shade300,
                                  borderType: BorderType.Circle,
                                  radius: Radius.circular(27),
                                  dashPattern: [
                                    i > 4
                                        ? (2 * pi * 27) /
                                            statusList.values
                                                .elementAt(i - 5)
                                                .elementAt(2)
                                        : (2 * pi * 27) /
                                            statusList.values
                                                .elementAt(i)
                                                .elementAt(2),
                                    i > 4
                                        ? statusList.values
                                            .elementAt(i - 5)
                                            .elementAt(3)
                                        : statusList.values
                                            .elementAt(i)
                                            .elementAt(3),
                                  ],
                                  strokeWidth: 3,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: Colors.transparent,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          nearBySellerController
                                              .sellerNearByList
                                              .value[i]
                                              .imageUrl),
                                    ),
                                  ),
                                ),
                                // CircleAvatar(
                                //   foregroundColor:
                                //       Theme.of(context).primaryColor,
                                //   backgroundColor: Colors.grey,
                                //   backgroundImage: NetworkImage(
                                //       nearBySellerController
                                //           .sellerNearByList.value[i].imageUrl),
                                // ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        nearBySellerController
                                            .sellerNearByList.value[i].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            new Text(
                                              "${nearBySellerController.sellerNearByList.value[i].distance.toStringAsFixed(2)} KM",
                                              style: new TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                        StarDisplayWidget(
                                          value: 3,
                                          // value:nearBySellerController.sellerNearByList.value[i].rating.toInt(),
                                          filledStar: Icon(Icons.star,
                                              color: kRatingStart, size: 18),
                                          unfilledStar: Icon(
                                            Icons.star,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: new Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: new Text(
                                    nearBySellerController
                                        .sellerNearByList.value[i].address
                                        .toString(),
                                    style: new TextStyle(
                                        color: Colors.grey, fontSize: 15.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget bottomButtons() {
    return FloatingActionButton(
      shape: StadiumBorder(),
      onPressed: () {
        Get.back();
      },
      backgroundColor: kPrimaryColor,
      child: Icon(
        Icons.arrow_back,
        size: 20.0,
        color: kWhiteColor,
      ),
    );
  }

  Widget fliterListItems() {
    return FloatingActionButton(
      shape: StadiumBorder(),
      onPressed: () {
        Get.back();
      },
      backgroundColor: kPrimaryColor,
      child: Icon(
        Icons.arrow_back,
        size: 20.0,
        color: kWhiteColor,
      ),
    );
  }
}

void displayModalBottomSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                child: Obx(
                  () => nearBySellerController.isLoading.value != true
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sellerCategoryController
                              .sellerCategory.value.length,
                          itemBuilder: (context, i) => InkWell(
                            onTap: () {
                              nearBySellerController.searchString.value =
                                  sellerCategoryController
                                      .sellerCategory.value[i].name;
                              nearBySellerController.fetchFilterResults(
                                  sellerCategoryController
                                      .sellerCategory.value[i].name);
                              print(
                                  "selcted category: ${sellerCategoryController.sellerCategory.value[i].name}");
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(
                                        sellerCategoryController
                                            .sellerCategory.value[i].imageUrl),
                                  ),
                                  Text(
                                    sellerCategoryController
                                        .sellerCategory.value[i].name.inCaps,
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
