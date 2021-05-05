import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:testpro/config/upload_url.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:testpro/first_page.dart';
import 'package:testpro/main.dart';

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
  //final contactEmail = TextEditingController();
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
    //this.contactEmail.text = this.widget.prod['contactEmail'];
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
      remarkstext,
      _id
      ) async {
    setState(() {
      this.widget.prod['userName']['salutation']['name'] = salutation;
      this.widget.prod['userName']['firstName'] = firstName;
      this.widget.prod['userName']['lastName'] = lastName;
      this.widget.prod['companyName'] = companyName;
      // this.widget.prod['contactEmail'] = contactEmail;
      //this.widget.prod['phone']['primaryContact']= primaryContact;
      this.widget.prod['phone']['secondarycontact'] = secondarycontact;

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
      this.widget.prod["_id"]= _id;
    });

    final response = await http.put(BaseUrl.updateUsers + _id,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(this.widget.prod));

    var res = response.body;
    if (response.statusCode == 200) {
      print('sucess');
    } else {
      print("Error :" + res);
    }
  }

  final formKey = GlobalKey<FormState>();

String selectName = '';

List<String> names = [
  "Mr.",
  "Mrs."
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pop(context);
            }),
       
        title: Text('Profile'),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(children: [
                Container(
                  child: Column(
                    children: [
                      DropDownField(
                        hintText: 'salutation',
                      onValueChanged: ( value){
                         selectName =value;
                       },
                       value: selectName,
                       required: false,
                       items:names,
                       controller: salutation,
                      ),
                      
                      TextFormField(
                         validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something';
                          } else if (RegExp(r'[a-zA-Z]+|\s')
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid Name';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'firstName',
                          labelText: 'firstName',
                        ),
                        controller: firstName,
                      ),
                      TextFormField(

                       validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something';
                          } else if (RegExp(r'[a-zA-Z]+|\s')
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid Name';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'lastName',
                          labelText: 'lastName',
                        ),
                        controller: lastName,
                      ),
                      TextFormField(
                         validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something';
                          } else if (RegExp(r'[a-zA-Z]+|\s')
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid Name';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Company Name',
                          labelText: 'Company Name',
                        ),
                        controller: companyName,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 208.0, top: 15.0),
                        child: Text(this.widget.prod['contactEmail']),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 240.0, top: 15.0),
                        child:
                            Text(this.widget.prod['phone']['primaryContact']),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter something';
                          } else if (RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid Number';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Secondary Contact',
                          labelText: 'Secondary Contact',
                        ),
                        controller: secondarycontact,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return null;
                          } else if (RegExp(
                                  r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid Url';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'website',
                          labelText: 'website',
                        ),
                        controller: website,
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(children: [
                      TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.blue,
                        tabs: [
                          Tab(text: 'Other Details'),
                          Tab(text: 'Address'),
                          Tab(text: 'Contact Persons'),
                        ],
                      ),
                      Container(
                        height: 550,
                        child: TabBarView(children: [
                          Container(
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    } else if (RegExp(
                                            r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                                        .hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter valid Url';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Facebook',
                                    labelText: 'Facebook ',
                                  ),
                                  controller: facebook,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return null;
                                    } else if (RegExp(
                                            r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                                        .hasMatch(value)) {
                                      return null;
                                    } else {
                                      return 'Enter valid Url';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Twitter',
                                    labelText: 'Twitter ',
                                  ),
                                  controller: twitter,
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(r'^[a-zA-Z0-9&%=]+$')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Key';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Attention',
                                      labelText: 'Attention ',
                                    ),
                                    controller: attention,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(r'^[a-zA-Z0-9&%=]+$')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Details';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Country/Region',
                                      labelText: 'Country Region ',
                                    ),
                                    controller: countryRegion,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(r'^[a-zA-Z0-9&%=]+$')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Details';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Street1',
                                      labelText: 'Street1 ',
                                    ),
                                    controller: street1,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(r'^[a-zA-Z0-9&%=]+$')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Details';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'City',
                                      labelText: 'City ',
                                    ),
                                    controller: city,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(r'^[a-zA-Z0-9&%=]+$')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Details';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'State',
                                      labelText: 'State ',
                                    ),
                                    controller: state,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(
                                              r'(^(?:[+0]9)?[0-9]{6}$)')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Zip Code',
                                      labelText: 'Zip Code ',
                                    ),
                                    controller: zipCode,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(
                                              r'(^(?:[+0]9)?[0-9]{10}$)')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Phone',
                                      labelText: 'Phone ',
                                    ),
                                    controller: phone1,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Enter something';
                                      } else if (RegExp(
                                              r'(^(?:[+0]9)?[0-9]{6}$)')
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Enter valid Number';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Fax',
                                      labelText: 'Fax',
                                    ),
                                    controller: fax,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              child: SingleChildScrollView(
                            child: Column(
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
                                            child: Text(this
                                                        .widget
                                                        .prod['contactPerson']
                                                    [i]['mobile'] ??
                                                '-'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(this
                                                    .widget
                                                    .prod['contactPerson'][i]
                                                ['emailAddress']),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                                icon: Icon(Icons.remove_circle),
                                                onPressed: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                            title: Text(
                                                                'Do you want Delete'),
                                                            actions: [
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'No')),
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    removeContact(
                                                                        i);
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'Yes')),
                                                            ],
                                                          ));
                                                }),
                                          ),
                                        ]),
                                    ],
                                    border: TableBorder.all(
                                        width: 1, color: Colors.purple),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 80.0),
                                  child: Column(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              displayForm = true;
                                            });
                                          }),
                                      Text('Add Contact Person'),
                                    ],
                                  ),
                                ),
                                if (displayForm)
                                  SingleChildScrollView(
                                    child: Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 70.0),
                                        child: Column(children: [
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Enter something';
                                              } else if (RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value)) {
                                                return null;
                                              } else {
                                                return 'Enter valid email';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Email'),
                                            controller: emailAddress,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Enter something';
                                              } else if (RegExp(
                                                      r'(^(?:[+0]9)?[0-9]{10}$)')
                                                  .hasMatch(value)) {
                                                return null;
                                              } else {
                                                return 'Enter valid Number';
                                              }
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Phone'),
                                            controller: mobile,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText: 'firstName'),
                                            controller: cfirstName,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText: 'lastName'),
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
                                    ),
                                  ),
                              ],
                            ),
                          )),
                        ]),
                      ),
                    ])),
              ]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 190, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 15,
                ),
                RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        // Navigator.pop(context);
                        
                       Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>MyApp()));
                        updateDetails(
                            salutation.text,
                            firstName.text,
                            lastName.text,
                            companyName.text,
                            secondarycontact.text,
                            website.text,
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
                            remarkstext.text,
                            this.widget.prod['_id'],
                            );
                      }
                    })
              ],
            ),
          ),
        ),
      ]),
    );
  }
}


