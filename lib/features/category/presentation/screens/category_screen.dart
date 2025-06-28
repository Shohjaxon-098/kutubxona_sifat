import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/export.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppbar(context), body: _buildBody(context));
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      title: Text(
        'Рукнлар',
        style: TextStyle(
          fontSize: 18.sp,
          color: Theme.of(context).colorScheme.tertiary,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 11.h),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const ShimmerLoadingAllCategories();
              } else if (state is HomeDataLoaded) {
                return Categories(
                  categories: state.categories,
                ); // To‘liq ro‘yxat
              } else if (state is HomeError) {
                return Center(
                  child: Text(state.message, style: TextStyle(fontSize: 14.sp)),
                );
              }
              return Center(
                child: Text(
                  'Nimadir xato ketdi.',
                  style: TextStyle(fontSize: 14.sp),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
