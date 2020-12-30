class UserModel {
  final String userType;
  final String fullName;
  final String contact;
  final String department;
  final String email;
  final String password;
  final String bio;
  final String uid;
  final String photoUrl;
  final String verificationDoc;

  UserModel({
    this.bio,
    this.userType,
    this.uid,
    this.contact,
    this.department,
    this.email,
    this.fullName,
    this.password,
    this.photoUrl,
    this.verificationDoc,
  });
}
