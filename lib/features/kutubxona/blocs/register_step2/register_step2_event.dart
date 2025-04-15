import 'package:kutubxona/features/kutubxona/data/models/register_step2.dart';

abstract class RegisterStep2Event {}

class RegisterStep2Submitted extends RegisterStep2Event {
  final RegisterStep2Model data;

  RegisterStep2Submitted({required this.data});
}
