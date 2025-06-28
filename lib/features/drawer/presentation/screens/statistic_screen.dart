import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_event.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_state.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/books_static.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/books_static_section.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/monthly_activity_chart.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/stat_card.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/static_shimmer.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/top_reader_section.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    final libraryId = AppConfig.libraryId.toString();
    context.read<StatisticBloc>().add(LoadStatistics(libraryId));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
          child: BlocBuilder<StatisticBloc, StatisticState>(
            builder: (context, state) {
              if (state is StatisticLoading) {
                return const StatisticsShimmer();
              } else if (state is StatisticLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatCard(
                      cntrLabel: '',
                      cntrvalue: 0,
                      showExtraText: false,
                      title: "Китобхонлар",
                      leftLabel: "Аёллар",
                      leftValue: state.statistic.femaleMembers,
                      rightLabel: "Эркаклар",
                      rightValue: state.statistic.maleMembers,
                      total: state.statistic.totalMembers,
                    ),
                    SizedBox(height: 16.h),
                    StatCard(
                      showExtraText: true,
                      cntrLabel: 'Брон килинмаган китоблар',
                      cntrvalue: state.statistic.availableBooks,
                      title: "Барча китоблар",
                      leftLabel: "Айни вақтда ўқилаётган китоблар",
                      leftValue: state.statistic.activeReservations,
                      rightLabel: "Келишилган мудатда қайтарилмаган китоблар",
                      rightValue: state.statistic.overdueBooks,
                      total: state.statistic.totalBooks,
                    ),
                    SizedBox(height: 24.h),
                    BooksStatisticsSection(
                      value: state.statistic,
                      percent: 0.5,
                    ),
                    SizedBox(height: 24.h),
                    MonthlyActivityChart(statistic: state.statistic),
                    SizedBox(height: 24.h),
                    BooksStatistic(
                      title: 'Энг кўп ўқилган китоблар',
                      books: state.statistic.topReservedBooksLastWeek,
                    ),
                    BooksStatistic(
                      title: 'Топ 100 китоблар',
                      books: state.statistic.topBooks,
                    ),
                    TopReadersSection(readers: state.statistic.topReaders),
                  ],
                );
              } else if (state is StatisticError) {
                return Center(
                  child: Text(
                    'Хатолик: ${state.message}',
                    style: TextStyle(fontSize: 14.sp),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final color = Theme.of(context).colorScheme.tertiary;

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        "Статистика",
        style: TextStyle(
          fontSize: 18.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: IconThemeData(color: color),
      centerTitle: true,
    );
  }
}
