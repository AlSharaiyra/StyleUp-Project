import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/auth/bloc/button/resendOtp/resend_otp_button_bloc.dart';
import 'package:style_up/modules/auth/bloc/button/resendOtp/resend_otp_button_event.dart';
import 'package:style_up/modules/auth/bloc/button/resendOtp/resend_otp_button_state.dart';


class DidntReciveOtp extends StatelessWidget {
  const DidntReciveOtp({super.key, required this.email, required this.otpPurpose});
final String email;
final String otpPurpose;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResendOtpButtonBloc,ResendOtpButtonState>(
      listener: (context,state) {

        if (state is OnFailed ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } 
      },
      builder: (context,state) {
        if (state is OnLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.didntReceive,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            InkWell(
              onTap: () {
                context.read<ResendOtpButtonBloc>().add(ResendOtpButtonPressed(
                  email: email,
                  otpPurpose: otpPurpose,
                ));
              },
              child: Text(  
                AppLocalizations.of(context)!.resendOtp,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        );
      }
    );
  }
}
