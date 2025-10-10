class AdminRoleState {
  final bool isAdminUser; // The user’s actual role (from backend or prefs)
  final bool isAdminMode; // Whether admin mode is currently enabled in UI

  const AdminRoleState({required this.isAdminUser, required this.isAdminMode});

  AdminRoleState copyWith({bool? isAdminUser, bool? isAdminMode}) {
    return AdminRoleState(
      isAdminUser: isAdminUser ?? this.isAdminUser,
      isAdminMode: isAdminMode ?? this.isAdminMode,
    );
  }
}
