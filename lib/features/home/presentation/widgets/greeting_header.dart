import 'package:kutubxona/core/util/toast_message.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_bloc.dart';
import 'package:kutubxona/features/profile/presentation/logic/user_profile/user_profile_state.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),

      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Ассалому алайкум!\n${state.user.firstName}',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors().white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors().white,
                    radius: 28,
                    child:
                        state.user.photoPath.isEmpty
                            ? Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: SvgPicture.asset(
                                AppImages().person,
                                width: 40,
                              ),
                            )
                            : null,
                    backgroundImage:
                        state.user.photoPath.isEmpty
                            ? null
                            : CachedNetworkImageProvider(state.user.photoPath),
                  ),
                ],
              ),
            );
          } else if (state is UserProfileError) {
            ToastMessage.showToast(state.message, context);
          }

          return SizedBox();
        },
      ),
    );
  }
}
