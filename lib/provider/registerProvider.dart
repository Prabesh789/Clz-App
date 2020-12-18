import 'package:Hello_Doctor/model/registerModel.dart';
import 'package:Hello_Doctor/services/database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class RegisterProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _registerId;
  String _firstName;
  String _lastName;
  String _contactNo;
  String _email;
  String _password;
  var uuid = Uuid();

  //Geters

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get contactNo => _contactNo;
  String get email => _email;
  String get password => _password;
  Stream<List<Model>> get model => firestoreService.getData('register');

  //Seters
  set changeFname(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  set changeLname(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  set changeCNo(String contactNo) {
    _contactNo = contactNo;
    notifyListeners();
  }

  set changeemail(String email) {
    _email = email;
    notifyListeners();
  }

  set changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  loadAll(Model model) {
    if (model != null) {
      _firstName = model.firstName;
      _lastName = model.lastName;
      _contactNo = model.contactNo;
      _email = model.email;
      _password = model.password;
    } else {
      _registerId = null;
      _firstName = null;
      _lastName = null;
      _contactNo = null;
      _email = null;
      _password = null;
    }
  }

  //save

  saveRegisterData() {
    if (_registerId == null) {
      var newData = Model(
          firstName: _firstName,
          lastName: _lastName,
          contactNo: _contactNo,
          email: _email,
          password: _password,
          registerId: uuid.v1());
      firestoreService.upsertData(newData);
    } else {
      var existingData = Model(
          firstName: _firstName,
          lastName: _lastName,
          contactNo: _contactNo,
          email: _email,
          password: _password,
          registerId: _registerId);
      firestoreService.upsertData(existingData);
    }
  }

  deleteTodo(String registerId) {
    firestoreService.deleteData('register', registerId);
  }
}
