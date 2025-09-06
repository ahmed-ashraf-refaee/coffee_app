import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> login(
    String email,
    String password,
    bool rememberMe,
  ) async {
    var response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("remember_me", rememberMe);
    return response;
  }

  Future<AuthResponse> signup(
    String email,
    String password,
    String username,
    String firstName,
    String lastName,
  ) async {
    var response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user != null) {
      await _supabaseClient.from("users").insert({
        'id': user.id,
        'email': email,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'created_at': user.createdAt,
      });
    }
    return response;
  }

  Future<void> logout() async {
    await _supabaseClient.auth.signOut();
  }

  Future<bool> usernameTaken(String username) async {
    final list = await _supabaseClient
        .from('users')
        .select('username')
        .eq('username', username)
        .maybeSingle();
    return list != null;
  }

  Future<void> resetPassword(String email) async {
    return await _supabaseClient.auth.resetPasswordForEmail(email);
  }
}
