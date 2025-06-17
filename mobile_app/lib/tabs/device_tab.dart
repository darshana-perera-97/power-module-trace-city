import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/app_state.dart';
import '../widgets/metric_chart.dart';

class DeviceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final live = state.liveData;
    final history = state.history;
    if (live == null || history == null) return Center(child: CircularProgressIndicator());

    List<FlSpot> _toSpotsInt(List<int> vals) =>
        vals.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.toDouble())).toList();
    List<FlSpot> _toSpotsStatus(List<bool> vals) =>
        vals.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value ? 1 : 0)).toList();

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.battery_full),
            title: Text('Battery: ${live.battery}%'),
          ),
          ListTile(
            leading: Icon(live.deviceStatus ? Icons.power : Icons.power_off),
            title: Text('Status: ${live.deviceStatus ? 'Online' : 'Offline'}'),
          ),
          ListTile(
            leading: Icon(Icons.memory),
            title: Text('Key: ${live.key}'),
          ),
          SizedBox(height: 16),
          MetricChart(title: 'Battery %', spots: _toSpotsInt(history.map((e) => e.battery).toList())),
          MetricChart(title: 'Device Status', spots: _toSpotsStatus(history.map((e) => e.deviceStatus).toList())),
        ],
      ),
    );
  }
}
