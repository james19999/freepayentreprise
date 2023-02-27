import 'package:get_storage/get_storage.dart';

class localstorage {
  static final storage = GetStorage();

  static get username => storage.read("username") ?? '';
  static get token => storage.read("token");
  static get idcompany => storage.read("idcompany");

  static get deletetoken => storage.remove("token");
  static get deletename => storage.remove("username");
  static get cartecode => storage.read("cartecode");

  static setCarteCode(code) async {
    storage.write("cartecode", code);
  }

  static costumerinfo({username, token, idcompany}) async {
    storage.write("username", username);
    storage.write("token", token);
    storage.write("idcompany", idcompany);
  }
}
