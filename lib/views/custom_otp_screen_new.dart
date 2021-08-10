import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class CustomOtpField extends StatelessWidget {
//   const CustomOtpField({Key key}) : super(key: key);
//
//   @override
//   _CustomOtpFieldState createState() => _CustomOtpFieldState();
// }
//
// class _CustomOtpFieldState extends State<CustomOtpField> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              height: 40,
              child: PinPut(
                withCursor: true,
                cursor: Container(
                  width: 1,
                  height: 25,
                  color: const Color.fromRGBO(27, 117, 12, 1),
                ),
                separatorPositions: [3],
                fieldsCount: 6,
                preFilledWidget: Center(
                  child: Container(
                    height: 1.5,
                    width: 16,
                    color: const Color.fromRGBO(112, 112, 112, 1),
                  ),
                ),
                eachFieldMargin: EdgeInsets.zero,
                onSubmit: (String pin) {},
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                onChanged: (String pin) {
                  if (pin.length == 6) {
                    // print("submitted");
                  }
                },
              ),
            ),
          ),
          Container(
            color: const Color.fromRGBO(27, 117, 12, 1),
            height: 3,
            width: double.infinity,
          ),
          const SizedBox(height: 16.0),
          Text(
            'Enter 6 digit code',
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
