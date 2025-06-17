// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

// Import your four tabs
import '../tabs/home_tab.dart';
import '../tabs/history_tab.dart';
import '../tabs/device_tab.dart';
import '../tabs/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabs = ['Home', 'History', 'Device', 'Profile'];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          bottom: TabBar(
            tabs: tabs.map((t) => Tab(text: t)).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            HistoryTab(),
            DeviceTab(),
            ProfileTab(),
          ],
        ),
      ),
    );
  }
}
