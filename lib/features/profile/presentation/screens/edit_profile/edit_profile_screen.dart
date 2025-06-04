import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/controller/edit_profile_controller.dart';
import 'package:kutubxona/features/profile/presentation/screens/edit_profile/widgets/edit_profile_form.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileController(context: context),
      child: EditProfileForm(),
    );
  }
}
