import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:testpro/string.dart';

class Upload extends StatefulWidget {
  Upload({
    this.prod,
    this.pay,
  });
  final Map prod;
  final String pay;
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool displayForm = false;
  bool statusFAB = true;

  selectImage() {
    getImage(ImageSource.gallery);
  }

  File imageResized;
  PickedFile _photo;
  String photoBase64;
  Map clientDetail;
  List data;
  
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
     this.clientDetail = {
        'clientDocument': name,
        'clientUpload': {'file': photoBase64, 'name': name, 'type': "jpg"},
        'client': this.widget.pay,
      }; 
       data.add(this.clientDetail);
    });
  final response = await http.post(BaseUrl.upload,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.clientDetail));
    var res = response.body;
    imageResized = null;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  getDetail()async{
    var response = await http.get(BaseUrl.upload + this.widget.pay,
        headers: {"Accept": "application/json"});
    this.setState(() {
   data = json.decode(response.body)['data'];
    });
  }
 @override
  void initState() {
    super.initState();
    this.getDetail();
   }
   
  removeContacts(k,id)async {
    print(k);
    setState(() {
      this.data.removeAt(k);
      });
var response = await http.delete(BaseUrl.upload + id,
        headers: {"Accept": "application/json"});
  print(response);
 }
  showImage(img64) {
    final convertedImg = base64.decode(img64);
    return new Image.memory(convertedImg);
  }

  final name = TextEditingController();
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();

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

      body:  data == null
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              ):Stack(
              children: [
                ListView(
                        padding: EdgeInsets.only( bottom: 80),
         children: [
           Container(
             child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(statusFAB)
                   Table(
                      columnWidths: {
                        0: FixedColumnWidth(90),
                        1: FlexColumnWidth(20),
                        2: FlexColumnWidth(7),
                      },
                      children: [
                       for (var k = 0;
                            k < this.data.length;
                            k++)
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(this.data[k]
                                  ['clientDocument']),
                            ),
                            Container(
                                child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                child: Column(
                                  children: [
                                    Icon(Icons.visibility),
                                  ],
                                ),
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) => ImageDialog(
                                            img: this.data
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
                                                      removeContacts(k , this.data[k]['_id']
                                                      );
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
                    if (displayForm)
                      Container( padding: const EdgeInsets.only(left:20),
                          child: Form(
                            key: formKey,
                          child: Column(children: [
                        TextFormField(
                             validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Name';
                          } else if (RegExp(r'[a-zA-Z]+|\s')
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid Name';
                          }
                        },
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
                      ]),
                          )
                      ),
                  ],
              ),
         ),] 
        ),
                if (displayForm)
                Align(
            alignment: Alignment.bottomLeft,
            child: Container(
             padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10,right: 20),
              height: 60,
              width: double.infinity,
              child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    RaisedButton(
                      color: Colors.grey,
                        child: Text('Cancel',
                        style: TextStyle(
                          color: Colors.white,
                         ),),
                        onPressed: () {
                         setState(() {
                            name.clear();
                          photoBase64.isEmpty;
                            displayForm = false;
                             statusFAB = true;
                         });
                         }
                        ),
                         RaisedButton(color: Colors.tealAccent.shade700,
                        child: Text('Submit',
                        style: TextStyle(
                          color: Colors.white
                         ),),
                        onPressed: () {
                           if(imageResized==null)
                           return ;
                         if (formKey.currentState.validate()) {
                          addImage(name.text);
                          name.clear();
                          photoBase64.isEmpty;
                          displayForm = false;
                           statusFAB = true;
                        }}
                        ),
                ],
              ),
            ),
          ),
        if(statusFAB)
           Container(
             padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
             child: Padding(
                      padding: const EdgeInsets.only(top:550.0,left: 270.0),
                      child: FloatingActionButton(
                       onPressed: () {
                            setState(() {
                              displayForm =true;
                              imageResized= null;
                            if(displayForm=true){
                                  statusFAB= false;
                            }
                         });
                       },
                      child:Icon(Icons.add),
                        backgroundColor: Colors.tealAccent.shade700,
                        elevation: 0,
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
        child: showImage(this.widget.img),
      ),
    );
  }
}
