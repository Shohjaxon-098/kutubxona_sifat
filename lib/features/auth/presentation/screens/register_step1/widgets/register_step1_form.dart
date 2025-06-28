import 'package:kutubxona/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/features/auth/presentation/screens/register_step1/controller/register_step1_controller.dart';

class RegisterStep1Form extends StatefulWidget {
  const RegisterStep1Form({super.key});

  @override
  State<RegisterStep1Form> createState() => _RegisterStep1FormState();
}

class _RegisterStep1FormState extends State<RegisterStep1Form> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterStep1Controller>();

    return Form(
      key: controller.formKey,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              physics:
                  constraints.maxHeight > 700.h
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: BlocListener<RegisterStep1Bloc, RegisterStep1State>(
                    listener:
                        (context, state) =>
                            controller.handleState(state, context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildHeader(),
                        SizedBox(height: 50.h),
                        PhoneTextfieldWidget(
                          phoneController: controller.phoneController,
                        ),
                        const Spacer(),
                        _buildButtons(context, controller),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 260.h,
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: AssetImage(AppImages().mask),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 84.w,
            height: 84.w,
            decoration: BoxDecoration(
              color: AppColors().white,
              borderRadius: BorderRadius.circular(28.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  spreadRadius: 5.r,
                  color: AppColors().cardShadow,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(AppImages().logo),
                scale: 11,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            'Ассалому алайкум\nХуш келибсиз!',
            style: TextStyle(
              color: AppColors().white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(
    BuildContext context,
    RegisterStep1Controller controller,
  ) {
    return Column(
      children: [
        PrimaryButton(
          onPressed:
              controller.isLoading
                  ? null
                  : () => controller.submitPhoneNumber(context),
          child:
              controller.isLoading
                  ? SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                  : Text(
                    "Давом этиш",
                    style: TextStyle(
                      color: AppColors().white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
        ),
        SizedBox(height: 12.h),
        TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () => controller.goToLogin(context),
          child: Text(
            "Кириш",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors().primaryColor,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}
