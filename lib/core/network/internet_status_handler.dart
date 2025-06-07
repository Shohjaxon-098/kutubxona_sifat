import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kutubxona/features/widgets/no_internet_widget.dart';

class InternetStatusHandler extends StatefulWidget {
  final Widget child;

  const InternetStatusHandler({super.key, required this.child});

  @override
  State<InternetStatusHandler> createState() => _InternetStatusHandlerState();
}

class _InternetStatusHandlerState extends State<InternetStatusHandler> {
  late Stream<InternetStatus> _statusStream;

  @override
  void initState() {
    super.initState();
    _statusStream = InternetConnection().onStatusChange;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InternetStatus>(
      stream: _statusStream,
      initialData: InternetStatus.connected,
      builder: (context, snapshot) {
        final status = snapshot.data;

        if (status == InternetStatus.disconnected) {
          return NoInternetScreen();
        }

        return widget.child;
      },
    );
  }
}
