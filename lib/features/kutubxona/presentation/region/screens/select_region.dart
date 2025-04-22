import 'package:kutubxona/core/util/important.dart';

class SelectRegion extends StatefulWidget {
  const SelectRegion({super.key});

  @override
  State<SelectRegion> createState() => _SelectRegionState();
}

class _SelectRegionState extends State<SelectRegion> {
  String? selectedRegion;
  String? selectedDistrict;
  String? selectedLibrary;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(FetchLibrariesEvent());
  }

  List<String> getRegions(List<LibraryEntity> data) =>
      data.map((e) => e.region).toSet().toList();

  List<String> getDistricts(List<LibraryEntity> data, String region) =>
      data
          .where((e) => e.region == region)
          .map((e) => e.district)
          .toSet()
          .toList();

  List<String> getLibraries(
    List<LibraryEntity> data,
    String region,
    String district,
  ) =>
      data
          .where((e) => e.region == region && e.district == district)
          .map((e) => e.name)
          .toList();

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      height: 260,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: AppColors().white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    spreadRadius: 5,
                    color: AppColors().cardShadow,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(AppImages().splashLogo),
                  scale: 11,
                ),
              ),
            ),
            const SizedBox(height: 33),
            Text(
              'Қайси худуддаги кутубхоналардан фойдаланмоқчисиз?',
              style: TextStyle(
                color: AppColors().white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdowns(List<LibraryEntity> libraries) {
    return Column(
      children: [
        CustomDropdown(
          items: getRegions(libraries),
          onChanged: (value) {
            setState(() {
              selectedRegion = value;
              selectedDistrict = null;
              selectedLibrary = null;
            });
          },
          selectedItem: selectedRegion,
          label: 'Вилоят',
          hintText: 'Вилоят',
        ),
        const SizedBox(height: 24),
        CustomDropdown(
          items:
              selectedRegion != null
                  ? getDistricts(libraries, selectedRegion!)
                  : [],
          onChanged: (value) {
            setState(() {
              selectedDistrict = value;
              selectedLibrary = null;
            });
          },
          selectedItem: selectedDistrict,
          label: 'Туман',
          hintText: 'Туман',
        ),
        const SizedBox(height: 24),
        CustomDropdown(
          items:
              (selectedRegion != null && selectedDistrict != null)
                  ? getLibraries(libraries, selectedRegion!, selectedDistrict!)
                  : [],
          onChanged: (value) {
            setState(() {
              selectedLibrary = value;
            });
          },
          selectedItem: selectedLibrary,
          label: 'Кутубхона',
          hintText: 'Кутубхона',
        ),
      ],
    );
  }

  void _handleContinue(List<LibraryEntity> libraries) async {
    await libraries.firstWhere(
      (e) =>
          e.region == selectedRegion &&
          e.district == selectedDistrict &&
          e.name == selectedLibrary,
      orElse: () => throw Exception("Tanlangan kutubxona topilmadi"),
    );

    AppNavigator.pushNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderCard(),
                  const SizedBox(height: 30),
                  BlocBuilder<LibraryBloc, LibraryState>(
                    builder: (context, state) {
                      if (state is LibraryLoaded) {
                        return _buildDropdowns(state.libraries);
                      }
                      return const SizedBox();
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  BlocBuilder<LibraryBloc, LibraryState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors().primaryColor,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          if (state is LibraryLoaded) {
                            _handleContinue(state.libraries);
                          }
                        },
                        child: Text(
                          "Давом этиш",
                          style: TextStyle(color: AppColors().white),
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
      ),
    );
  }
}
