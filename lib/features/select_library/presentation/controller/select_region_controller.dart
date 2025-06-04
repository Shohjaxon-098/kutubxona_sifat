import 'package:flutter/material.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';

class SelectRegionController extends ChangeNotifier {
  final BuildContext context;

  String? selectedRegion;
  String? selectedDistrict;
  String? selectedLibrary;
  List<LibraryEntity> libraries = [];
  bool isLoading = false;

  SelectRegionController(this.context) {
    _loadLibraries();
  }

  void _loadLibraries() {
    final state = context.read<LibraryBloc>().state;
    if (state is LibraryLoaded) {
      libraries = state.libraries;
    }
  }

  void onRegionChanged(String? value) {
    selectedRegion = value;
    selectedDistrict = null;
    selectedLibrary = null;
    notifyListeners();
  }

  void onDistrictChanged(String? value) {
    selectedDistrict = value;
    selectedLibrary = null;
    notifyListeners();
  }

  void onLibraryChanged(String? value) {
    selectedLibrary = value;
    notifyListeners();
  }

  Future<void> continuePressed() async {
    if (selectedRegion == null ||
        selectedDistrict == null ||
        selectedLibrary == null) {
      ToastMessage.showToast('Бўш майдонни тўлдиринг', context);
      return;
    }

    final selected = libraries.firstWhere(
      (lib) =>
          lib.name == selectedLibrary &&
          lib.region == selectedRegion &&
          lib.district == selectedDistrict,
    );

    isLoading = true;
    notifyListeners();

    await LocalStorage.saveLibraryId(selected.id);
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners();

    AppNavigator.pushNamedAndRemoveUntil(context, AppRoutes.login);
  }
}
