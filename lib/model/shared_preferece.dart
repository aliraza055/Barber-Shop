import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferece {
  final  String nameKey="NAME";
  Future sendName(String name)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  return pref.setString(nameKey, name);
  }
}