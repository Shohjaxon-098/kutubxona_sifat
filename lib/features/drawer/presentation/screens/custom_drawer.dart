import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/drawer/presentation/screens/about_us.dart';
import 'package:kutubxona/features/drawer/presentation/screens/statistic_screen.dart';
import 'package:kutubxona/features/drawer/presentation/screens/contact_card_page.dart';
import 'package:kutubxona/features/drawer/presentation/screens/contribute_screen.dart';
import 'package:kutubxona/features/drawer/presentation/screens/deficient_book_screen.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_state.dart';
import 'package:kutubxona/features/profile/presentation/screens/profile_screen.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/drawer_widget.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onLogout;
  const CustomDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Material(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  if (state is UserProfileLoaded) {
                    final profile = state.user;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: colorScheme.secondary,
                            radius: 28.r,
                            backgroundImage:
                                state.user.photoPath.isEmpty
                                    ? null
                                    : CachedNetworkImageProvider(
                                      state.user.photoPath,
                                    ),
                            child:
                                state.user.photoPath.isEmpty
                                    ? Padding(
                                      padding: EdgeInsets.only(bottom: 3.h),
                                      child: SvgPicture.asset(
                                        AppImages().person,
                                        width: 40.w,
                                      ),
                                    )
                                    : null,
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${profile.firstName} ${profile.lastName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                formatPhoneNumber(profile.phoneNumber),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
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
              SizedBox(height: 24.h),

              /// Drawer Items
              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().handCoin,
                  color: colorScheme.tertiary,
                ),
                label: 'Ҳисса қўшиш',
                onTap:
                    () => Navigator.push(
                      context,
                      createSlideRoute(const ContributeScreen()),
                    ),
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().bookShelf,
                  color: colorScheme.tertiary,
                ),
                label: 'Зарур китоблар',
                onTap:
                    () => Navigator.push(
                      context,
                      createSlideRoute(const DeficientBookScreen()),
                    ),
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().barChart,
                  color: colorScheme.tertiary,
                ),
                label: 'Статистика',
                onTap:
                    () => Navigator.push(
                      context,
                      createSlideRoute(const StatisticsPage()),
                    ),
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().customer,
                  color: colorScheme.tertiary,
                ),
                label: 'Контакт',
                onTap:
                    () => Navigator.push(
                      context,
                      createSlideRoute(const ContactCardScreen()),
                    ),
              ),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().accountCircle,
                  color: colorScheme.tertiary,
                ),
                label: 'Профиль',
                onTap:
                    () => Navigator.push(
                      context,
                      createSlideRoute(const ProfileScreen()),
                    ),
              ),

              DrawerItem(
                icon: const Icon(Icons.info_outline, color: Colors.grey),
                label: 'Биз ҳақимизда',
                onTap:
                    () => Navigator.push(
                      context,
                      createSlideRoute(const AboutusScreen()),
                    ),
              ),

              const Spacer(),

              ListTile(
                leading: Icon(Icons.logout, color: Colors.red, size: 24.sp),
                title: Text(
                  'Профилдан чиқиш',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.5,
                    decoration: TextDecoration.none,
                  ),
                ),
                onTap: onLogout,
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  String formatPhoneNumber(String rawPhone) {
    if (rawPhone.length != 9) return rawPhone;
    final part1 = rawPhone.substring(0, 2);
    final part2 = rawPhone.substring(2, 5);
    final part3 = rawPhone.substring(5, 7);
    final part4 = rawPhone.substring(7);
    return '+998 $part1 $part2 $part3 $part4';
  }

  Route createSlideRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // O‘ngdan kiradi
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
