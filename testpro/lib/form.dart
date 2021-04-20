import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Formss extends StatefulWidget {

  @override
  _FormssState createState() => _FormssState();
}

class _FormssState extends State<Formss> {
  
final form = FormGroup({
 
  'userName': FormGroup({
      'salutation': FormGroup({
        'name': FormControl<String>(validators: [Validators.required]),
      }),
      'firstName': FormControl<String>(validators: [Validators.required]),
      'lastName': FormControl<String>(validators: [Validators.required]),
    }),
    'companyName': FormControl<String>(validators: [Validators.required]),
    'contactEmail': FormControl<String>(validators: [Validators.required]),
    'website': FormControl<String>(validators: [Validators.required]),

    'phone': FormGroup({
      'primaryContact': FormControl<String>(validators: [Validators.required]),
      'secondarycontact':
          FormControl<String>(validators: [Validators.required]),
    }),

    'otherDetails': FormGroup({
      'openingBalance': FormControl<String>(validators: [Validators.required]),
      'facebook': FormControl<String>(validators: [Validators.required]),
      'twitter': FormControl<String>(validators: [Validators.required]),
    }),
    'billingAddress': FormGroup({
      'attention': FormControl<String>(validators: [Validators.required]),
      'countryRegion': FormControl<String>(validators: [Validators.required]),
      'Street1': FormControl<String>(validators: [Validators.required]),
      'Street2': FormControl<String>(validators: [Validators.required]),
      'city': FormControl<String>(validators: [Validators.required]),
      'state': FormControl<String>(validators: [Validators.required]),
      'zipCode': FormControl<String>(validators: [Validators.required]),
      'phone1': FormControl<String>(validators: [Validators.required]),
      'fax': FormControl<String>(validators: [Validators.required]),
    }),

  'contactPerson': fb.control([
      FormGroup({
        
        'salutation': FormControl<String>(validators: [Validators.required]),
        'firstName': FormControl<String>(validators: [Validators.required]),
        'lastName': FormControl<String>(validators: [Validators.required]),
        'emailAddress': FormControl<String>(validators: [Validators.required]),
        'mobile': FormControl<String>(validators: [Validators.required]),
        'workPhone': FormControl<String>(validators: [Validators.required]),
      }),
    ]),
    
    'remarks': FormGroup({
      'remarkstext': FormControl<String>(validators: [Validators.required]),
    }),

    'uploadDocument': FormArray([]),
 });
 
@override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text("Form"),
      ),
      body: 
     

           SingleChildScrollView(
        
        child: ReactiveForm(
          formGroup: this.form,
          child: Column(
            children: <Widget>[
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'name',
                  labelText: 'name',
                ),
                formControlName: 'userName.salutation.name',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'firstName',
                  labelText: 'firstName',
                ),
                formControlName: 'userName.firstName',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'lastName',
                  labelText: 'lastName',
                ),
                formControlName: 'userName.lastName',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'companyName',
                  labelText: 'companyName',
                ),
                formControlName: 'companyName',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'contactEmail',
                  labelText: 'contactEmail',
                ),
                formControlName: 'contactEmail',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'website',
                  labelText: 'website',
                ),
                formControlName: 'website',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'primaryContact',
                  labelText: 'primaryContact',
                ),
                formControlName: 'phone.primaryContact',
              ),
              ReactiveTextField(
                decoration: InputDecoration(
                  hintText: 'secondarycontact',
                  labelText: 'secondarycontact',
                ),
                formControlName: 'phone.secondarycontact',
              ),
              DefaultTabController(
                  length: 5,
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
                        Tab(text: 'Remarks'),
                        Tab(text: 'Uploads'),
                      ],
                    ),
                    Container(
                      height: 600,
                      child: TabBarView(children: [
                        Column(
                          children: [
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'openingBalance',
                                labelText: 'openingBalance',
                              ),
                              formControlName: 'otherDetails.openingBalance',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'facebook',
                                labelText: 'facebook',
                              ),
                              formControlName: 'otherDetails.facebook',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'twitter',
                                labelText: 'twitter',
                              ),
                              formControlName: 'otherDetails.twitter',
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'attention',
                                labelText: 'attention',
                              ),
                              formControlName: 'billingAddress.attention',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'countryRegion',
                                labelText: 'countryRegion',
                              ),
                              formControlName: 'billingAddress.countryRegion',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'Street1',
                                labelText: 'Street1',
                              ),
                              formControlName: 'billingAddress.Street1',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'Street2',
                                labelText: 'Street2',
                              ),
                              formControlName: 'billingAddress.Street2',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'city',
                                labelText: 'city',
                              ),
                              formControlName: 'billingAddress.city',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'state',
                                labelText: 'state',
                              ),
                              formControlName: 'billingAddress.state',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'zipCode',
                                labelText: 'zipCode',
                              ),
                              formControlName: 'billingAddress.zipCode',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'phone1',
                                labelText: 'phone1',
                              ),
                              formControlName: 'billingAddress.phone1',
                            ),
                            ReactiveTextField(
                              decoration: InputDecoration(
                                hintText: 'fax',
                                labelText: 'fax',
                              ),
                              formControlName: 'billingAddress.fax',
                            ),
                          ],
                        ),
                        Column(
                          children: [

                            ReactiveTextField(
                               decoration: InputDecoration(
                                        hintText: 'firstName',
                                        labelText: 'firstName',),
                              formControlName: 'contactPerson.firstName',
                            ),
                          ],
                        ),
                        ReactiveTextField(
                          decoration: InputDecoration(
                            hintText: 'remarkstext',
                            labelText: 'remarkstext',
                          ),
                          formControlName: 'remarks.remarkstext',
                        ),
                        Text("uploadDocument"),
                      ]),
                    ),
                  ])),
              RaisedButton(
                color: Colors.red,
                child: Text('Click'),
                onPressed: () {
                  print(form.value);
                },
              ),
            ],
          ),
        ),
       )
    );
    }
}


