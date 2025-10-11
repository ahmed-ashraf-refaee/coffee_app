import 'package:coffee_app/core/services/app_locale.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AnalysisService {
  AnalysisService();
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<Map<String, dynamic>> fetchDashboardStats() async {
    final response = await _supabaseClient.rpc('get_dashboard_stats');
    return response as Map<String, dynamic>;
  }

  Future<List<dynamic>> fetchSalesTrend() async {
    final response = await _supabaseClient.rpc('get_sales_trend');
    return response as List<dynamic>;
  }

  Future<List<dynamic>> fetchTopCategories() async {
    final response = await _supabaseClient.rpc(
      'get_top_categories',
      params: {'lang_code': AppLocale.current.languageCode},
    );
    return response as List<dynamic>;
  }
}
