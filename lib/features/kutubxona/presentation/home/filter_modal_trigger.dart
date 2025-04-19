import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kutubxona/features/kutubxona/domain/usecases/clear_filters_usecases.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/filter/filter_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/home/widgets/fileter_bottom_sheet.dart';


void showFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (_) {
      return BlocProvider(
        create: (_) => FilterBloc(ClearFiltersUseCase()),
        child: const FilterBottomSheet(),
      );
    },
  );
}
