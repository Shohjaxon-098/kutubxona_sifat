import 'package:kutubxona/core/constants/important.dart';

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
  late List<LibraryEntity> libraries;
  bool isLoading = false; // Add loading state

  @override
  void initState() {
    super.initState();
    context.read<LibraryBloc>().add(FetchLibrariesEvent());
    libraries = [];
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
            _buildLogo(),
            const SizedBox(height: 33),
            _buildHeaderText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
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
    );
  }

  Widget _buildHeaderText() {
    return Text(
      'Қайси худуддаги кутубхоналардан фойдаланмоқчисиз?',
      style: TextStyle(
        color: AppColors().white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDropdowns(List<LibraryEntity> libraries) {
    return Column(
      children: [
        _buildRegionDropdown(libraries),
        const SizedBox(height: 24),
        _buildDistrictDropdown(libraries),
        const SizedBox(height: 24),
        _buildLibraryDropdown(libraries),
      ],
    );
  }

  Widget _buildRegionDropdown(List<LibraryEntity> libraries) {
    return CustomDropdown(
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
    );
  }

  Widget _buildDistrictDropdown(List<LibraryEntity> libraries) {
    return CustomDropdown(
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
    );
  }

  Widget _buildLibraryDropdown(List<LibraryEntity> libraries) {
    return CustomDropdown(
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
    );
  }

  void _handleContinue(List<LibraryEntity> libraries) async {
    if (selectedRegion == null ||
        selectedDistrict == null ||
        selectedLibrary == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Bo`sh maydonni to`ldiring')));
      return;
    }

    setState(() {
      isLoading = true; // Start loading
    });

    await Future.delayed(const Duration(seconds: 2)); // Simulate a delay

    setState(() {
      isLoading = false; // Stop loading
    });

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
                      if (state is LibraryError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      } else if (state is LibraryLoaded) {
                        libraries = state.libraries;
                      }
                      return _buildDropdowns(libraries);
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
                  BlocBuilder<LibraryBloc, LibraryState>(
                    builder: (context, state) {
                      return PrimaryButton(
                        onPressed:
                            isLoading
                                ? null // Disable the button when loading
                                : () {
                                  if (state is LibraryLoaded) {
                                    _handleContinue(state.libraries);
                                  }
                                },
                        ttext:
                            isLoading
                                ? CircularProgressIndicator(
                                  color: AppColors().white,
                                  padding: EdgeInsets.all(5),
                                ) // Show loader
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
      ),
    );
  }
}
