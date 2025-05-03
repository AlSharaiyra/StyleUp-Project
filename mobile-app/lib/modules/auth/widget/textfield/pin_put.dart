import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/modules/auth/bloc/otp/pin_code_controller.dart';
import 'package:style_up/modules/auth/bloc/otp/pin_code_event.dart';
import 'package:style_up/modules/auth/bloc/otp/pin_code_state.dart';
import 'dart:developer' as developer;

class PinCodeTextField extends StatelessWidget {
  PinCodeTextField({super.key});

  final List<FocusNode> _focusNodes =
      List.generate(4, (int index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (int index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.17;
    developer.log(Localizations.localeOf(context).languageCode);
    return Directionality(
      textDirection: Localizations.localeOf(context).languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.ltr,
      child: BlocBuilder<PinCodeController, PinCodeState>(
        builder: (BuildContext context, PinCodeState pinCodes) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (int index) {
              return Container(
                width: width,
                height: width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(
                        1), // Limit input to 1 character
                  ],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    labelText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide(
                        color: _controllers[index].text.isNotEmpty
                            ? ColorsTheme.black
                            : ColorsTheme.greyBorder,
                      ),
                    ),
                  ),
                  onChanged: (String value) {
                    developer.log(index.toString());
                    if (value.isNotEmpty) {
                      _controllers[index].selection =
                          TextSelection.fromPosition(TextPosition(
                              offset: _controllers[index].text.length));

                      if (index < 3) {
                        Future.delayed(Duration(milliseconds: 100), () {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        });
                      }
                    }
                    if (_controllers[0].text != '' &&
                        _controllers[1].text != '' &&
                        _controllers[2].text != '' &&
                        _controllers[3].text != '') {
                      String fullPin = _controllers[0].text +
                          _controllers[1].text +
                          _controllers[2].text +
                          _controllers[3].text;
                      FocusScope.of(context).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();

                      context
                          .read<PinCodeController>()
                          .add(PinChanged(pin: fullPin));
                    }
                    // Notify the Bloc of the pin change
                  },
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
