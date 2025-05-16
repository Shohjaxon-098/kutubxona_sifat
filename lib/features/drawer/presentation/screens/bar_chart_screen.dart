import 'package:kutubxona/export.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatistikaScreen extends StatelessWidget {
  const StatistikaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Статистика",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatCard(
                      title: "Китобхонлар",
                      leftLabel: "Аёллар",
                      leftValue: 500,
                      rightLabel: "Эркаклар",
                      rightValue: 300,
                    ),
                    const SizedBox(height: 16),
                    _buildStatCard(
                      title: "Китоблар",
                      leftLabel: "Талаб қилиб",
                      leftValue: 450,
                      rightLabel: "Ўқиш учун берилган",
                      rightValue: 550,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Етишмаётган китоблар",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBookGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String leftLabel,
    required int leftValue,
    required String rightLabel,
    required int rightValue,
  }) {
    final total = leftValue + rightValue;
    final leftPercent = leftValue / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors().border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(color: Color(0xffFF92AE), label: leftLabel),
              const SizedBox(width: 16),
              _buildLegend(color: Color(0xff67E9F1), label: rightLabel),
            ],
          ),
          const SizedBox(height: 16),
          CircularPercentIndicator(
            radius: 50,
            lineWidth: 12,
            percent: leftPercent,
            center: Text(
              "$total\nжами",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            progressColor: const Color(0xffFF92AE),
            backgroundColor: const Color(0xff67E9F1),
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildLegend({required Color color, required String label}) {
    return Row(
      children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBookGrid() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) return const ShimmerLoadingSingleCategories();
        if (state is HomeError) return Center(child: Text(state.message));
        if (state is HomeDataLoaded) {
          return SingleCategories(books: state.books);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
