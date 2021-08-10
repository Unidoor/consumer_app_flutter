import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unidoor_ecommerce/NearBySeller/Views/near_by_sellers.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/HomeScreen/Controllers/tab_controller.dart';

import '../../seller_account_registration/Views/seller_registration_screen.dart';
// import 'package:unidoor_ecommerce/seller_account_registration/Views/seller_registration_screen.dart';

class HomeScreen extends StatelessWidget {
  int counter = 0;
  String label;
  final MyTabController _tabx = Get.put(MyTabController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: bottomButtons(),
      appBar: AppBar(
        title: Text(
          'Unidoor',
          style: TextStyle(fontSize: 24.0),
        ),
        actions: <Widget>[
          Container(
            width: 50.0,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 15.0),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Icon(
                    Icons.notifications,
                    size: 30.0,
                  ),
                  // Image(
                  //   height: 90,
                  //   width: 90,
                  //   image: AssetImage("assets/images/addnewimage.png"),
                  // ),
                  Positioned(
                    // right: 11,
                    top: 2,
                    left: 15,
                    // top: 11,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '$counter',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.share,
              size: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.search,
              size: 30.0,
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
        bottom: TabBar(
          controller: _tabx.controller,
          tabs: _tabx.myTabs,
          onTap: (index) {
            _tabx.getTabIndex(index);
            print(" index = $index");
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabx.controller,
              children: _tabx.myTabs.map((Tab tab) {
                label = tab.text.toLowerCase();

                //label == "left" ? _tabx.getTabIndex(0) : _tabx.getTabIndex(1);
                print(" label: ${label}");

                return Obx(
                  () => _tabx.tabIndex.value == 0
                      ? Padding(
                          padding: const EdgeInsets.all(60.0),
                          child: Center(
                            child: Text(
                              'To add shops, tap + at the bottom of your screen',
                              style: TextStyle(
                                  fontSize: 24, color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SvgPicture.asset(
                                  'assets/images/seller_home_screen_icon.svg',
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 80, right: 80, top: 10),
                                child: Text(
                                  "Unidoor offers you the flexibility to sell your own and other products.",
                                  style: TextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 100),
                                child: MaterialButton(
                                  // onPressed: () async {
                                  //   await uploadImageController.submitAddress();
                                  // Get.to(
                                  //   HomeScreen(),
                                  // );
                                  // },
                                  onPressed: () {
                                    Get.to(SellerRegistrationScreen());
                                  },
                                  child: Text("Start selling"),
                                  height: 40.0,
                                  minWidth:
                                      MediaQuery.of(context).size.width - 50,
                                  color: Theme.of(context).primaryColor,
                                  textColor: kWhiteColor,
                                  elevation: 1.0,
                                  splashColor: kTransparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomButtons() {
    return Obx(
      () => _tabx.tabIndex.value == 0
          ? FloatingActionButton(
              shape: StadiumBorder(),
              onPressed: () {
                Get.to(NearBySellers());
              },
              backgroundColor: kPrimaryColor,
              child: Icon(
                Icons.add,
                size: 20.0,
                color: kWhiteColor,
              ),
            )
          : Text(""),
      // FloatingActionButton(
      //         shape: StadiumBorder(),
      //         onPressed: () {
      //           Get.to(SellerRegistrationScreen());
      //         },
      //         backgroundColor: kPrimaryColor,
      //         child: Icon(
      //           Icons.add,
      //           color: kWhiteColor,
      //           size: 20.0,
      //         ),
      //       ),
    );
  }
}
