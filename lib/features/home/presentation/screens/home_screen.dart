import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/presentation/screens/custom_drawer.dart';
import 'package:kutubxona/features/home/presentation/widgets/all_book_section.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool showDropdown = false;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    context.read<UserProfileBloc>().add(GetUserProfileEvent());
    context.read<HomeBloc>().add(GetAllHomeDataEvent());
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() => showDropdown = false);
      }
    });
  }

  Future<void> _onRefresh() async {
    context.read<UserProfileBloc>().add(GetUserProfileEvent());
    context.read<HomeBloc>().add(GetAllHomeDataEvent());
    await Future.delayed(Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(
        onLogout: () async {
          await LocalStorage.clearUser();
          if (!context.mounted) return;
          AppNavigator.pushNamedAndRemoveUntil(context, AppRoutes.login);
        },
      ),
      drawerEnableOpenDragGesture: false,
      backgroundColor: AppColors().cardColor,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: AppColors().white),
              pinned: true,
              expandedHeight: 160.h,
              backgroundColor: AppColors().cardColor,
              flexibleSpace: FlexibleSpaceBar(background: GreetingHeader()),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(33.r),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchFieldWithDropdown(
                      controller: controller,
                      focusNode: focusNode,
                      layerLink: _layerLink,
                      showDropdown: showDropdown,
                      onDropdownVisibilityChanged:
                          (visible) => setState(() => showDropdown = visible),
                    ),
                    SizedBox(height: 24.h),
                    const CategorySectionWidget(),
                    SizedBox(height: 24.h),
                    const BookSectionWidget(),
                    SizedBox(height: 16.h),
                    const AllBookSection(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
