import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_state.dart';
import '../widgets/metric_chart.dart';

class HistoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = context.watch<AppState>().history;
    if (history == null) return Center(child: CircularProgressIndicator());
    if (history.isEmpty) return Center(child: Text('No history data'));

    List<FlSpot> _toSpots(List<int> values) =>
        values.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.toDouble())).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          MetricChart(title: 'Live Power', spots: _toSpots(history.map((e) => e.livepower).toList())),
          MetricChart(title: 'Total Power', spots: _toSpots(history.map((e) => e.totalpower).toList())),
          MetricChart(title: 'Current (A)', spots: _toSpots(history.map((e) => e.current).toList())),
          MetricChart(title: 'Voltage (V)', spots: _toSpots(history.map((e) => e.voltage).toList())),
        ],
      ),
    );
  }
}
