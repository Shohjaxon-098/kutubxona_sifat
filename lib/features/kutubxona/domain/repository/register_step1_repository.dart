
import 'package:kutubxona/features/kutubxona/data/models/register_step1.dart';


abstract class AuthRepository {
  Future<void> registerStep1(RegisterStep1 userData);
}
