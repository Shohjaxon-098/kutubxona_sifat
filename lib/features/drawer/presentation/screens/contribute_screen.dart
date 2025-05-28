import 'package:flutter/material.dart';
import 'package:kutubxona/core/constants/app_config.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/contribution_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/contribution_event.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/contribution_state.dart';
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
    // Misol uchun: libraryId ni o'zgartiring yoki context orqali oling
    final libraryId = AppConfig.libraryId.toString();
    context.read<ContributionBloc>().add(LoadContributions(libraryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "Хисса қўшиш",
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ContributionBloc, ContributionState>(
        builder: (context, state) {
          if (state is ContributionLoaded) {
            final info = state.contributions;
            return ContributeCard(info: info);
          } else if (state is ContributionError) {
            ToastMessage.showToast(state.message, context);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
