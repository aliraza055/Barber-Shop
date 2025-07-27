import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferece {
  final  String nameKey="NAME";
    final  String gmailKey="Gmail";
        final  String contactKey="CONTACT";


  Future sendName(String name)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  return pref.setString(nameKey, name);
  }
  Future getName()async{
   SharedPreferences pref=await SharedPreferences.getInstance();
  return pref.get(nameKey);
  }
  Future sendGmail(String gmail)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
 return pref.setString(gmailKey, gmail);
  }
  Future getGmail()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
   return pref.get(gmailKey);
  }
  Future sendContact(String contact)async{
   SharedPreferences pref=await SharedPreferences.getInstance();
return pref.setString(contactKey, contact);

  }
Future getPhoto()async{
      SharedPreferences pref=await SharedPreferences.getInstance();
return pref.get(contactKey);
}

}