import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/presentation/logic/bloc/about_us_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/contact_card.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/shimmer_contact_card.dart';

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({super.key});

  @override
  State<AboutusScreen> createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
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
        title: const Text(
          'Контактлар',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AboutUsBloc, AboutUsState>(
        builder: (context, state) {
          if (state is AboutUsLoading) {
            return const ShimmerContactCard();
          } else if (state is AboutUsError) {
            return Center(child: Text(state.message));
          } else if (state is AboutUsLoaded) {
            return ContactCard(info: state.aboutUs);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
