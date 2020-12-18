// Widget imageProfile() {
//   return Center(
//     child: Stack(
//       children: <Widget>[
//         CircleAvatar(
//           radius: 80.0,
//           backgroundImage: AssetImage('assets/images/profile.jpg'),
//         ),
//         Positioned(
//             bottom: 20.0,
//             right: 20.0,
//             child: InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                     context: context, builder: ((builder) => bottomSheet()));
//               },
//               child: Icon(
//                 Icons.camera_alt,
//                 color: Colors.teal[300],
//                 size: 25.0,
//               ),
//             ))
//       ],
//     ),
//   );
// }

// Widget bottomSheet() {
//   return Container(
//     height: 100.0,
//     width: MediaQuery.of(context).size.width,
//     margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//     child: Column(
//       children: <Widget>[
//         Text(
//           'Choose Profile Picture',
//           style: TextStyle(fontSize: 20.0),
//         ),
//         SizedBox(
//           height: 20.0,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FlatButton.icon(
//               icon: Icon(Icons.camera),
//               onPressed: () {},
//               label: Text('Camera'),
//             ),
//             FlatButton.icon(
//               icon: Icon(Icons.image),
//               onPressed: () {},
//               label: Text('Gallary'),
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }

// void takePhoto(ImageSource source) async {
//   final PickedFile = await _picker.getImage(
//     source: source,
//   );
//   setState(() {
//     _iamgeFile = pickedFile;
//   });
// }
