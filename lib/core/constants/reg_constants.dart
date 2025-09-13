class RegConstants {
  static final RegExp nameRegExp = RegExp(r"^[\p{L}'-.]+$", unicode: true);
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
  );
}
