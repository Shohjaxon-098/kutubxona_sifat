import 'package:kutubxona/features/select_library/presentation/controller/select_region_controller.dart';
import 'package:provider/provider.dart';
import 'package:kutubxona/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics:
                        constraints.maxHeight > 700.h
                            ? const NeverScrollableScrollPhysics()
                            : const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeaderCardWidget(),
                              SizedBox(height: 30.h),
                              RegionDropdownWidget(
                                libraries: controller.libraries,
                                selectedRegion: controller.selectedRegion,
                                onChanged: controller.onRegionChanged,
                              ),
                              SizedBox(height: 24.h),
                              DistrictDropdownWidget(
                                libraries: controller.libraries,
                                region: controller.selectedRegion,
                                selectedDistrict: controller.selectedDistrict,
                                onChanged: controller.onDistrictChanged,
                              ),
                              SizedBox(height: 24.h),
                              LibraryDropdownWidget(
                                libraries: controller.libraries,
                                region: controller.selectedRegion,
                                district: controller.selectedDistrict,
                                selectedLibrary: controller.selectedLibrary,
                                onChanged: controller.onLibraryChanged,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height < 650
                                        ? 24.h
                                        : 12.h,
                              ),
                              PrimaryButton(
                                onPressed:
                                    controller.isLoading
                                        ? null
                                        : controller.continuePressed,
                                child:
                                    controller.isLoading
                                        ? SizedBox(
                                          width: 26.w,
                                          height: 26.w,
                                          child:
                                              const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                        )
                                        : Text(
                                          "Давом этиш",
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: AppColors().white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height < 650
                                        ? 24.h
                                        : 12.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
