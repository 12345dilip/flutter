import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:testpro/home_page.dart';

PickedFile _photo;
String photoBase64;

class UpdateUsers extends StatefulWidget {
  final String salutation;
  final String firstName;
  final String lastName;
  final String companyName;
  final String contactEmail;
  final String contactNo;
  final String website;
  final String openingBalance;
  final String facebook;
  final String twitter;
  final String attention;
  final String countryRegion;
  final String street1;
  final String city;
  final String state;
  final String zipCode;
  final String phone1;
  final String fax;
  final String cfirstName;
  final String clastName;
  final String emailAddress;
  final String mobile;
  final String workPhone;
  //final String remarks;
  final String uploadDocument;
  final Object uploadNewDocument;
 
  const UpdateUsers({
    Key key,
    this.salutation,
    this.firstName,
    this.lastName,
    this.companyName,
    this.contactEmail,
    this.contactNo,
    this.website,
    this.openingBalance,
    this.facebook,
    this.twitter,
    this.attention,
    this.countryRegion,
    this.street1,
    this.city,
    this.state,
    this.zipCode,
    this.phone1,
    this.fax,
    this.cfirstName,
    this.clastName,
    this.emailAddress,
    this.mobile,
    this.workPhone,
    //this.title
    //this.remarks,
    this.uploadDocument,
    this.uploadNewDocument
  }) : super(key: key);

  //final String title;

  @override
  _UpdateUsersState createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {
// File _image;
  final picker = ImagePicker();

 final salutation = new TextEditingController();
  final firstName = new TextEditingController();
  final lastName = new TextEditingController();
  final companyName = new TextEditingController();
  final contactEmail = new TextEditingController();
  final contactNo = new TextEditingController();
  final website = new TextEditingController();
  final openingBalance = new TextEditingController();
  final facebook = new TextEditingController();
  final twitter = new TextEditingController();
  final attention = new TextEditingController();
  final countryRegion = new TextEditingController();
  final street1 = new TextEditingController();
  final city = new TextEditingController();
  final state = new TextEditingController();
  final zipCode = new TextEditingController();
  final phone1 = new TextEditingController();
  final fax = new TextEditingController();
  final cfirstName = new TextEditingController();
  final clastName = new TextEditingController();
  final emailAddress = new TextEditingController();
  final mobile = new TextEditingController();
  final workPhone = new TextEditingController();
  //final remarks = new TextEditingController();
  final uploadDocument = new TextEditingController();

  


  bool _valsalutation = false;
  bool _valfirstName = false;
  bool _vallastName = false;
  bool _valcontactEmail = false;
  bool _valcontactNo = false;
  bool _valopeningBalance = false;

  Future _updateDetails(
    String salutation,
    String firstName,
    String lastName,
    String companyName,
    String contactEmail,
    String contactNo,
    String website,
    String openingBalance,
    String facebook,
    String twitter,
    String attention,
    String countryRegion,
    String street1,
    String city,
    String state,
    String zipCode,
    String phone1,
    String fax,
    String cfirstName,
    String clastName,
    String emailAddress,
    String mobile,
    String workPhone,
    //String remarks,
    String uploadDocument,
    
  ) async {
    
   
    final response = await http.put(BaseUrl.updateUsers,
        headers: {  'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic >{
       "salutation": salutation,
          "firstName": firstName,
          "lastName": lastName,
          "companyName": companyName,
          "contactEmail": contactEmail,
          "contactNo": contactNo,
          "website": website,
          "openingBalance": openingBalance,
          "facebook": facebook,
          "twitter": twitter,
          "attention": attention,
          "countryRegion": countryRegion,
          "street1": street1,
          "city": city,
          "state": state,
          "zipCode": zipCode,
          "phone1": phone1,
          "fax": fax,
          "cfirstName": cfirstName,
          "clastName": clastName,
          "emailAddress": emailAddress,
          "mobile": mobile,
          "workPhone": workPhone,
          //"remarks": remarks,
          "workPhones": {'test': 'sdsd'},
          "workPhoness": [{'test': 'sdsd'}, {'test': 'sdsd2'}],
          "uploadDocument": uploadDocument,
        }));
    var res = response.body;
    if (response.statusCode == 200) { 
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      print("Error :" + res);
    }
  }

  @override
  void dispose() { 
    salutation.dispose();
    firstName.dispose();
    lastName.dispose();
    companyName.dispose();
    contactEmail.dispose();
    contactNo.dispose();
    website.dispose();
    openingBalance.dispose();
    facebook.dispose();
    twitter.dispose();
    attention.dispose();
    countryRegion.dispose();
    street1.dispose();
    city.dispose();
    state.dispose();
    zipCode.dispose();
    phone1.dispose();
    fax.dispose();
    cfirstName.dispose();
    clastName.dispose();
    emailAddress.dispose();
    mobile.dispose();
    workPhone.dispose();
    //remarks.dispose();
    //uploadDocument.dispose();
   

    super.dispose();
  }

