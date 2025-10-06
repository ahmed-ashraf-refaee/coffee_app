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
    required String address,
    required String city,
    double? latitude,
    double? longitude,
    required String phoneNumber,
    required String state,
    required String title,

    String? optionalPhoneNumber,
  }) async {
    final userId = _supabase.auth.currentUser!.id;

    await _supabase.from('addresses').insert({
      'user_id': userId,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'phone_number': phoneNumber,
      'state': state,
      'optional_phone_number': optionalPhoneNumber,
      'title': title,
    });
  }

  /// Update an address by ID
  Future<void> updateAddress({
    required int id,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? state,
    String? optionalPhoneNumber,
    String? title,
  }) async {
    final updates = <String, dynamic>{};
    if (address != null) updates['address'] = address;
    if (title != null) updates['title'] = title;
    if (city != null) updates['city'] = city;
    if (latitude != null) updates['latitude'] = latitude;
    if (longitude != null) updates['longitude'] = longitude;
    if (phoneNumber != null) updates['phone_number'] = phoneNumber;
    if (state != null) updates['state'] = state;
    if (optionalPhoneNumber != null) {
      updates['optional_phone_number'] = optionalPhoneNumber;
    }

    await _supabase.from('addresses').update(updates).eq('id', id);
  }

  /// Delete an address by ID
  Future<void> deleteAddress(int id) async {
    await _supabase.from('addresses').delete().eq('id', id);
  }
}
