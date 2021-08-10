import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unidoor_ecommerce/HomeScreen/Views/home_screen.dart';
import 'package:unidoor_ecommerce/LocationScreen/Views/loction_screen.dart';
import 'package:unidoor_ecommerce/constants.dart';
import 'package:unidoor_ecommerce/RegisterScreen/Controllers/FCM_controller.dart';
import 'package:unidoor_ecommerce/RegisterScreen/Controllers/register_name_controller.dart';
import 'package:unidoor_ecommerce/RegisterScreen/Controllers/upload_image_controller.dart';
import 'package:unidoor_ecommerce/widgets/header_static_content.dart';

import '../../AppBar/empty_appbar.dart';

UploadImageController uploadImageController = Get.put(UploadImageController());

class AddressRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerNameController = Get.put(RegisterNameController());
    final fcmToken = Get.put(FCMController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: HeaderStaticContent(
                            headerText: "Choose your address details",
                          ),
                        ),
                        SizedBox(
                          height: kDefaultSize,
                        ),
                        Container(
                          child: SvgPicture.asset(
                              'assets/images/illustration_address.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(kDefaultPadding),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Image(
                            height: 90,
                            width: 90,
                            image: AssetImage("assets/images/addnewimage.png"),
                          ),
                          Positioned(
                            top: 50.0,
                            left: 50,
                            right: 0,
                            height: 60,
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
                    Flexible(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: kTransparent,
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: kLightColor),
                        ),
                        padding: EdgeInsets.only(left: 10.0),
                        margin: EdgeInsets.only(right: 30.0),
                        child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "House/Store name",
                            ),
                            onChanged: (newValue) {
                              registerNameController.getName(newValue);
                              print("FCM Token: $fcmToken");
                            },
                            // onChanged: (newValue),
                            style:
                                TextStyle(fontSize: 18.0, letterSpacing: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20.0,
                // ),
                MaterialButton(
                  onPressed: () async {
                    // await uploadImageController.submitAddress();
                    Get.to(
                      LocationScreen(),
                    );
                  },
                  // onPressed: () {
                  //   Get.to(
                  //     HomeScreen(),
                  //   );
                  // },
                  child: Text("Add address".toUpperCase()),
                  height: 40.0,
                  minWidth: MediaQuery.of(context).size.width - 50,
                  color: Theme.of(context).primaryColor,
                  textColor: kWhiteColor,
                  elevation: 1.0,
                  splashColor: kTransparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
                      uploadImageController.getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    uploadImageController.getImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
