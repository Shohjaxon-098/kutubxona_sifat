import 'dart:ui';

import 'package:kutubxona/config/config_exports.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_state.dart';
import 'package:kutubxona/features/profile/presentation/widgets/profile_header_card.dart';
import 'package:kutubxona/features/profile/presentation/widgets/profile_option_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Профиль",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserProfileError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ToastMessage.showToast(state.message, context);
            });
          } else if (state is UserProfileLoaded) {
            final user = state.user;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ProfileHeaderCard(user: user),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.myBookScreen);
                    },
                    child: const ProfileOptionTile(
                      iconPath: 'assets/icons/book-shelf.svg',
                      title: 'Китобларим',
                      onTap: null, // TODO: Implement navigation
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: AppColors().border),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.pushNamed(
                        context,
                        AppRoutes.bookedBookScreen,
                      );
                    },
                    child: const ProfileOptionTile(
                      iconPath: 'assets/icons/book-mark.svg',
                      title: 'Банд қилинганлар',
                      onTap: null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: AppColors().border),
                  const SizedBox(height: 16),
                  ProfileOptionTile(
                    iconPath: AppImages().settings,
                    title: ' Созламалар',
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Dialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.settings_outlined,
                                      size: 50,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),

                                    const SizedBox(height: 8),
                                    Text(
                                      'Бу бўлим тез орада фаол бўлади.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.tertiary,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Тушунарли',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: AppColors().border),
                ],
              ),
            );
          }

          return const Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
