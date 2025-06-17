import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/live_data.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  final ApiService api = ApiService();

  List<User>? users;
  User? selectedUser;
  LiveData? liveData;
  List<LiveData>? history;

  Future<void> loadUsers() async {
    users = await api.fetchUsers();
    notifyListeners();
  }

  void selectUser(User u) {
    selectedUser = u;
    notifyListeners();
    refreshAll();
  }

  Future<void> refreshAll() async {
    liveData = await api.fetchLiveData();
    history = await api.fetchAllData();
    notifyListeners();
  }
}
