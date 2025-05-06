import 'package:kutubxona/export.dart';

class DistrictDropdownWidget extends StatelessWidget {
  final List<LibraryEntity> libraries;
  final String? region;
  final String? selectedDistrict;
  final void Function(String?) onChanged;

  const DistrictDropdownWidget({
    super.key,
    required this.libraries,
    required this.region,
    required this.selectedDistrict,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> districts = region != null
        ? libraries
            .where((e) => e.region == region)
            .map((e) => e.district)
            .toSet()
            .toList()
        : [];

    return CustomDropdown(
      items: districts,
      selectedItem: selectedDistrict,
      onChanged: onChanged,
      label: 'Туман',
      hintText: 'Туман',
    );
  }
}
