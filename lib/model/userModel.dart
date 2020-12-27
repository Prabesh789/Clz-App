class UserModel {
  String userType;
  String fullName;
  String contact;
  String department;
  String email;
  String password;
  String bio;

  UserModel(
      {this.bio,
      this.userType,
      this.contact,
      this.department,
      this.email,
      this.fullName,
      this.password});
}