  @override
  void initState() {
    salutation.text = widget.salutation;
    firstName.text = widget.firstName;
    lastName.text = widget.lastName;
    companyName.text = widget.companyName;
    contactEmail.text = widget.contactEmail;
    contactNo.text = widget.contactNo;
    website.text = widget.website;
    openingBalance.text = widget.openingBalance;
    facebook.text = widget.facebook;
    twitter.text = widget.twitter;
    attention.text = widget.attention;
    countryRegion.text = widget.countryRegion;
    street1.text = widget.street1;
    city.text = widget.city;
    state.text = widget.state;
    zipCode.text = widget.zipCode;
    phone1.text = widget.phone1;
    fax.text = widget.fax;
    cfirstName.text = widget.cfirstName;
    clastName.text = widget.clastName;
    emailAddress.text = widget.emailAddress;
    mobile.text = widget.mobile;
    workPhone.text = widget.workPhone;
    //remarks.text = widget.remarks;
    uploadDocument.text = widget.uploadDocument;  
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Salutation',
                    labelText: 'Salutation',
                    errorText: _valsalutation
                        ? "Salutation Name Can't be Empty"
                        : null,
                  ),
                 controller: salutation,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    labelText: 'First Name',
                    errorText:
                        _valfirstName ? "First Name Can't be Empty" : null,
                  ),
                  controller: firstName,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    labelText: 'Last Name',
                    errorText: _vallastName ? "Last Name Can't be Empty" : null,
                  ),
                  controller: lastName,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Company Name', labelText: 'Company Name '),
                  controller: companyName,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Contact Email',
                    labelText: 'Contact Email',
                    errorText: _valcontactEmail ? "Email Can't be Empty" : null,
                  ),
                  controller: contactEmail,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Contact No',
                    labelText: 'Contact No ',
                    errorText: _valcontactNo ? "No Can't be Empty" : null,
                  ),
                  controller: contactNo,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Website', labelText: 'Website '),
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
                          //Tab(text: 'Remarks'),
                          Tab(text: 'Uploads'),
                        ],
                      ),
                      Container(
                        height: 500.0,
                        child: TabBarView(children: [
                          Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Opening Balence',
                                  labelText: 'Opening Balence ',
                                  errorText: _valopeningBalance
                                      ? "Balence Can't be Empty"
                                      : null,
                                ),
                                controller: openingBalance,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Facebook',
                                    labelText: 'Facebook '),
                                controller: facebook,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Twitter', labelText: 'Twitter '),
                                controller: twitter,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Attention',
                                    labelText: 'Attention '),
                                controller: attention,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Country/Region',
                                    labelText: 'Country Region '),
                                controller: countryRegion,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Street1', labelText: 'Street1 '),
                                controller: street1,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'City', labelText: 'City '),
                                controller: city,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'State', labelText: 'State '),
                                controller: state,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Zip Code',
                                    labelText: 'Zip Code '),
                                controller: zipCode,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Phone', labelText: 'Phone '),
                                controller: phone1,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Fax', labelText: 'Fax'),
                                controller: fax,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'First Name',
                                    labelText: 'First Name '),
                                controller: cfirstName,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    labelText: 'Last Name '),
                                controller: clastName,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Email Address',
                                    labelText: 'Email Address '),
                                controller: emailAddress,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Mobile', labelText: 'Mobile '),
                                controller: mobile,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    hintText: 'Work Phone',
                                    labelText: 'Work Phone '),
                                controller: workPhone,
                              ),
                            ],
                          ),
                          //Text("uplod"),
                          // Container(
                          ListView(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Upload',
                                          labelText: 'Upload '),
                                      controller: uploadDocument,
                                    ),
                                    // imageResized == null
                                    //     ? Container()
                                    //     : Image.file(imageResized),
                                    // FloatingActionButton(
                                    //   onPressed: selectImage,
                                    //   tooltip: 'selectImage',
                                    //   child: Icon(Icons.add),
                                    // ),
                                  ],
                                ),
                              ),

                              //                         child: Column(
                              //   children: [

                              //     TextField(
                              //       controller: nameController,
                              //       decoration: InputDecoration(labelText: "name"),
                              //     ),
                              //     IconButton(icon: Icon(Icons.camera),
                              //     onPressed: (){
                              //         choiceImage();
                              //     }
                              //     ),
                              //     Container(
                              //       child: _image == null ? Text('no image select') : Image.file(_image),
                              //     ),
                              //     // SizedBox(
                              //     //   height: 5.0,
                              //     // ),
                              //     RaisedButton(
                              //       child: Text("click"),
                              //       onPressed: (){
                              //          uploadImage();
                              //       }
                              //       )

                              //   ],
                              // ),
                            ],
                          )
                        ]),
                      )
                    ])
                    ),
                ButtonBar(
                  children: [
                    RaisedButton(
                      color: Colors.green,
                      child: Text('Update'),
                      onPressed: () {
                       setState(() {
                         
                          salutation.text.isEmpty
                              ? _valsalutation = true
                              : _valsalutation = false;
                          firstName.text.isEmpty
                              ? _valfirstName = true
                              : _valfirstName = false;
                          lastName.text.isEmpty
                              ? _vallastName = true
                              : _vallastName = false;

                          contactEmail.text.isEmpty
                              ? _valcontactEmail = true
                              : _valcontactEmail = false;
                          contactNo.text.isEmpty
                              ? _valcontactNo = true
                              : _valcontactNo = false;

                          openingBalance.text.isEmpty
                              ? _valopeningBalance = true
                              : _valopeningBalance = false;

                          if (_valsalutation == false &&
                              _valfirstName == false &&
                              _vallastName == false &&
                              _valcontactEmail == false &&
                              _valcontactNo == false &&
                              _valopeningBalance == false) {
                           _updateDetails(
                             salutation.text,
                              firstName.text,
                              lastName.text,
                              companyName.text,
                              contactEmail.text,
                              contactNo.text,
                              website.text,
                              openingBalance.text,
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
                              cfirstName.text,
                              clastName.text,
                              emailAddress.text,
                              mobile.text,
                              workPhone.text,
                              //remarks.text,
                              uploadDocument.text,
                           );
                          }
                        });
                      },
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text('Delete'),
                      onPressed: () {
// print(uploadNewDocument)

                        // contactEmail.clear();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
