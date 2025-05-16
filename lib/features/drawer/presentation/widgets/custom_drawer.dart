import 'dart:ui';

import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/presentation/screens/bar_chart_screen.dart';
import 'package:kutubxona/features/drawer/presentation/screens/need_books_screen.dart';
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
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/1.jpg',
                  ),
                  radius: 24,
                ),
                title: const Text(
                  'Darin Kunde',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('+998 90 253 77 53'),
              ),
              Divider(color: Theme.of(context).colorScheme.tertiary),

              DrawerItem(
                icon: SvgPicture.asset(
                  AppImages().handCoin,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: 'Ҳисса қўшиш',
                onTap: () {
                  // Navigator.pop(context); // Drawer yopiladi
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const HissaQoshishScreen()),
                  // );
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
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const KontaktScreen()),
                  // );
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
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const ProfilScreen()),
                  // );
                },
              ),

              DrawerItem(
                icon: const Icon(Icons.info_outline, color: Colors.grey),
                label: 'Биз ҳақимизда',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (_) => const BizHaqimizdaScreen()),
                  // );
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
}
