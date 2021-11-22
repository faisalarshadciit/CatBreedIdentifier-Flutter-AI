import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<File> imageFile;
  File _image;
  String result = "";
  ImagePicker imagePicker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    imagePicker = ImagePicker();
    loadDataModelFiles();
  }

  loadDataModelFiles() async {
    String output = await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/my_labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false
    );

    print("output : " + output);
  }

  doImageClassification() async {
    var recognition = await Tflite.runModelOnImage(
        path: _image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        threshold: 0.1,
        numResults: 2,
        asynch: true
    );

    print("recognition : " + recognition.length.toString());

    setState(() {
      result = "";
    });

    recognition.forEach((element) {
      setState(() {
        print("element : " + element.toString());
        result += element["label"];
      });
    });
  }

  selectPhoto() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);

    setState(() {
      _image;
      doImageClassification();
    });
  }

  capturePhoto() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    _image = File(pickedFile.path);

    setState(() {
      _image;
      doImageClassification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Stack(
                children: [
                  Center(
                    child: FlatButton(
                        onPressed: selectPhoto,
                        onLongPress: capturePhoto,
                        child: Container(
                          margin: EdgeInsets.only(top: 30.0, right: 35.0, left: 18.0),
                          child: _image != null
                              ? Image.file(
                              _image,
                              height: 160.0,
                              width: 400.0,
                              fit: BoxFit.cover)
                              : Container(
                            width: 140.0,
                            height: 190.0,
                            child: Icon(Icons.camera_alt, color: Colors.black,),),
                        )
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 160.0),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                "$result",
                style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.blueAccent,
                    backgroundColor: Colors.white60,
                    fontFamily: "Brand Bold"
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
