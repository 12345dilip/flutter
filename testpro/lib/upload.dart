import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:testpro/first_page.dart';
import 'package:testpro/main.dart';
import 'package:testpro/string.dart';

class Upload extends StatefulWidget {
  Upload({
    this.prod,
  });
  final Map prod;
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool displayForm = false;

  selectImage() {
    getImage(ImageSource.gallery);
   

  }

  File imageResized;
  PickedFile _photo;
  String photoBase64;

  getImage(source) async {
    var photo = await picker.getImage(source: ImageSource.gallery);
    imageResized = await FlutterNativeImage.compressImage(
      photo.path,
    );
    setState(() {
      _photo = photo;
      List<int> imageBytes = imageResized.readAsBytesSync();
      photoBase64 = base64Encode(imageBytes);
    });
  }

  addImage(name) async {
    setState(() {
      final value2 = {
        'clientDocument': name,
        'clientUpload': {'file': photoBase64, 'name': name, 'type': "jpg"},
      };
      print(value2);
      print(this.widget.prod['uploadDocument']);
      this.widget.prod['uploadDocument'].add(value2);
      print(this.widget.prod['uploadDocument'].runtimeType);
    });

    final response = await http.put(BaseUrl.updateUsers,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.widget.prod));

    var res = response.body;
    imageResized = null;

    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  removeContacts(k) {
    setState(() {
      this.widget.prod['uploadDocument'].removeAt(k);
    });
  }

  showImage(img64) {
    final convertedImg = base64.decode(img64);
    return new Image.memory(convertedImg);
  }

  final name = TextEditingController();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
          title: Text('Upload'),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
              onPressed: () {
               
               Navigator.pushNamed(context, MYAPP_PAGE);
                
              })),

      body: Stack(
              children: [
                ListView(
                        padding: EdgeInsets.only( bottom: 80),
                       // physics: NeverScrollableScrollPhysics(),
                       // itemBuilder: (context, index) {
         children: [
           Container(
            // padding: const EdgeInsets.only(left:20.0, right: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Table(
                      columnWidths: {
                        0: FixedColumnWidth(90),
                        1: FlexColumnWidth(20),
                        2: FlexColumnWidth(7),
                      },
                      children: [
                       // TableRow(children: [
                        //   Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Text('Name'),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Text('Uploads'),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: IconButton(
                        //         icon: Icon(Icons.delete), onPressed: () {}),
                        //   ),
                        // ]),
                        
                        for (var k = 0;
                            k < this.widget.prod['uploadDocument'].length;
                            k++)
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(this.widget.prod['uploadDocument'][k]
                                  ['clientDocument']),
                            ),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Icon(Icons.visibility),
                                    //Text('Show Image'),
                                  ],
                                ),
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(
                                            img: this.widget.prod['uploadDocument']
                                                [k]['clientUpload']['file'],
                                          ));
                                },
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Text('Do you want Delete'),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                     Navigator.of(context, rootNavigator: true).pop(true);
                                                    },
                                                    child: Text('No',style:
                                                     TextStyle(color: Colors.tealAccent.shade700,),)),
                                                FlatButton(
                                                    onPressed: () {
                                                      removeContacts(k);
                                                     Navigator.of(context, rootNavigator: true).pop(true);
                                                    },
                                                    child: Text('Yes',style:
                                                     TextStyle(color: Colors.tealAccent.shade700,),))
                                              ],
                                            ));
                                  }),
                            ),
                          ]),
                      ],
                     border: TableBorder.all(width: 1, color: Colors.tealAccent.shade700),
                    ),
               
                    //Text('Add Upload Field'),
                    if (displayForm)
                      Container( padding: const EdgeInsets.only(left:20),
                          child: Column(children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Name '),
                          controller: name,
                        ),
                        imageResized == null
                            ? Container()
                            : Image.file(imageResized),
                        Row(
                          children: [
                            RaisedButton(color: Colors.tealAccent.shade700,
                           child: Text('Uploads',style: TextStyle(
                            color: Colors.white
                           ),),
                              onPressed: selectImage,
                            ),  
                          ],
                        ),
                      ])
                      ),
                   
                  ],
              ),
         ),]
                       // },
                
        ),
               
                Align(
            alignment: Alignment.bottomLeft,
            child: Container(
             padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                if (displayForm)
                   RaisedButton(color: Colors.tealAccent.shade700,
                        child: Text('Submit',
                        style: TextStyle(
                          color: Colors.white
                         ),),
                        onPressed: () {
                          addImage(name.text);
                          name.clear();
                          photoBase64.isEmpty;
                          displayForm = false;
                        }),
                  
                 
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: FloatingActionButton(
                     onPressed: () {
                          setState(() {
                            displayForm = true;
                          });
                     },
                    child:Icon(Icons.add),
                      backgroundColor: Colors.tealAccent.shade700,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
               ] ),
     
    );
  }
}

class ImageDialog extends StatefulWidget {
  ImageDialog({
    this.img,
  });
  final String img;

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  showImage(img64) {
    final convertedImg = base64.decode(img64);
    return new Image.memory(convertedImg);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // width: 200,
        // height: 200,
        child: showImage(this.widget.img),
      ),
    );
  }
}
