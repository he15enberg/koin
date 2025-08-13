import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyBarChart extends StatefulWidget {
  final List<Map<String, dynamic>>
  data; // [{"month": "Jul'23", "amount": 3900.0}, ...]

  const MonthlyBarChart({super.key, required this.data});

  @override
  State<MonthlyBarChart> createState() => _MonthlyBarChartState();
}

class _MonthlyBarChartState extends State<MonthlyBarChart> {
  final ScrollController _scrollController = ScrollController();
  int selectedIndex = 0;
  double maxY = 0;
  int visibleCount = 5; // bars visible at a time
  static const double barWidth = 60; // Increased spacing between bars
  static const int yAxisSegments = 6; // 0 + 5 equal divisions

  @override
  void initState() {
    super.initState();
    _updateMaxY(0);

    _scrollController.addListener(() {
      final firstVisibleIndex = (_scrollController.offset / barWidth).floor();
      _updateMaxY(firstVisibleIndex);
    });
  }

  void _updateMaxY(int startIndex) {
    final endIndex = (startIndex + visibleCount).clamp(0, widget.data.length);
    final visibleData = widget.data.sublist(startIndex, endIndex);

    if (visibleData.isEmpty) return;

    final newMax = visibleData
        .map((e) => (e["amount"] as num).toDouble())
        .reduce((a, b) => a > b ? a : b);

    // Round up to nice number for better Y-axis display
    final roundedMax = _roundToNiceNumber(newMax);

    setState(() => maxY = roundedMax);
  }

  // Round to a nice number for better axis labels
  double _roundToNiceNumber(double value) {
    if (value == 0) return 1000; // Minimum scale

    final magnitude = (value / 1000).ceil() * 1000;
    return magnitude.toDouble();
  }

  // Generate Y-axis intervals (6 segments total: 0 + 5 equal divisions)
  double get yAxisInterval => maxY / 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        SizedBox(
          height: 350,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Stack(
              children: [
                SizedBox(
                  width: widget.data.length * barWidth,
                  child: BarChart(
                    BarChartData(
                      maxY: maxY * 1.1, // Add padding to prevent cut-off
                      minY: 0,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return null; // No tooltip
                          },
                        ),
                        touchCallback: (event, response) {
                          if (response != null &&
                              response.spot != null &&
                              event.isInterestedForInteractions) {
                            setState(() {
                              selectedIndex =
                                  response.spot!.touchedBarGroupIndex;
                            });
                          }
                        },
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index >= 0 && index < widget.data.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    widget.data[index]["month"],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              final amount = widget.data[index]["amount"];
                              if (index >= 0 && index < widget.data.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    _formatAmount(amount),

                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: widget.data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final amount = (entry.value["amount"] as num)
                            .toDouble();
                        final isSelected = index == selectedIndex;

                        return BarChartGroupData(
                          x: index,
                          barsSpace: 8, // Add space between bar groups
                          barRods: [
                            BarChartRodData(
                              toY: amount,
                              width: 20,
                              color: Colors
                                  .blue
                                  .shade500, // Keep same color always
                              borderRadius: BorderRadius.circular(6),
                              backDrawRodData: BackgroundBarChartRodData(
                                show:
                                    isSelected, // Show grey background when selected
                                toY: maxY * 1.1, // Match the chart maxY
                                color: Colors.grey.withOpacity(0.3),
                                // width: barWidth, // Make background cover full bar width including spacing
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Value labels above bars in a line
              ],
            ),
          ),
        ),
        // Optional: Display selected bar info
        if (selectedIndex < widget.data.length)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bar_chart, color: Colors.blue.shade500),
                    const SizedBox(width: 8),
                    Text(
                      '${widget.data[selectedIndex]["month"]}: ${_formatAmount(widget.data[selectedIndex]["amount"])}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatAxisLabel(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toInt().toString();
  }

  String _formatAmount(dynamic amount) {
    final value = (amount as num).toDouble();
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toInt().toString();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
