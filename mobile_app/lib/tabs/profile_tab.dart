import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().selectedUser;
    if (user == null) return Center(child: Text('No user selected'));

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(label: 'Name', value: user.userName),
          _InfoRow(label: 'Account', value: user.accountNumber),
          _InfoRow(label: 'Device', value: user.device),
          _InfoRow(label: 'Address', value: user.address),
          _InfoRow(label: 'Phone', value: user.tp),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          SizedBox(
            width: 100,
            child: Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(value)),
        ]),
      );
}
