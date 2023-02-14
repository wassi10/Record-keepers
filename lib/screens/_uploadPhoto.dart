import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_new/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'buttons.dart';

class Uploadphoto extends StatefulWidget {
  Uploadphoto({Key? key}) : super(key: key);

  @override
  State<Uploadphoto> createState() => _UploadphotoState();
}

class _UploadphotoState extends State<Uploadphoto> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User? user = auth.currentUser;
  late String? uid = user?.uid;
  CollectionReference reef = FirebaseFirestore.instance.collection('uinfo');
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future getImageGallary() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedfile != null) {
        _image = File(pickedfile.path);
      } else {}
    });
  }

  GlobalKey<FormState> key = GlobalKey();

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Photo'),
        ),
        body: StreamBuilder(
            stream: reef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = streamSnapshot.data!.docs[index];
                      if (uid != data.id) {
                        return Container(
                          height: 0,
                          width: 0,
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: key,
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    getImageGallary();
                                  },
                                  child: _image == null
                                      ? Padding(
                                          padding: defaultPadding,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.grey,
                                              ),
                                              height: 350,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Icon(Icons.image)),
                                        )
                                      : Padding(
                                          padding: defaultPadding,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.grey,
                                            ),
                                            height: 350,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: (Image.file(
                                              _image!,
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                InkWell(
                                    onTap: () async {
                                      String uniqueFileName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();
                                      Reference referenceRoot =
                                          FirebaseStorage.instance.ref();
                                      Reference referenceDirImages =
                                          referenceRoot.child('iimages');
                                      Reference referenceImageToUpload =
                                          referenceDirImages
                                              .child(uniqueFileName);

                                      await referenceImageToUpload
                                          .putFile(File(_image!.path));
                                      var newurl = await referenceImageToUpload
                                          .getDownloadURL();

                                      if (newurl == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Please upload an image')));

                                        return;
                                      } else {
                                        _update(data.id, newurl.toString());
                                      }
                                    },
                                    child: Padding(
                                      padding: defaultPadding,
                                      child: Buttons(
                                        buttonText: 'Upload',
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      }
                    });
              } else {
                return Text("Hahah");
              }
            }));
  }

  Future<void> _update(String dataID, String img) async {
    print(dataID);
    await reef.doc(dataID).update({"img": img});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Updated"),
      backgroundColor: primaryColor,
    ));
    Navigator.pop(context);
  }
}
