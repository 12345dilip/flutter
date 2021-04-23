import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class Product extends StatefulWidget {
  Product({
    this.prod,
  });
  final Map prod;

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
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

  addImage(name) {
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
  }

  removeContact(i) {
    setState(() {
      this.widget.prod['contactPerson'].removeAt(i);
     
      print(this.widget.prod['contactPerson']);
    });
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

  addContact(emailAddress, mobile, cfirstName, clastName) {
    setState(() {
      final value = {
        'emailAddress': emailAddress,
        'mobile': mobile,
        'firstName': cfirstName,
        'lastName': clastName
      };
      this.widget.prod['contactPerson'].add(value);
    });
  }

  final salutation = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final companyName = TextEditingController();
  final contactEmail = TextEditingController();
  final primaryContact = TextEditingController();
  final secondarycontact = TextEditingController();
  final website = TextEditingController();
  // final openingBalance = TextEditingController();
  final facebook = TextEditingController();
  final twitter = TextEditingController();
  final attention = TextEditingController();
  final countryRegion = TextEditingController();
  final street1 = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipCode = TextEditingController();
  final phone1 = TextEditingController();
  final fax = TextEditingController();
  final cfirstName = TextEditingController();
  final clastName = TextEditingController();
  final emailAddress = TextEditingController();
  final mobile = TextEditingController();
  final workPhone = TextEditingController();
  final remarkstext = new TextEditingController();
  // final uploadDocument = new TextEditingController();

  final name = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    this.salutation.text = this.widget.prod['userName']['salutation']['name'];
    this.firstName.text = this.widget.prod['userName']['firstName'];
    this.lastName.text = this.widget.prod['userName']['lastName'];
    this.companyName.text = this.widget.prod['companyName'];
    this.contactEmail.text = this.widget.prod['contactEmail'];
    this.primaryContact.text = this.widget.prod['phone']['primaryContact'];
     this.secondarycontact.text = this.widget.prod['phone']['secondarycontact'];
    this.website.text = this.widget.prod['website'];
    // this.openingBalance.text =
    //     this.widget.prod['otherDetails']['openingBalance'];
    this.facebook.text = this.widget.prod['otherDetails']['facebook'];
    this.twitter.text = this.widget.prod['otherDetails']['twitter'];
    this.attention.text = this.widget.prod['billingAddress']['attention'];

    this.countryRegion.text =
        this.widget.prod['billingAddress']['countryRegion'];
    this.street1.text = this.widget.prod['billingAddress']['Street1'];
    this.city.text = this.widget.prod['billingAddress']['city'];
    this.state.text = this.widget.prod['billingAddress']['state'];
    this.zipCode.text = this.widget.prod['billingAddress']['zipCode'];
    this.phone1.text = this.widget.prod['billingAddress']['phone1'];
    this.fax.text = this.widget.prod['billingAddress']['fax'];
    this.remarkstext.text = this.widget.prod['remarks']['remarkstext'];
  }

  updateDetails(
      salutation,
      firstName,
      lastName,
      companyName,
      //contactEmail,
     // primaryContact,
      secondarycontact,
      website,
      // openingBalance,
      facebook,
      twitter,
      attention,
      countryRegion,
      street1,
      city,
      state,
      zipCode,
      phone1,
      fax,
      remarkstext) async {
    setState(() {
      this.widget.prod['userName']['salutation']['name'] = salutation;
      this.widget.prod['userName']['firstName'] = firstName;
      this.widget.prod['userName']['lastName'] = lastName;
      this.widget.prod['companyName'] = companyName;
     // this.widget.prod['contactEmail'] = contactEmail;
      //this.widget.prod['phone']['primaryContact']= primaryContact;
       this.widget.prod['phone']['secondarycontact']= secondarycontact;
     
      this.widget.prod['website'] = website;
      // this.widget.prod['otherDetails']['openingBalance'] = openingBalance;
      this.widget.prod['otherDetails']['facebook'] = facebook;
      this.widget.prod['otherDetails']['twitter'] = twitter;
      this.widget.prod['billingAddress']['attention'] = attention;

      this.widget.prod['billingAddress']['countryRegion'] = countryRegion;
      this.widget.prod['billingAddress']['Street1'] = street1;
      this.widget.prod['billingAddress']['city'] = city;
      this.widget.prod['billingAddress']['state'] = state;
      this.widget.prod['billingAddress']['zipCode'] = zipCode;
      this.widget.prod['billingAddress']['phone1'] = phone1;
      this.widget.prod['billingAddress']['fax'] = fax;
      this.widget.prod['remarks']['remarkstext'] = remarkstext;
    });
   
    final response = await http.put(BaseUrl.updateUsers,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.widget.prod));

    var res = response.body;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Salutation',
                labelText: 'Salutation',
              ),
              controller: salutation,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'firstName',
                labelText: 'firstName',
              ),
              controller: firstName,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'lastName',
                labelText: 'lastName',
              ),
              controller: lastName,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Company Name',
                labelText: 'Company Name',
              ),
              controller: companyName,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Contact Email',
                labelText: 'Contact Email',
              ),
              controller: contactEmail,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Primary Contact',
                labelText: 'Primary Contact',
              ),
              controller: primaryContact,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Secondary Contact',
                labelText: 'Secondary Contact',
              ),
              controller: secondarycontact,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'website',
                labelText: 'website',
              ),
              controller: website,
            ),
            DefaultTabController(
                length: 4,
                initialIndex: 0,
                child: Column(children: [
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(
                        text: 'Other Details',
                      ),
                      Tab(text: 'Address'),
                      Tab(text: 'Contact Persons'),
                     
                      Tab(text: 'Uploads'),
                    ],
                  ),
                  Container(
                    height: 600,
                    child: TabBarView(children: [
                      Column(
                        children: [
                        
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Facebook',
                              labelText: 'Facebook ',
                            ),
                            controller: facebook,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Twitter',
                              labelText: 'Twitter ',
                            ),
                            controller: twitter,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Attention',
                              labelText: 'Attention ',
                            ),
                            controller: attention,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Country/Region',
                              labelText: 'Country Region ',
                            ),
                            controller: countryRegion,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Street1',
                              labelText: 'Street1 ',
                            ),
                            controller: street1,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'City',
                              labelText: 'City ',
                            ),
                            controller: city,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'State',
                              labelText: 'State ',
                            ),
                            controller: state,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Zip Code',
                              labelText: 'Zip Code ',
                            ),
                            controller: zipCode,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              labelText: 'Phone ',
                            ),
                            controller: phone1,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Fax',
                              labelText: 'Fax',
                            ),
                            controller: fax,
                          ),
                        ],
                      ),
                      Container(
                          child: ListView(children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Table(
                                columnWidths: {
                                  0: FixedColumnWidth(40),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth()
                                },
                                children: [
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('No'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('email'),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Phone')),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          icon: Icon(Icons.remove_circle),
                                          onPressed: () {}),
                                    ),
                                  ]),
                                  for (var i = 0;
                                      i <
                                          this
                                              .widget
                                              .prod['contactPerson']
                                              .length;
                                      i++)
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text((i + 1).toString()),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            this.widget.prod['contactPerson'][i]
                                                    ['mobile'] ??
                                                '-'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            this.widget.prod['contactPerson'][i]
                                                ['emailAddress']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                            icon: Icon(Icons.remove_circle),
                                            onPressed: () {
                                              removeContact(i);
                                            }),
                                      ),
                                    ]),
                                ],
                                border: TableBorder.all(
                                    width: 1, color: Colors.purple),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    displayForm = true;
                                  });
                                }),
                            Text('Add Contact Person'),
                            if (displayForm)
                              Container(
                                child: Column(children: [
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Email'),
                                    controller: emailAddress,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Phone'),
                                    controller: mobile,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'firstName'),
                                    controller: cfirstName,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'lastName'),
                                    controller: clastName,
                                  ),
                                  RaisedButton(
                                      child: Text('Submit'),
                                      onPressed: () {
                                        addContact(
                                          emailAddress.text,
                                          mobile.text,
                                          cfirstName.text,
                                          clastName.text,
                                        );
                                        emailAddress.clear();
                                        mobile.clear();
                                        cfirstName.clear();
                                        clastName.clear();
                                        displayForm = false;
                                      }),
                                ]),
                              ),
                          ],
                        ),
                      ])),
                      // Container(
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: 'remarkstext',
                      //       labelText: 'remarkstext',
                      //     ),
                      //     controller: remarkstext,
                      //   ),
                      // ),
                      ListView(
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
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:  showImage(this
                                                  .widget
                                                  .prod['uploadDocument'][k]
                                              ['clientUpload']['file']),
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
                                  ])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ])),
            ButtonBar(children: [
              RaisedButton(
                  color: Colors.green,
                  child: Text('Update'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    updateDetails(
                        salutation.text,
                        firstName.text,
                        lastName.text,
                        companyName.text,
                       // contactEmail.text,
                        //primaryContact.text,
                        secondarycontact.text,
                        website.text,
                        // openingBalance.text,
                        facebook.text,
                        twitter.text,
                        attention.text,
                        countryRegion.text,
                        street1.text,
                        city.text,
                        state.text,
                        zipCode.text,
                        phone1.text,
                        fax.text,
                        remarkstext.text);
                  })
            ]),
          ]),
        ),
      ),
    );
  }
}
