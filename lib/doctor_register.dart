import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:Hello_Doctor/Loginpage.dart';
import 'package:Hello_Doctor/Widget/custom_image_picker_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart' as validator;
import 'package:path/path.dart' as path;

class DoctorRegister extends StatefulWidget {
  final String userType;

  const DoctorRegister({@required this.userType});
  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  final GlobalKey<FormState> _formkeyValue = new GlobalKey<FormState>();
  var selectedType;
  List<String> _departmentType = <String>[
    'General Physician',
    'Gynecologist',
    'Cardiologist',
    'Paediatricians',
    'Dentist',
    'Pulmonologist',
    'Endocrinologists',
    "Dermatologists ",
    'Ophthalmologist ',
    'Nutritionists',
    'Medical Oncologist',
    'Reproductive endocrinologists',
    'Others'
  ];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  File _image;
  File doc;
  String photoUrl;
  String verificationDoc;
  final picker = ImagePicker();
  bool isLoading = false;
  String error = "";
  void dispose() {
    fullNameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    super.dispose();
  }

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
      uploadTask.then(
        (value) {
          if (value != null) {
            storageTaskSnapshot = value;
            storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) async {
              String fileName = path.basename(_image.path);
              firebase_storage.Reference reference = firebase_storage
                  .FirebaseStorage.instance
                  .ref()
                  .child('verification_doc')
                  .child(fileName);
              firebase_storage.UploadTask uploadTask =
                  reference.putFile(_image);
              firebase_storage.TaskSnapshot storageTaskSnapshot;
              uploadTask.then((value) {
                if (value != null) {
                  storageTaskSnapshot = value;
                  storageTaskSnapshot.ref.getDownloadURL().then((url) async {
                    await FirebaseFirestore.instance
                        .collection('user')
                        .doc(user.uid)
                        .set({
                      'fullName': fullNameController.text.trim(),
                      'contact': contactController.text.trim(),
                      'email': emailController.text.trim(),
                      'password': passwordController.text.trim(),
                      'department': selectedType,
                      'verificationDoc': url,
                      'photoUrl': downloadUrl,
                      'bio': bioController.text.trim(),
                      'userType': widget.userType,
                      'chattingWith': "",
                      'documentID': user.uid,
                    }).then((value) {
                      setState(() {
                        photoUrl = downloadUrl;
                        verificationDoc = url;
                      });
                      FirebaseAuth.instance.signOut();
                      if (mounted)
                        setState(() {
                          isLoading = false;
                        });
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(
                              builder: (BuildContext context) {
                        return new LoginPage(
                          userType: widget.userType,
                        );
                      }));
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
            });
          }
        },
      );
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
          isProfile: isProfile,
        );
      }
    });
  }

  //crop file
  Future<Null> _cropImage({
    File image,
    bool isProfile,
  }) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      maxWidth: 1080,
      maxHeight: 1080,
      cropStyle: isProfile ? CropStyle.circle : CropStyle.rectangle,
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
          if (isProfile) {
            _image = croppedImage;
          } else {
            doc = croppedImage;
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final halfMediawidth = MediaQuery.of(context).size.width / 1.3;
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Create Your Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formkeyValue,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
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
                        padding: EdgeInsets.all(8.0),
                        child: nameTextField(fullNameController),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: contactNoTextField(contactController),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: emailTextField(emailController),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: passwoerdTextField(passwordController),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Please select department";
                            }
                            return null;
                          },
                          dropdownColor: Colors.white,
                          items: _departmentType
                              .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value,
                                      //style: TextStyle(color: Color(0xff11b719)),
                                    ),
                                    value: value,
                                  ))
                              .toList(),
                          onChanged: (selectedDepartmentType) {
                            if (mounted)
                              setState(() {
                                selectedType = selectedDepartmentType;
                              });
                          },
                          value: selectedType,
                          isExpanded: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            prefixIcon: Icon(
                              Icons.medical_services,
                              color: Colors.green,
                            ),
                            labelText: 'Select Your Department',
                            labelStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(8.0),
                          child: descriptionTextField(bioController)),
                      InkWell(
                        onTap: () {
                          CustomImagePickerSheet.showSheet(
                            context: context,
                            onPickImageClicked: () {
                              chooseFile(type: "gallery", isProfile: false);
                            },
                            onTakeImageClicked: () {
                              chooseFile(type: "camera", isProfile: false);
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            (doc == null)
                                ? (verificationDoc != null
                                    ? Card(
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 10,
                                        child: Container(
                                          height: 200,
                                          width: halfMediawidth,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                photoUrl,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Card(
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 10,
                                        child: Container(
                                          height: 200,
                                          width: halfMediawidth,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                : Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 10,
                                    child: Container(
                                      height: 200,
                                      width: halfMediawidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: FileImage(doc),
                                        ),
                                      ),
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
                                    color: Colors.blue[900],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Tap to Choose document",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // // Text("Choose Your Profile."),
                          ],
                        ),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.only(left: 100, right: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        color: Colors.indigo,
                        elevation: 10.0,
                        highlightElevation: 20.0,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formkeyValue.currentState.validate()) {
                            if (_image == null && doc == null) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Either Profile or Document image is Empty');
                            } else {
                              registerUser();
                            }
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

Widget nameTextField(TextEditingController fullNameController) {
  return TextFormField(
    controller: fullNameController,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.indigoAccent,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: 'Full Name',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Prabesh Kirat Rai'),
  );
}

Widget contactNoTextField(TextEditingController contactController) {
  return TextFormField(
    controller: contactController,
    validator: (value) {
      if (value.isEmpty) {
        return "Enter Contact Number";
      }
      return null;
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.green,
        ),
        labelText: 'Mobile/Phome Number',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: '+977 982-083828'),
    maxLength: 16,
    keyboardType: TextInputType.phone,
  );
}

Widget emailTextField(TextEditingController emailController) {
  return TextFormField(
    controller: emailController,
    validator: (String value) {
      if (!validator.isEmail(value)) {
        return 'Invalid Email';
      }
      return null;
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.green,
        ),
        labelText: 'Email address',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'rai@gmail.com'),
    keyboardType: TextInputType.emailAddress,
  );
}

Widget passwoerdTextField(TextEditingController passwordController) {
  return TextFormField(
    controller: passwordController,
    validator: (value) {
      if (value.length < 6) {
        return "Legnth must be min 6 character";
      }
      return null;
    },
    obscureText: true,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.green,
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'Password'),
    keyboardType: TextInputType.emailAddress,
  );
}

Widget descriptionTextField(TextEditingController bioController) {
  return TextFormField(
    maxLines: 5,
    controller: bioController,
    validator: (value) {
      if (value.isEmpty) {
        return "Write Something";
      }
      return null;
    },
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black,
        )),
        labelText: 'Write about your-self.',
        labelStyle: TextStyle(
            color: Colors.black87, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintText: 'I am Dr. .......'),
    maxLength: 250,
  );
}
