import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/l10n/app_localizations.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_bloc.dart';
import 'package:style_up/modules/auth/bloc/user_profile/user_profile_state.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.user_profile),
        centerTitle: true,
        backgroundColor: ColorsTheme.primryButton,
      ),
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
        if (state is UserProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      }, builder: (context, state) {
        if (state is UserProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if(state is UserProfileSucsess) {
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: screenWidth < 500 ? double.infinity : 400,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorsTheme.secondryButton,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 8, color: Colors.black26)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.account_circle,
                      size: 80, color: ColorsTheme.primryButton),
                  const SizedBox(height: 16),
                  _buildInfoTile(local.email, state.user.email),
                  // _buildInfoTile(local.username, state.user.username),
                  // _buildInfoTile(local.age, state.user.age),
                  // _buildInfoTile(local.gender, _localizedGender(state.user.gender, local)),
                ],
              ),
            ),
          ),
        );
        }
        else{
          return const Text('');
        }
      }),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Optional: Translate gender values manually if you store them as English
  String _localizedGender(String gender, AppLocalizations local) {
    switch (gender.toLowerCase()) {
      case 'male':
        return local.maleGender;
      case 'female':
        return local.femaleGender;
      default:
        return gender;
    }
  }
}
