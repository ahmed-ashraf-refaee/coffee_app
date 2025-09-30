import 'package:supabase_flutter/supabase_flutter.dart';

class AddressService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetch all addresses for the current user
  Future<List<Map<String, dynamic>>> fetchAddresses() async {
    final userId = _supabase.auth.currentUser!.id;
    final response = await _supabase
        .from('addresses')
        .select()
        .eq('user_id', userId)
        .order('id', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  /// Add new address
  Future<void> addAddress({
    required String street,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
  }) async {
    final userId = _supabase.auth.currentUser!.id;

    await _supabase.from('addresses').insert({
      'user_id': userId,
      'street': street,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'phone_number': phoneNumber,
    });
  }

  /// Update an address by ID
  Future<void> updateAddress({
    required int id,
    String? street,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
  }) async {
    final updates = <String, dynamic>{};
    if (street != null) updates['street'] = street;
    if (city != null) updates['city'] = city;
    if (latitude != null) updates['latitude'] = latitude;
    if (longitude != null) updates['longitude'] = longitude;
    if (phoneNumber != null) updates['phone_number'] = phoneNumber;

    await _supabase.from('addresses').update(updates).eq('id', id);
  }

  /// Delete an address by ID
  Future<void> deleteAddress(int id) async {
    await _supabase.from('addresses').delete().eq('id', id);
  }
}
