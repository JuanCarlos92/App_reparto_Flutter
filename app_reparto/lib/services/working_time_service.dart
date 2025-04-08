import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_service.dart';

class WorkingTimeService {
  static const String baseUrl = 'https://3f78-80-102-248-37.ngrok-free.app';

  static Future<bool> saveWorkingTime(Map<String, dynamic> workingTimeData) async {
    try {
      final token = await TokenService.getToken();
      
      final response = await http.post(
        Uri.parse('$baseUrl/working-time'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(workingTimeData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Error saving working time: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to save working time: $e');
    }
  }
}