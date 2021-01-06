import 'dart:io';
import 'package:Hello_Doctor/Loginpage.dart';
import 'package:Hello_Doctor/Widget/customTextField.dart';
import 'package:Hello_Doctor/Widget/custom_image_picker_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart' as validator;
import 'package:path/path.dart' as path;

class UserRegister extends StatefulWidget {
  final String userType;

  const UserRegister({@required this.userType});
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final TextEditingController fullNameController = TextEditingController();
  String photoUrl;
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  String error = "";
  final picker = ImagePicker();
  File _image;
  void dispose() {
    fullNameController.dispose();

    contactNoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  void registerUser() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim()))
          .user;
      String fileName = path.basename(_image.path);
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('user_profile')
          .child(fileName);
      firebase_storage.UploadTask uploadTask = reference.putFile(_image);
      firebase_storage.TaskSnapshot storageTaskSnapshot;
      uploadTask.then((value) {
        if (value != null) {
          storageTaskSnapshot = value;
          storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
            await FirebaseFirestore.instance
                .collection('user')
                .doc(user.uid)
                .set({
              'fullName': fullNameController.text.trim(),
              'contact': contactNoController.text.trim(),
              'email': emailController.text.trim(),
              'password': passwordController.text.trim(),
              'department': "",
              'bio': "",
              'verificationDoc': '',
              'photoUrl': downloadUrl,
              'userType': widget.userType,
              'chattingWith': "",
              'documentID': user.uid,
            }).then((value) {
              setState(() {
                photoUrl = downloadUrl;
              });
              FirebaseAuth.instance.signOut();
            });
          }, onError: (err) async {
            if (mounted)
              setState(() {
                isLoading = false;
              });
            Fluttertoast.showToast(
              msg: 'This file is not an image',
            );
          });
        } else {
          if (mounted)
            setState(() {
              isLoading = false;
            });
          Fluttertoast.showToast(
            msg: 'This file is not an image',
          );
        }
      });

      if (mounted)
        setState(() {
          isLoading = false;
        });
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) {
        return new LoginPage(
          userType: widget.userType,
        );
      }));
    } catch (e) {
      if (mounted)
        setState(() {
          error = e.message.toString();
          isLoading = false;
        });
    }
  }

  //choose file
  Future chooseFile({dynamic type, bool isProfile}) async {
    var source;
    if (type == "gallery") {
      source = ImageSource.gallery;
    } else if (type == "camera") {
      source = ImageSource.camera;
    }
    await picker.getImage(source: source).then((image) {
      if (image != null) {
        _cropImage(
          image: File(image.path),
        );
      }
    });
  }

//crop file
  Future<Null> _cropImage({
    File image,
  }) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 1080,
      maxHeight: 1080,
      cropStyle: CropStyle.circle,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarWidgetColor: Colors.black,
        backgroundColor: Colors.black,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        statusBarColor: Colors.transparent,
      ),
    );
    if (croppedImage != null) {
      if (mounted)
        setState(() {
          _image = croppedImage;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: Text("Register".toUpperCase()),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          (_image == null)
                              ? (photoUrl != null
                                  ? Card(
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 55,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          photoUrl,
                                        ),
                                      ),
                                    )
                                  : Card(
                                      shape: CircleBorder(),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 10,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 55,
                                      ),
                                    ))
                              : Card(
                                  shape: CircleBorder(),
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 10,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 55,
                                    child: Image.file(_image),
                                  ),
                                ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 20),
                                onPressed: () {
                                  CustomImagePickerSheet.showSheet(
                                      context: context,
                                      onPickImageClicked: () {
                                        chooseFile(
                                            type: "gallery", isProfile: true);
                                      },
                                      onTakeImageClicked: () {
                                        chooseFile(
                                            type: "camera", isProfile: true);
                                      });
                                },
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // // Text("Choose Your Profile."),
                        ],
                      ),
                      Container(
                        child: MyTextFormField(
                          icon: Icon(Icons.person),
                          isEmail: false,
                          isPassword: false,
                          labelText: ' Your Full Name',
                          hintText: 'First Name',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your  Fullname';
                            }
                            return null;
                          },
                          controller: fullNameController,
                        ),
                      ),
                      Container(
                        child: MyTextFormField(
                          icon: Icon(Icons.phone),
                          isEmail: false,
                          isPassword: false,
                          labelText: ' Your Contact Number',
                          hintText: 'Contact Number',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter your Contact Number';
                            }
                            return null;
                          },
                          controller: contactNoController,
                        ),
                      ),
                      Container(
                        child: MyTextFormField(
                          icon: Icon(Icons.email),
                          isEmail: true,
                          isPassword: false,
                          labelText: 'Email Address',
                          hintText: 'Email',
                          validator: (String value) {
                            if (!validator.isEmail(value)) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          controller: emailController,
                        ),
                      ),
                      Container(
                        child: MyTextFormField(
                          icon: Icon(Icons.lock),
                          isEmail: false,
                          labelText: 'Your Password',
                          hintText: 'Password',
                          isPassword: true,
                          validator: (String value) {
                            if (value.length < 8) {
                              return 'Password must be minimum 8 characters';
                            }
                            _formkey.currentState.save();
                            return null;
                          },
                          controller: passwordController,
                        ),
                      ),
                      Container(
                        child: MyTextFormField(
                          icon: Icon(Icons.lock),
                          controller: confirmPasswordController,
                          isEmail: false,
                          labelText: 'Confirm Password',
                          hintText: 'Confirm Password',
                          isPassword: true,
                          validator: (String value) {
                            if (value.length < 8) {
                              return 'Password must be minimum 8 characters';
                            } else if (passwordController.text.trim() != null &&
                                passwordController.text.trim() !=
                                    confirmPasswordController.text.trim()) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blueAccent,
                        child: Text('Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();
                            registerUser();

                            // modelProvider.saveRegisterData();
                            // context.read<AuthenticationService>().signUp(
                            //       email: emailController.text,
                            //       password: passwordController.text,
                            //     );
                            // //all your data gets store in this.user and you have to call
                            // // database operation or service call over here
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => Loginpage()));
                          } else if (_image == null) {
                            Fluttertoast.showToast(msg: "Please Pick Image");
                          } else {
                            Fluttertoast.showToast(msg: "Fill All Data");
                          }
                        },
                      ),
                      error == "" ? SizedBox() : Text(error),
                    ],
                  ),
                ),
              ),
            ),
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Please wait...",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
