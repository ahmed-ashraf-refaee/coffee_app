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

  Future<void> insertUserData({
    required String userId,
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String createdAt,
  }) async {
    await _supabaseClient.from("users").insert({
      'id': userId,
      'email': email,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'created_at': createdAt,
    });
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final userId = _supabaseClient.auth.currentUser!.id;
    final response = await _supabaseClient
        .from("users")
        .select()
        .eq('id', userId)
        .single();
    return response;
  }

  Future<String?> fetchCustomerId() async {
    final userId = _supabaseClient.auth.currentUser!.id;
    final response = await _supabaseClient
        .from("users")
        .select("customer_id")
        .eq('id', userId)
        .maybeSingle();
    return response?['customer_id'];
  }

  Future<void> updateUserProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? customerId,
    String? profileImageUrl,
  }) async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      final Map<String, dynamic> updateData = {};

      if (username != null && username.isNotEmpty) {
        updateData['username'] = username;
      }
      if (firstName != null && firstName.isNotEmpty) {
        updateData['first_name'] = firstName;
      }
      if (lastName != null && lastName.isNotEmpty) {
        updateData['last_name'] = lastName;
      }
      if (customerId != null && customerId.isNotEmpty) {
        updateData['customer_id'] = customerId;
      }
      if (profileImageUrl != null && profileImageUrl.isNotEmpty) {
        updateData['profile_image_url'] = profileImageUrl;
      }

      if (updateData.isNotEmpty) {
        await _supabaseClient
            .from("users")
            .update(updateData)
            .eq('id', user.id);
      }
    }
  }

  Future<void> logout() async {
    await _supabaseClient.auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("remember_me", false);
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
    final existingUser = await _supabaseClient
        .from('users')
        .select('email')
        .eq('email', email)
        .maybeSingle();

    if (existingUser == null) {
      throw ('User with provided email does not exist.');
    }

    return await _supabaseClient.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.supabase.flutterapp://reset-password',
    );
  }

  Future<AuthResponse> verify(String token, String email) async {
    return await _supabaseClient.auth.verifyOTP(
      type: OtpType.email,
      email: email,
      token: token,
    );
  }

  Future<UserResponse> updatePassword(String newPassword) async {
    return await _supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
}
