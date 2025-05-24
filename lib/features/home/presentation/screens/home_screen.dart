import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/custom_drawer.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_event.dart';
import 'package:kutubxona/features/widgets/no_internet_widget.dart';

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
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() => showDropdown = false);
      }
    });

    context.read<UserProfileBloc>().add(GetUserProfileEvent());
    context.read<HomeBloc>().add(GetAllHomeDataEvent());
  }

  Future<void> _onRefresh() async {
    context.read<UserProfileBloc>().add(GetUserProfileEvent());
    context.read<HomeBloc>().add(GetAllHomeDataEvent());
    await Future.delayed(
      Duration(milliseconds: 500),
    ); // optional: refresh animationni ko‘rsatish uchun
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onLogout: () async {
          await LocalStorage.clearUser();

          if (!context.mounted) return;

          AppNavigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login, // yoki LoginScreen.routeName
          );
        },
      ),
      drawerEnableOpenDragGesture: false,
      backgroundColor: AppColors().cardColor,
      body: BlocListener<ConnectivityCubit, ConnectivityStatus>(
        listener: (context, state) {
          if (state == ConnectivityStatus.online) {
            context.read<UserProfileBloc>().add(GetUserProfileEvent());
            context.read<HomeBloc>().add(GetAllHomeDataEvent());
          }
        },
        child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
          builder: (context, state) {
            if (state == ConnectivityStatus.offline) {
              return NoInternetWidget(
                onRetry: () async {
                  context.read<UserProfileBloc>().add(GetUserProfileEvent());
                  context.read<HomeBloc>().add(GetAllHomeDataEvent());
                  await Future.delayed(const Duration(seconds: 2));
                },
              );
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    iconTheme: IconThemeData(color: AppColors().white),
                    pinned: true,

                    expandedHeight: 160,
                    backgroundColor: AppColors().cardColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: GreetingHeader(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(33),
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Column(
                        children: [
                          SearchFieldWithDropdown(
                            controller: controller,
                            focusNode: focusNode,
                            layerLink: _layerLink,
                            showDropdown: showDropdown,
                            onDropdownVisibilityChanged:
                                (visible) =>
                                    setState(() => showDropdown = visible),
                          ),
                          const SizedBox(height: 24),
                          const CategorySectionWidget(),
                          const SizedBox(height: 24),
                          const BookSectionWidget(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
