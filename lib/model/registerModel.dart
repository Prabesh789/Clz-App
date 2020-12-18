class Model {
  final String table = 'register';
  String registerId;
  String firstName;
  String lastName;
  String contactNo;
  String email;
  String password;

  Model(
      {this.registerId,
      this.firstName,
      this.lastName,
      this.contactNo,
      this.email,
      this.password});

  factory Model.fromJson(Map<String, dynamic> inputData) {
    return Model(
      registerId: inputData['registerId'],
      firstName: inputData['firstName'],
      lastName: inputData['lastName'],
      contactNo: inputData['contactNo'],
      email: inputData['email'],
      password: inputData['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'registerId': registerId,
      'fisrtName': firstName,
      'lastName': lastName,
      'contactNo': contactNo,
      'email': email,
      'password': password
    };
  }
}
