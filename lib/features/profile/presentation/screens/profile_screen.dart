import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_state.dart';
import 'package:kutubxona/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:kutubxona/features/profile/presentation/widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserProfileError) {
          return Center(child: Text(state.message));
        } else if (state is UserProfileLoaded) {
          final user = state.user;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text(
                "Профиль",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ProfileHeaderCard(user: user),
                  const SizedBox(height: 24),
                  const ProfileOptionTile(
                    iconPath: 'assets/icons/book-shelf.svg',
                    title: 'Китобларим',
                    onTap: null, // TODO: Implement navigation
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: AppColors().border),
                  const SizedBox(height: 16),
                  const ProfileOptionTile(
                    iconPath: 'assets/icons/book-mark.svg',
                    title: 'Банд қилинганлар',
                    onTap: null,
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: AppColors().border),
                  const SizedBox(height: 16),
                  const ProfileOptionTile(
                    iconPath: 'assets/icons/account-setting.svg',
                    title: 'Profilni o’zgartirish',
                    onTap: null,
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: AppColors().border),
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('Unexpected state'));
      },
    );
  }
}
