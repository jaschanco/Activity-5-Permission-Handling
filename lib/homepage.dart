// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, avoid_print, avoid_web_libraries_in_flutter, unnecessary_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String photoPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.image),
        title: const Text('Flutter Permission Handling'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            photoPath == '' ? Image.asset(
              'assets/images/image.png',
              height: 200,
              width: 200,
              fit: BoxFit.fill
            ) : Image.file(
              File(photoPath),
                height: 200,
                width: 200,
                fit: BoxFit.fill
            ),

            const SizedBox(
              height: 15.0,
            ),

            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.pink),
                    padding:
                    MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 20, color: Colors.black,)
                    ),
                ),
                onPressed: () async {
                  PermissionStatus storageStatus = await Permission.storage.request();
                  if(storageStatus == PermissionStatus.granted){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Permission Granted'))
                    );
                  }
                  if(storageStatus == PermissionStatus.denied){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Permission is Needed'))
                    );
                  }
                  if(storageStatus == PermissionStatus.permanentlyDenied){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Permission Permanently Denied'))
                    );
                    openAppSettings();
                  }
                  selectImage();
                  setState(() async {

                  });
                },
                child: const Text('Open Gallery')),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Wrap(
            spacing: 10,
            runSpacing: 10,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  photoPath = await selectingImageFromGallery();
                  print('Image_Path:-');
                  print(photoPath);
                  if (photoPath != '') {
                    Navigator.pop(context);
                    setState(() {

                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No Image Selected"),
                        ));
                  }
               },
               child: Center(
                 child: Card(
                     elevation: 5,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [
                           Image.asset(
                             'assets/images/gallery.png',
                             height: 200,
                             width: 200,
                           ),
                           const SizedBox(
                             height: 20.0,
                           ),
                           const Text('Select Gallery'),
                         ],
                       ),
                     )
                 ),
               )


              ),
            ],
          );
        });
  }

  selectingImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}