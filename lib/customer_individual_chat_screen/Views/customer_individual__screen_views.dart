// import 'package:camera/camera.dart';
// import 'package:chatapp/CustomUI/CameraUI.dart';
// import 'package:chatapp/CustomUI/OwnMessgaeCrad.dart';
// import 'package:chatapp/CustomUI/ReplyCard.dart';
// import 'package:chatapp/Model/ChatModel.dart';
// import 'package:chatapp/Model/MessageModel.dart';
// import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unidoor_ecommerce/customer_individual_chat_screen/Views/own_message_card.dart';
import 'package:unidoor_ecommerce/customer_individual_chat_screen/Views/reply_card.dart';

import '../../constants.dart';
import '../Models/message_model.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class CustomerIndividualChatScreen extends StatefulWidget {
  CustomerIndividualChatScreen({Key key, this.name, this.imageUrl, this.status})
      : super(key: key);
  final String name;
  final String imageUrl;
  final status;
  // final ChatModel sourchat;

  @override
  _CustomerIndividualChatScreenState createState() =>
      _CustomerIndividualChatScreenState();
}

class _CustomerIndividualChatScreenState
    extends State<CustomerIndividualChatScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  List<MessageModel> messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  // IO.Socket socket;
  @override
  void initState() {
    super.initState();
    // connect();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    // connect();
  }

  // void setMessage(String type, String message) {
  //   MessageModel messageModel = MessageModel(
  //       type: type,
  //       message: message,
  //       time: DateTime.now().toString().substring(10, 16));
  //   print(messages);
  //
  //   setState(() {
  //     messages.add(messageModel);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image.asset(
        //   "assets/whatsapp_Back.png",
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          //backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(widget.imageUrl),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      widget.status
                          ? Text(
                              "open",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            )
                          : Text(
                              "closed",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: kWhiteColor,
                  ),
                  child: Text(
                    'Follow',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // IconButton(icon: Icon(Icons.call), onPressed: () {}),
                // IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
                // IconButton(icon: Icon(Icons.call), onPressed: () {}),
                PopupMenuButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  padding: EdgeInsets.all(0),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext contesxt) {
                    return [
                      PopupMenuItem(
                        child: Text("dummy"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("dummy"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("dummy"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("dummy"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("dummy"),
                        value: "View Contact",
                      ),
                      PopupMenuItem(
                        child: Text("dummy"),
                        value: "View Contact",
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: () {
              //Get.to(NearBySellers());
            },
            backgroundColor: kPrimaryColor,
            child: Icon(
              Icons.shopping_cart,
              size: 30.0,
              color: kWhiteColor,
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     height: 70,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Container(
                  //               width: MediaQuery.of(context).size.width - 60,
                  //               child: Card(
                  //                 margin: EdgeInsets.only(
                  //                     left: 2, right: 2, bottom: 8),
                  //                 shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(25),
                  //                 ),
                  //                 child: TextFormField(
                  //                   controller: _controller,
                  //                   focusNode: focusNode,
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   keyboardType: TextInputType.multiline,
                  //                   maxLines: 5,
                  //                   minLines: 1,
                  //                   onChanged: (value) {
                  //                     if (value.length > 0) {
                  //                       setState(() {
                  //                         sendButton = true;
                  //                       });
                  //                     } else {
                  //                       setState(() {
                  //                         sendButton = false;
                  //                       });
                  //                     }
                  //                   },
                  //                   decoration: InputDecoration(
                  //                     border: InputBorder.none,
                  //                     hintText: "Type a message",
                  //                     hintStyle: TextStyle(color: Colors.grey),
                  //                     prefixIcon: IconButton(
                  //                       icon: Icon(
                  //                         show
                  //                             ? Icons.keyboard
                  //                             : Icons.emoji_emotions_outlined,
                  //                       ),
                  //                       onPressed: () {
                  //                         if (!show) {
                  //                           focusNode.unfocus();
                  //                           focusNode.canRequestFocus = false;
                  //                         }
                  //                         setState(() {
                  //                           show = !show;
                  //                         });
                  //                       },
                  //                     ),
                  //                     suffixIcon: Row(
                  //                       mainAxisSize: MainAxisSize.min,
                  //                       children: [
                  //                         IconButton(
                  //                           icon: Icon(Icons.attach_file),
                  //                           onPressed: () {
                  //                             showModalBottomSheet(
                  //                                 backgroundColor:
                  //                                     Colors.transparent,
                  //                                 context: context,
                  //                                 builder: (builder) =>
                  //                                     bottomSheet());
                  //                           },
                  //                         ),
                  //                         IconButton(
                  //                           icon: Icon(Icons.camera_alt),
                  //                           onPressed: () {
                  //                             // Navigator.push(
                  //                             //     context,
                  //                             //     MaterialPageRoute(
                  //                             //         builder: (builder) =>
                  //                             //             CameraApp()));
                  //                           },
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     contentPadding: EdgeInsets.all(5),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(
                  //                 bottom: 8,
                  //                 right: 2,
                  //                 left: 2,
                  //               ),
                  //               child: CircleAvatar(
                  //                 radius: 25,
                  //                 backgroundColor: Color(0xFF128C7E),
                  //                 child: IconButton(
                  //                   icon: Icon(
                  //                     sendButton ? Icons.send : Icons.mic,
                  //                     color: Colors.white,
                  //                   ),
                  //                   onPressed: () {
                  //                     if (sendButton) {
                  //                       _scrollController.animateTo(
                  //                           _scrollController
                  //                               .position.maxScrollExtent,
                  //                           duration:
                  //                               Duration(milliseconds: 300),
                  //                           curve: Curves.easeOut);
                  //                       // sendMessage(
                  //                       //     _controller.text,
                  //                       //     widget.sourchat.id,
                  //                       //     widget.chatModel.id);
                  //                       _controller.clear();
                  //                       setState(() {
                  //                         sendButton = false;
                  //                       });
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         // show ? emojiSelect() : Container(),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  // Widget emojiSelect() {
  //   return EmojiPicker(
  //       rows: 4,
  //       columns: 7,
  //       onEmojiSelected: (emoji, category) {
  //         print(emoji);
  //         setState(() {
  //           _controller.text = _controller.text + emoji.emoji;
  //         });
  //       });
  // }
}
