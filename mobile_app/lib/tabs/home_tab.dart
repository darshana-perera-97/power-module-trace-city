import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final live = state.liveData;
    if (live == null) return Center(child: CircularProgressIndicator());

    final hour = DateTime.now().hour;
    final greet =
        hour < 12
            ? 'Good morning'
            : hour < 17
            ? 'Good afternoon'
            : 'Good evening';

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greet, ${state.selectedUser?.userName ?? ''}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 16),
          _SectionCard(
            title: 'Current Account Status',
            children: [
              _InfoTile(label: 'Live Power', value: '${live.livepower} W'),
              _InfoTile(label: 'Total Power', value: '${live.totalpower} Wh'),
            ],
          ),
          SizedBox(height: 16),
          _SectionCard(
            title: 'Current Quality',
            children: [
              _InfoTile(label: 'Current', value: '${live.current} A'),
              _InfoTile(label: 'Voltage', value: '${live.voltage} V'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext ctx) => Card(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ],
      ),
    ),
  );
}

class _InfoTile extends StatelessWidget {
  final String label, value;
  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext ctx) => Column(
    children: [
      Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      Text(label),
    ],
  );
}
