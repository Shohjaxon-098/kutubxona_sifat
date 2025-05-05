import 'package:kutubxona/export.dart';

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
      backgroundColor: AppColors().cardColor,
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(child: GreetingHeader()),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(33),
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: SingleChildScrollView(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
