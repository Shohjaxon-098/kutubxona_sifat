import 'package:kutubxona/features/select_library/presentation/controller/select_region_controller.dart';
import 'package:provider/provider.dart';
import 'package:kutubxona/export.dart';
import '../widgets/header_card_widget.dart';
import '../widgets/region_dropdown_widget.dart';
import '../widgets/district_dropdown_widget.dart';
import '../widgets/library_dropdown_widget.dart';

class SelectRegionScreen extends StatelessWidget {
  const SelectRegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SelectRegionController(context),
      child: Consumer<SelectRegionController>(
        builder: (context, controller, _) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const HeaderCardWidget(),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Column(
                        children: [
                          RegionDropdownWidget(
                            libraries: controller.libraries,
                            selectedRegion: controller.selectedRegion,
                            onChanged: controller.onRegionChanged,
                          ),
                          const SizedBox(height: 24),
                          DistrictDropdownWidget(
                            libraries: controller.libraries,
                            region: controller.selectedRegion,
                            selectedDistrict: controller.selectedDistrict,
                            onChanged: controller.onDistrictChanged,
                          ),
                          const SizedBox(height: 24),
                          LibraryDropdownWidget(
                            libraries: controller.libraries,
                            region: controller.selectedRegion,
                            district: controller.selectedDistrict,
                            selectedLibrary: controller.selectedLibrary,
                            onChanged: controller.onLibraryChanged,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      onPressed:
                          controller.isLoading
                              ? null
                              : controller.continuePressed,
                      child:
                          controller.isLoading
                              ? const SizedBox(
                                width: 26,
                                height: 26,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : Text(
                                "Давом этиш",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors().white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
