import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/features/connectivity/presentation/cubit/connectivy_cubit.dart';

class AppConnectivityOverlay extends StatelessWidget {
  final Widget child;
  const AppConnectivityOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
          builder: (context, state) {
            if (state == ConnectivityStatus.offline) {
              ToastMessage.showToast('Internetga ulang', context);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
