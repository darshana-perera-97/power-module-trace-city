import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/app_state.dart';
import 'home_screen.dart';

class UserSelectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppState>();

    return Scaffold(
      appBar: AppBar(title: Text('Select Account')),
      body: FutureBuilder<List<User>>(
        future: appState.api.fetchUsers(),
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final users = snap.data!;
          return Center(
            child: DropdownButton<User>(
              hint: Text('Choose user'),
              value: appState.selectedUser,
              items: users
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.userName)))
                  .toList(),
              onChanged: (u) {
                if (u == null) return;
                appState.selectUser(u);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
