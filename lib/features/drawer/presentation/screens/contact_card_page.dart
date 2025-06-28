import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/presentation/logic/about_us/about_us_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/contact_card.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/shimmer_contact_card.dart';

class ContactCardScreen extends StatefulWidget {
  const ContactCardScreen({super.key});

  @override
  State<ContactCardScreen> createState() => _ContactCardScreenState();
}

class _ContactCardScreenState extends State<ContactCardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AboutUsBloc>().add(LoadAboutUsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Контактлар',
          style: TextStyle(
            fontSize: 18.sp,
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiary,
          size: 24.sp,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocBuilder<AboutUsBloc, AboutUsState>(
          builder: (context, state) {
            if (state is AboutUsLoading) {
              return const ShimmerContactCard();
            } else if (state is AboutUsError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (state is AboutUsLoaded) {
              return ContactCard(info: state.aboutUs);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
