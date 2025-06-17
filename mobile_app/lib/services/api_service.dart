import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_constants.dart';
import '../models/user.dart';
import '../models/live_data.dart';

class ApiService {
  Future<List<User>> fetchUsers() async {
    final res = await http.get(Uri.parse(ApiConstants.viewUsers));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((j) => User.fromJson(j)).toList();
    }
    throw Exception('Failed to load users');
  }

  Future<LiveData> fetchLiveData() async {
    final res = await http.get(Uri.parse(ApiConstants.deviceLiveData));
    if (res.statusCode == 200) {
      return LiveData.fromJson(jsonDecode(res.body));
    }
    throw Exception('Failed to load live data');
  }

  Future<List<LiveData>> fetchAllData() async {
    final res = await http.get(Uri.parse(ApiConstants.allData));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((j) => LiveData.fromJson(j)).toList();
    }
    throw Exception('Failed to load history data');
  }
}
