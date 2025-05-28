import 'package:flutter/material.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_bloc.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_event.dart';
import 'package:kutubxona/features/drawer/presentation/logic/statistic/statistic_state.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/book_card_statistic.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/books_static_section.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/monthly_activity_chart.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/stat_card.dart';
import 'package:kutubxona/export.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    // Misol uchun: libraryId ni o'zgartiring yoki context orqali oling
    final libraryId = AppConfig.libraryId.toString();
    context.read<StatisticBloc>().add(LoadStatistics(libraryId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: BlocBuilder<StatisticBloc, StatisticState>(
            builder: (context, state) {
              if (state is StatisticLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is StatisticLoaded) {
                // Ma'lumotlar yuklandi, UI ni ko'rsatish
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatCard(
                      title: "Китобхонлар",
                      leftLabel: "Аёллар",
                      leftValue: state.statistic.femaleMembers,
                      rightLabel: "Эркаклар",
                      rightValue: state.statistic.maleMembers,
                      total: state.statistic.totalMembers,
                    ),
                    const SizedBox(height: 16),
                    StatCard(
                      title: "Барча китоблар",
                      leftLabel: "Айни вақтда ўқилаётган китоблар",
                      leftValue: state.statistic.availableBooks,
                      rightLabel: "Келишилган мудатда қайтарилмаган китоблар",
                      rightValue: state.statistic.activeReservations,
                      total: state.statistic.totalBooks,
                    ),
                    const SizedBox(height: 24),
                    BooksStatisticsSection(
                      value:
                          state
                              .statistic
                              .totalReservations, // Replace with appropriate value
                      percent: 0.5, // Replace with appropriate percent
                    ),
                    const SizedBox(height: 24),
                    MonthlyActivityChart(),
                    const SizedBox(height: 24),
                    BooksStatistic(title: 'Энг кўп ўқилган китоблар'),
                    BooksStatistic(title: 'Топ 100 китоблар'),
                  ],
                );
              } else if (state is StatisticError) {
                return Center(child: Text('Хатолик: ${state.message}'));
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        "Статистика",
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.tertiary,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
    );
  }
}
