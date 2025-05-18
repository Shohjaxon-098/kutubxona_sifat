import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/custom_drawer.dart';
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
    context.read<HomeBloc>().add(GetAllHomeDataEvent());
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
            context.read<HomeBloc>().add(GetAllHomeDataEvent());
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              iconTheme: IconThemeData(color: AppColors().white),
              pinned: true,

              expandedHeight: 160,
              backgroundColor: AppColors().cardColor,
              flexibleSpace: FlexibleSpaceBar(background: GreetingHeader()),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(33),
                  ),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
                  builder: (context, state) {
                    if (state == ConnectivityStatus.offline) {
                      return NoInternetWidget(
                        onRetry: () {
                          context.read<HomeBloc>().add(GetAllHomeDataEvent());
                        },
                      );
                    }
                    return Column(
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
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
