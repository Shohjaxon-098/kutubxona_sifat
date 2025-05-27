import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/drawer/presentation/screens/about_us.dart';
import 'package:kutubxona/features/drawer/presentation/screens/bar_chart_screen.dart';
import 'package:kutubxona/features/drawer/presentation/screens/contact_card_page.dart';
import 'package:kutubxona/features/drawer/presentation/screens/contribute_screen.dart';
import 'package:kutubxona/features/drawer/presentation/screens/need_books_screen.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_state.dart';
import 'package:kutubxona/features/profile/presentation/screens/profile_screen.dart';
import 'package:kutubxona/features/widgets/drawer_widget.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;
  const CustomDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Material(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileLoaded) {
                    final profile = state.user;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            radius: 28,
                            backgroundImage:
                                state.user.photoPath.isEmpty
                                    ? null
                                    : CachedNetworkImageProvider(
                                      state.user.photoPath,
                                    ),
                            child:
                                state.user.photoPath.isEmpty
                                    ? Padding(
                                      padding: EdgeInsets.only(bottom: 3),
                                      child: SvgPicture.asset(
                                        AppImages().person,
                                        width: 40,
                                      ),
                                    )
                                    : null,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile.firstName} ${profile.lastName}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                formatPhoneNumber(profile.phoneNumber),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (state is UserProfileLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is UserProfileError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ToastMessage.showToast(state.message, context);
                    });
                    return const SizedBox();
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 24),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().handCoin,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Ҳисса қўшиш',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ContributeScreen()),
                  );
                },
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().bookShelf,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Зарур китоблар',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NeedBooksScreen()),
                  );
                },
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().barChart,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Статистика',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StatistikaScreen()),
                  );
                },
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().customer,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Контакт',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ContactCardScreen()),
                  );
                },
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().settings,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Созламалар',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const SozlamalarScreen()),
                  // );
                },
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().accountCircle,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Профиль',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()),
                  );
                },
              ),

              DrawerItem(
                icon: const Icon(Icons.info_outline, color: Colors.grey),
                label: 'Биз ҳақимизда',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AboutusScreen()),
                  );
                },
              ),

              const Spacer(),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Профилдан чиқиш',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: onLogout,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String formatPhoneNumber(String rawPhone) {
    if (rawPhone.length != 9) return rawPhone; // fallback
    final part1 = rawPhone.substring(0, 2); // 50
    final part2 = rawPhone.substring(2, 5); // 779
    final part3 = rawPhone.substring(5, 7); // 14
    final part4 = rawPhone.substring(7); // 02

    return '+998 $part1 $part2 $part3 $part4';
  }
}
