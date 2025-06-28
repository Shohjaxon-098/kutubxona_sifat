import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/drawer/presentation/logic/contribution/contribution_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/contribution/contribution_event.dart';
import 'package:kutubxona/features/drawer/presentation/logic/contribution/contribution_state.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/contribute_card.dart';

class ContributeScreen extends StatefulWidget {
  const ContributeScreen({super.key});

  @override
  State<ContributeScreen> createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  @override
  void initState() {
    super.initState();
    final libraryId = AppConfig.libraryId.toString();
    context.read<ContributionBloc>().add(LoadContributions(libraryId));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        title: Text(
          "Хисса қўшиш",
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'Roboto',
            color: colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(
          color: colorScheme.tertiary,
          size: 24.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<ContributionBloc, ContributionState>(
          builder: (context, state) {
            if (state is ContributionLoaded) {
              final info = state.contributions;
              return ContributeCard(info: info);
            } else if (state is ContributionError) {
              ToastMessage.showToast(state.message, context);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
