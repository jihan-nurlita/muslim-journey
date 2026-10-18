import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/navigation/custom_bottom_navbar.dart';
import 'package:muslim_journey/providers/target_provider.dart';
import 'package:provider/provider.dart';

enum StatsViewType {
  weekly,
  monthly,
  yearly,
}

class TargetPage extends StatefulWidget {
  const TargetPage({super.key});

  @override
  State<TargetPage> createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  StatsViewType currentView = StatsViewType.weekly;
  DateTime selectedDate = DateTime.now();

  // Daftar nama bulan singkat khusus untuk tampilan Minggu
  final List<String> _shortMonthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  // Daftar nama bulan lengkap untuk tampilan Bulan
  final List<String> _fullMonthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TargetProvider>().loadTargets();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TargetProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// DATA STATISTIK REAL DARI PROVIDER
    List<double> chartData = [];
    List<String> labels = [];
    String periodLabel = "";

    /// 1. WEEKLY DATA
    if (currentView == StatsViewType.weekly) {
      final monday =
          selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
      final sunday = monday.add(const Duration(days: 6));

      labels = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

      chartData = List.generate(7, (i) {
        final day = monday.add(Duration(days: i));
        return provider.getPercentageForDate(day);
      });

      periodLabel =
          "${monday.day} ${_shortMonthNames[monday.month - 1]} - ${sunday.day} ${_shortMonthNames[sunday.month - 1]} ${sunday.year}";
    }

    /// 2. MONTHLY DATA
    else if (currentView == StatsViewType.monthly) {
      final daysInMonth =
          DateTime(selectedDate.year, selectedDate.month + 1, 0).day;

      labels = List.generate(daysInMonth, (i) => "${i + 1}");

      chartData = List.generate(daysInMonth, (i) {
        final day = DateTime(selectedDate.year, selectedDate.month, i + 1);
        return provider.getPercentageForDate(day);
      });

      periodLabel =
          "${_fullMonthNames[selectedDate.month - 1]} ${selectedDate.year}";
    }

    /// 3. YEARLY DATA
    else {
      labels = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'Mei',
        'Jun',
        'Jul',
        'Agt',
        'Sep',
        'Okt',
        'Nov',
        'Des'
      ];

      chartData = List.generate(12, (i) {
        double monthTotal = 0;
        final daysInMonth = DateTime(selectedDate.year, i + 2, 0).day;
        for (int d = 1; d <= daysInMonth; d++) {
          final day = DateTime(selectedDate.year, i + 1, d);
          monthTotal += provider.getPercentageForDate(day);
        }
        return daysInMonth > 0 ? (monthTotal / daysInMonth) : 0.0;
      });

      periodLabel = "${selectedDate.year}";
    }

    double chartWidth;
    if (currentView == StatsViewType.weekly) {
      chartWidth = MediaQuery.of(context).size.width + 40;
    } else if (currentView == StatsViewType.monthly) {
      chartWidth = chartData.length * 36.0;
    } else {
      chartWidth = chartData.length * 52.0;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Statistics",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 3),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOGGLE (Minggu / Bulan / Tahun)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                border: Border.all(
                  color: isDark ? Colors.white12 : Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  _buildToggle(
                    title: "Minggu",
                    type: StatsViewType.weekly,
                    isDark: isDark,
                  ),
                  _buildToggle(
                    title: "Bulan",
                    type: StatsViewType.monthly,
                    isDark: isDark,
                  ),
                  _buildToggle(
                    title: "Tahun",
                    type: StatsViewType.yearly,
                    isDark: isDark,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// PERIOD NAVIGATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: previousPeriod,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                Text(
                  periodLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.black,
                  ),
                ),
                IconButton(
                  onPressed: nextPeriod,
                  icon: const Icon(
                    Icons.chevron_right,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// CHART CARD
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Target Activity",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 280,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        width: chartWidth,
                        child: BarChart(
                          BarChartData(
                            maxY: 100,
                            alignment: BarChartAlignment.spaceAround,
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 20,
                              getDrawingHorizontalLine: (value) {
                                return FlLine(
                                  color: isDark
                                      ? Colors.white12
                                      : Colors.grey.shade200,
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  interval: 20,
                                  getTitlesWidget: (value, meta) {
                                    if (value == 0) {
                                      return const SizedBox();
                                    }
                                    return Text(
                                      "${value.toInt()}%",
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white54
                                            : AppColors.grey,
                                        fontSize: 11,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index < 0 || index >= labels.length) {
                                      return const SizedBox();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        labels[index],
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white54
                                              : AppColors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            barGroups: List.generate(
                              chartData.length,
                              (index) {
                                final value = chartData[index];
                                double rodWidth = 18;

                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: value,
                                      width: rodWidth,
                                      borderRadius: BorderRadius.circular(6),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          AppColors.primary,
                                          AppColors.primary.withOpacity(0.4),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// SUMMARY (TOTAL & STREAK REAL)
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    title: "Total Selesai",
                    value: "${provider.completedCount}",
                    icon: Icons.auto_awesome,
                    color: AppColors.primary,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryCard(
                    title: "Streak Hari",
                    value: "${provider.streak}",
                    icon: Icons.local_fire_department,
                    color: Colors.orange,
                    isDark: isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// PREVIOUS PERIOD
  void previousPeriod() {
    setState(() {
      if (currentView == StatsViewType.weekly) {
        selectedDate = selectedDate.subtract(const Duration(days: 7));
      } else if (currentView == StatsViewType.monthly) {
        selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
      } else {
        selectedDate = DateTime(selectedDate.year - 1);
      }
    });
  }

  /// NEXT PERIOD
  void nextPeriod() {
    setState(() {
      if (currentView == StatsViewType.weekly) {
        selectedDate = selectedDate.add(const Duration(days: 7));
      } else if (currentView == StatsViewType.monthly) {
        selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
      } else {
        selectedDate = DateTime(selectedDate.year + 1);
      }
    });
  }

  /// TOGGLE WIDGET
  Widget _buildToggle({
    required String title,
    required StatsViewType type,
    required bool isDark,
  }) {
    final isSelected = currentView == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentView = type;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected ? AppColors.primary : Colors.transparent,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white54 : AppColors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// SUMMARY CARD WIDGET
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 34,
          ),
          const SizedBox(height: 18),
          Text(
            value,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white54 : AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
