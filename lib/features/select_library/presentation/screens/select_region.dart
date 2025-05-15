import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import '../widgets/header_card_widget.dart';
import '../widgets/region_dropdown_widget.dart';
import '../widgets/district_dropdown_widget.dart';
import '../widgets/library_dropdown_widget.dart';

class SelectRegionScreen extends StatefulWidget {
  const SelectRegionScreen({super.key});

  @override
  State<SelectRegionScreen> createState() => _SelectRegionScreenState();
}

class _SelectRegionScreenState extends State<SelectRegionScreen> {
  String? selectedRegion;
  String? selectedDistrict;
  String? selectedLibrary;

  final _formKey = GlobalKey<FormState>();
  late List<LibraryEntity> libraries;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    libraries = [];
  }

  void _handleContinue() async {
    if (selectedRegion == null ||
        selectedDistrict == null ||
        selectedLibrary == null) {
      ToastMessage.showToast('Бўш майдонни тўлдиринг');
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isLoading = false);

    // ignore: use_build_context_synchronously
    AppNavigator.pushNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const HeaderCardWidget(),
                const SizedBox(height: 30),
                BlocBuilder<LibraryBloc, LibraryState>(
                  builder: (context, state) {
                    if (state is LibraryError) {
                      ToastMessage.showToast(state.message);
                    } else if (state is LibraryLoaded) {
                      libraries = state.libraries;
                    }

                    return Column(
                      children: [
                        RegionDropdownWidget(
                          libraries: libraries,
                          selectedRegion: selectedRegion,
                          onChanged: (val) {
                            setState(() {
                              selectedRegion = val;
                              selectedDistrict = null;
                              selectedLibrary = null;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        DistrictDropdownWidget(
                          libraries: libraries,
                          region: selectedRegion,
                          selectedDistrict: selectedDistrict,
                          onChanged: (val) {
                            setState(() {
                              selectedDistrict = val;
                              selectedLibrary = null;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        LibraryDropdownWidget(
                          libraries: libraries,
                          region: selectedRegion,
                          district: selectedDistrict,
                          selectedLibrary: selectedLibrary,
                          onChanged:
                              (val) => setState(() => selectedLibrary = val),
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                BlocBuilder<LibraryBloc, LibraryState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      onPressed: isLoading ? null : () => _handleContinue(),
                      ttext:
                          isLoading
                              ? CircularProgressIndicator(
                                color: AppColors().white,
                                strokeWidth: 2,
                              )
                              : Text(
                                "Давом этиш",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors().white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
