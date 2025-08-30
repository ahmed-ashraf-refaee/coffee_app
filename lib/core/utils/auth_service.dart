import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<AuthResponse> login(String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
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
}
