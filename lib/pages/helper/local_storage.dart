import 'package:freepayagency/pages/models/company.dart';
import 'package:get_storage/get_storage.dart';

class localstorage {
  static final storage = GetStorage();
  static Company company = Company();
  static get username => storage.read("username") ?? '';
  static get token => storage.read("token");
  static get idcompany => storage.read("idcompany");

  static get deletetoken => storage.remove("token");
  static get deletename => storage.remove("username");

  static get cartecode => storage.read("cartecode");

  static get adress => storage.read("adress");
  static get phone => storage.read("phone");
  static get email => storage.read("email");
  static get description => storage.read("description");
  static get quartier => storage.read("quartier");
  static get password => storage.read("password");
  static get raison => storage.read("raison");
  static get img => storage.read("img");
  static get emailresert => storage.read("emailresert");
  static get status => storage.read("status");


  static setCarteCode(code) async {
    storage.write("cartecode", code);
  }

  static resertemail (email) async {
    storage.write("emailresert", email);
  }

  static costumerinfo(
      {username,
      token,
      idcompany,
      adress,
      phone,
      email,
      description,
      quartier,
      password,
      raison,
      img,
      status
      
      }) async {
    storage.write("username", username);
    storage.write("token", token);
    storage.write("idcompany", idcompany);

    storage.write("adress", adress);
    storage.write("status", status);
    storage.write("phone", phone);
    storage.write("email", email);
    storage.write("description", description);
    storage.write("quartier", quartier);
    storage.write("password", password);
    storage.write("raison", raison);
    storage.write("img", img);
  }
}
