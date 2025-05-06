import 'package:kutubxona/export.dart';

class LibraryDropdownWidget extends StatelessWidget {
  final List<LibraryEntity> libraries;
  final String? region;
  final String? district;
  final String? selectedLibrary;
  final void Function(String?) onChanged;

  const LibraryDropdownWidget({
    super.key,
    required this.libraries,
    required this.region,
    required this.district,
    required this.selectedLibrary,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> libraryNames = (region != null && district != null)
        ? libraries
            .where((e) => e.region == region && e.district == district)
            .map((e) => e.name)
            .toList()
        : [];

    return CustomDropdown(
      items: libraryNames,
      selectedItem: selectedLibrary,
      onChanged: onChanged,
      label: 'Кутубхона',
      hintText: 'Кутубхона',
    );
  }
}
