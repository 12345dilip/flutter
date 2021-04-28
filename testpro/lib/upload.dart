import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:flutter_native_image/flutter_native_image.dart';



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

  addImage(name)async {
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
    imageResized=null;

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
        title: Text('Upload'),
      ),
        body: ListView(
                        children: [
                          Container(
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
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text('Name'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text('Uploads'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            onPressed: () {}),
                                      ),
                                    ]),
                                    for (var k = 0;
                                        k <
                                            this
                                                .widget
                                                .prod['uploadDocument']
                                                .length;
                                        k++)
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(this.widget.prod['uploadDocument']
                                                  [k]['clientDocument']),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              child: Column(
                                                children: [
                                                  Icon(Icons.visibility),
                                                  Text('Show Image'),
                                                ],
                                              ),
                                             onTap: () async {
                                               await showDialog(
                                            context: context,
                                                builder: (_) => ImageDialog(
                                                 img: this
                                                    .widget
                                                    .prod['uploadDocument'][k]
                                                ['clientUpload']['file'],
                                                  
                                                )
                                                );
                                              },
                                              ),
                                              )
                                             ),
                                     
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:  IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            onPressed: () {
                                              removeContacts(k);
                                            }),
                                        ),
                                        ]),
                                  ],
                                  border: TableBorder.all(
                                      width: 1, color: Colors.purple),
                                ),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        displayForm = true;
                                      });
                                    }),
                                Text('Add Upload Field'),
                                if (displayForm)
                                  Container(
                                      child: Column(children: [
                                    TextFormField(
                                      decoration:
                                          InputDecoration(labelText: 'Name '),
                                      controller: name,
                                    ),
                                    imageResized == null
                                        ? Container()
                                        : Image.file(imageResized),
                                      
                                    Row(
                                      children: [
                                        RaisedButton(
                                          child: Text('Uploads'),
                                          onPressed: selectImage,
                                        ),
                                       
                                      ],
                                    ),
                                  ])),
                                   RaisedButton(
                                            child: Text('Submit'),
                                            onPressed: () {
                                              addImage(name.text);
                                               name.clear();
                                                photoBase64.isEmpty;
                                                displayForm = false;
                                           }),
                                           ],
                            ),
                          ),
                        ],
                      ),
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