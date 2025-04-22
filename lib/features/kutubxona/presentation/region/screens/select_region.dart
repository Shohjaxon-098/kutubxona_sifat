import 'package:kutubxona/core/util/important.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/library_bloc.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/library_event.dart';
import 'package:kutubxona/features/kutubxona/presentation/blocs/bloc/library_state.dart';

class SelectRegion extends StatefulWidget {
  const SelectRegion({super.key});

  @override
  State<SelectRegion> createState() => _SelectRegionState();
}

class _SelectRegionState extends State<SelectRegion> {
  String? selectedRegion;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<LibraryBloc>().add(FetchLibrariesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: BlocBuilder<LibraryBloc, LibraryState>(
            builder: (context, state) {
              if (state is LibraryLoading) {
                return const CircularProgressIndicator();
              } else if (state is LibraryLoaded) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 260,
                          decoration: BoxDecoration(
                            color: AppColors().cardColor,
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image: AssetImage(AppImages().mask),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 84,
                                height: 84,
                                decoration: BoxDecoration(
                                  color: AppColors().white,
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0,
                                      spreadRadius: 5,
                                      color: AppColors().cardShadow,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: AssetImage(AppImages().splashLogo),
                                    scale: 11,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 33),
                              Text(
                                'Қайси худуддаги кутубхоналардан фойдаланмоқчиси?',
                                style: TextStyle(
                                  color: AppColors().white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomDropdown(
                          items: [],
                          onChanged: (value) {},
                          selectedItem: selectedRegion,
                          label: 'Вилоят',
                          hintText: 'Вилоят',
                        ),
                        const SizedBox(height: 24),
                        CustomDropdown(
                          items: [],
                          onChanged: (value) {},
                          selectedItem: selectedRegion,
                          label: 'Туман',
                          hintText: 'Туман',
                        ),

                        const SizedBox(height: 24),
                        CustomDropdown(
                          items: [],
                          onChanged: (value) {},
                          selectedItem: selectedRegion,
                          label: 'Кутубхона',
                          hintText: 'Кутубхона',
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.1,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors().primaryColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            AppNavigator.pushNamed(context, AppRoutes.home);
                          },
                          child: Text(
                            "Давом этиш",
                            style: TextStyle(color: AppColors().white),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
