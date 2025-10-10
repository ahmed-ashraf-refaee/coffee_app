import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_role_state.dart';

class AdminRoleCubit extends Cubit<AdminRoleState> {
  AdminRoleCubit()
    : super(const AdminRoleState(isAdminUser: false, isAdminMode: false));
  Future<void> loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    final isAdminUser = prefs.getBool('isAdminUser') ?? false;
    final isAdminMode = prefs.getBool('isAdminMode') ?? false;
    emit(AdminRoleState(isAdminUser: isAdminUser, isAdminMode: isAdminMode));
  }

  Future<void> toggleAdminMode() async {
    final prefs = await SharedPreferences.getInstance();
    final newMode = !state.isAdminMode;
    await prefs.setBool('isAdminMode', newMode);
    emit(state.copyWith(isAdminMode: newMode));
  }

  bool get isAdminUser => state.isAdminUser;
  bool get isAdminMode => state.isAdminMode;
}
