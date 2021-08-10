import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unidoor_ecommerce/AppBar/empty_appbar.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Controllers/register_business_name_controller.dart';
// import 'file:///Users/unilog/Documents/ashique/UniDoor/consumer_app_flutter_bur/lib/seller_account_registration/Controllers/business_name_controller.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Controllers/seller_business_type_controller.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Controllers/seller_category_controller.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Controllers/seller_delivery_mode_controller.dart';
import 'package:unidoor_ecommerce/seller_account_registration/Controllers/seller_upload_image_controller.dart';
import 'package:unidoor_ecommerce/widgets/header_static_content.dart';

class SellerRegistrationScreen extends StatelessWidget {
  // for business type drop down
  final SellerBusinessTypeController sellerBusinessTypeController =
      Get.put(SellerBusinessTypeController());

  // for delivery method dropdown
  final SellerDeliveryModeController sellerDeliveryModeController =
      Get.put(SellerDeliveryModeController());

  //for category dropdown
  final SellerCategoryController sellerCategoryController =
      Get.put(SellerCategoryController());

  // select the seller image from the device
  final UploadSellerImageController sellerImageController =
      Get.put(UploadSellerImageController());

  // for business name text box
  final RegisterBusinessNameController registerBusinessNameController =
      Get.put(RegisterBusinessNameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: EmptyAppBar(),
      appBar: AppBar(
        backgroundColor: kTransparent,
        elevation: kRadius,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: HeaderStaticContent(
                          headerText: "Create sellers account",
                        ),
                      ),
                      SizedBox(
                        height: kDefaultSize,
                      ),
                      Container(
                        width: 250,
                        height: 250,
                        padding: EdgeInsets.all(kDefaultPadding),
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Image(
                              height: 350,
                              width: 350,
                              image:
                                  AssetImage("assets/images/addnewimage.png"),
                            ),
                            Positioned(
                              top: 100.0,
                              left: 110,
                              right: 0,
                              height: 160,
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: SvgPicture.asset(
                                  'assets/images/cameraicon.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20.0,
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                child: Column(
                  children: [
                    Container(
                      height: 70.0,
                      padding: EdgeInsets.only(right: 30.0, left: 30.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        // maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Business Name",
                        ),
                        onChanged: (newValue) {
                          registerBusinessNameController
                              .getBusinessName(newValue);
                        },
                        style: TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2 - 10,
                              padding: EdgeInsets.only(left: 30.0),
                              // width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  prefixIcon: Center(
                                    child: DropdownButtonHideUnderline(
                                      child: Obx(
                                        () => DropdownButton(
                                          // iconSize: 0.0,
                                          itemHeight: 60,
                                          // onChanged: null,
                                          onChanged: (newValue) {
                                            // TODO : For selecting other countries
                                            print("Value ======$newValue====");
                                            sellerBusinessTypeController
                                                .setSelectedBusinessType(
                                                    newValue);
                                          },

                                          // value: sellerBusinessTypeController
                                          //     .sellerBusinessType.value,
                                          value: sellerBusinessTypeController
                                              .selectedBusinessType.value,
                                          items: sellerBusinessTypeController
                                              .sellerBusinessType.value
                                              .map((item) {
                                            // print("Item : $item");
                                            // print(category);
                                            print("item name = ${item.name}");
                                            return DropdownMenuItem<String>(
                                              value: item.name,
                                              child: Container(
                                                width: 150,
                                                //alignment: Alignment.center,
                                                child: Text(
                                                  "${item.name}",
                                                  // textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      color: kBlack),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          hint: Text("Type"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(right: 30.0),
                            // width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                  ),
                                ),
                                prefixIcon: Center(
                                  child: DropdownButtonHideUnderline(
                                    child: Obx(
                                      () => DropdownButton(
                                        itemHeight: 60,
                                        // iconSize: 0.0,
                                        // onChanged: null,
                                        onChanged: (newValue) {
                                          // TODO : For selecting other countries
                                          print("Value ======$newValue====");
                                          sellerDeliveryModeController
                                              .setSelectedDeliveryMode(
                                                  newValue);
                                        },

                                        // value: sellerBusinessTypeController
                                        //     .sellerBusinessType.value,
                                        value: sellerDeliveryModeController
                                            .selectedDeliveryMode.value,
                                        items: sellerDeliveryModeController
                                            .sellerDeliveryMode.value
                                            .map((item) {
                                          // print("Item : $item");
                                          // print(category);
                                          print("item name = ${item.name}");
                                          return DropdownMenuItem<String>(
                                            value: item.name,
                                            child: Container(
                                              width: 150,
                                              //alignment: Alignment.center,
                                              child: Text(
                                                "${item.name}",
                                                // textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 24.0,
                                                    color: kBlack),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text("Delivery method"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      // flex: 2,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 10,
                          padding: EdgeInsets.only(left: 30.0),
                          // width: MediaQuery.of(context).size.width / 2,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              prefixIcon: Center(
                                child: DropdownButtonHideUnderline(
                                  child: Obx(
                                    () => DropdownButton(
                                      itemHeight: 60,
                                      // iconSize: 0.0,
                                      // onChanged: null,
                                      onChanged: (newValue) {
                                        // TODO : For selecting other countries
                                        print("Value ======$newValue====");
                                        sellerCategoryController
                                            .setSelectedCategory(newValue);
                                      },

                                      // value: sellerBusinessTypeController
                                      //     .sellerBusinessType.value,
                                      value: sellerCategoryController
                                          .selectedCategory.value,
                                      items: sellerCategoryController
                                          .sellerCategory.value
                                          .map((item) {
                                        // print("Item : $item");
                                        // print(category);
                                        print("item name = ${item.name}");
                                        return DropdownMenuItem<String>(
                                          value: item.name,
                                          child: Container(
                                            width: 150,
                                            //alignment: Alignment.center,
                                            child: Text(
                                              "${item.name}",
                                              // maxLines: 1,
                                              // overflow: TextOverflow.fade,
                                              // softWrap: false,
                                              style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: kBlack),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Text("Category"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: MaterialButton(
                  // onPressed: () async {
                  //   await uploadImageController.submitAddress();
                  // Get.to(
                  //   HomeScreen(),
                  // );
                  // },
                  onPressed: () {
                    // Get.to(
                    //   HomeScreen(),
                    // );
                  },
                  child: Text("Submit".toUpperCase()),
                  height: 40.0,
                  minWidth: MediaQuery.of(context).size.width - 50,
                  color: Theme.of(context).primaryColor,
                  textColor: kWhiteColor,
                  elevation: 1.0,
                  splashColor: kTransparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        sellerImageController
                            .getSellerImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      sellerImageController.getSellerImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
