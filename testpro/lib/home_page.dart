import 'dart:async';
import 'dart:convert';
import 'package:testpro/config/upload_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testpro/product.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
//  Map data;

//  Future getData() async {
//     var response = await http.get(
//         BaseUrl.homePage,
//         headers: {"Accept": "application/json"});

//     this.setState(() {
//       print(response.body);
//       data = json.decode(response.body);
//     });
//     }
// @override
//   void initState() {
//     super.initState();
//     this.getData();
//   }
@override
  Widget build(BuildContext context) {
    return new Scaffold(
      //  body: Padding(
      //    padding: const EdgeInsets.all(50.0),
      //    child: Column(
      //          children:[
      //              Container(
      //                child: GestureDetector(
      //                  onTap: (){
      //                   //  if(data["data"][0])
      //                     Navigator.push(context, new MaterialPageRoute(builder: (context) => Product(
      //                      prod: data["data"][0],
      //                  )));
                         
      //                  },
      //                 child:Text("click")
      //                  ),
      //              ),
      //            ]
      //           ),
      //  ),
              
            
//                  Row(
//                    children: [
//                      IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
//                       Navigator.pop(context);
//                      }),
//                    Text('Hysas'),
                
//              Container(
//                width: 250.0,
//                     child: Row(
//                      mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                             icon: Icon(Icons.edit,),onPressed: (){ 
//                                Navigator.push(
//                       context, new MaterialPageRoute(builder: (context) => UpdateUsers(
//                          salutation: data["data"][index]["userName"]["salutation"]["name"],  
//                       firstName: data["data"][index]["userName"]["firstName"],
//                       lastName: data["data"][index]["userName"]["lastName"],
//                       companyName: data["data"][index]["companyName"],
//                       contactEmail : data["data"][index]["contactEmail"],
//                       contactNo : data["data"][index]["phone"]["primaryContact"] ,
//                       website :data["data"][index]["website"],
                      
                       
//                       openingBalance :data["data"][index]["otherDetails"]["openingBalance"],
//                       facebook : data["data"][index]["otherDetails"]["facebook"],
//                       twitter :data["data"][index]["otherDetails"]["twitter"],
                      
//                       attention : data["data"][index]["billingAddress"]["attention"],
//                       countryRegion: data["data"][index]["billingAddress"]["countryRegion"],
//                        street1: data["data"][index]["billingAddress"]["Street1"],
//                        city: data["data"][index]["billingAddress"]["city"],
//                        state: data["data"][index]["billingAddress"]["state" ],
//                       zipCode : data["data"][index]["billingAddress"]["zipCode"],
//                        phone1:data["data"][index]["billingAddress"]["phone1"],
//                       fax:data["data"][index]["billingAddress"]["fax"], 
//                       cfirstName: data["data"][index]["contactPerson"][index]["firstName"],
//                       clastName: data["data"][index]["contactPerson"][index]["lastName"],
//                       emailAddress: data["data"][index]["contactPerson"][index]["emailAddress"],
//                       mobile: data["data"][index]["contactPerson"][index]["mobile"],
//                       workPhone: data["data"][index]["contactPerson"][index]["workPhone"],
                    
                  
//                       )
//                       )
//                       );
//                             }
//                             ),
//                             IconButton(
//                             icon: Icon(Icons.edit,),onPressed: (){ 
//                                Navigator.push(
//                            context, new MaterialPageRoute(builder: (context) => Formss()
//                            )
//                            );
//                            },),
//                              IconButton(
//                             icon: Icon(Icons.more_vert),onPressed: (){ }
//                             ),
//                       ],
//                     ),
//                     ),
//                   ]
//                     ),
                 
                  
                  
//                 Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                                    Container(
//                         decoration: BoxDecoration(
//                           image: DecorationImage(image: AssetImage("assets/d2cetir-6c5f230d-df51-4438-9460-d01d9c3ca594.png"),
//                           fit: BoxFit.cover,
//                           ),
//                          border: Border(left: BorderSide(color: Colors.black,
//                         ),
                        
                        
//                         ),
//                       ),
                      
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
                            
//                                 children: [
                                  
                                  
//                                        new Text("OpeningBalance",),
//                                        new Text(data["data"][index]["otherDetails"]["openingBalance"]),
//                                        ]
                             
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: [
                          
//                                    new Text("OpeningBalance",),
//                                    new Text(data["data"][index]["otherDetails"]["openingBalance"]
//                                    ),
//                                      ]
                            
//                                    ),
//                            ]
//                                    ),
//                         ),
//                       ),
                
//                 ]
//             ),
                  
                
            
//                 Card(child:
//                    DefaultTabController(length: 2,
//                       initialIndex: 0,
                      
//                        child: Column(
//                          children: [
                          
//                            TabBar(
//                              unselectedLabelColor: Colors.black,
//                              labelColor: Colors.greenAccent,
                             
//                              tabs: [
//                                Tab(text:'Details',),
//                                Tab(text: 'Comments & History'),
//                                ],
//                                ),
                      
//                           Container(
//                               height: 200.0,
//                                 child: TabBarView(
                                               
//                                       children: [
//                                         Row(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                                    Column(
//                                                      children: [
//                                                       //  Details(),
                                                  
//                                     Padding(
//                                       padding: const EdgeInsets.only(left:20.0 ,top: 10.0,),

//                                child: Row(
//                                  children: [
                                   
//                                    new Text((data["data"][index]["userName"]["salutation"]["name"]) +
//                               " " +
//                               (data["data"][index]["userName"]["firstName"]) +
//                               " " +
//                               (data["data"][index]["userName"]["lastName"]),style: TextStyle(fontWeight: FontWeight.bold,
//                               ),
                    
//                               ),
                              
//                                 Padding(
//                                   padding: const EdgeInsets.only(left:20.0),
                              
//                               ),
//                                  ],
//                                ),
//                       ),
//                                  new Text(data["data"][index]["contactEmail"],style: TextStyle(fontSize: 10.0),
//                               ),
                                
//                               Row(
//                                 children: [
//                                   Container(child: Icon(Icons.local_phone_outlined)),
//                                    new Text((data["data"][index]["phone"]["primaryContact"]),) ,
//                                 ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 40.0, top: 5.0),
//                   child: Row(
//                     children: [
//                       Icon(Icons.location_on),
//                       Text('Address',style: TextStyle(fontWeight: FontWeight.bold),),
//                     ],
//                     ),
//                 ),
                    
           
//                  Padding(
//                    padding: const EdgeInsets.only(right: 10.0),
//                    child: new Text(data["data"][index]["billingAddress"]["Street1"],style: TextStyle(fontSize: 10.0),),
//                  ),
                   
                   
                        
//                          Padding(
//                            padding: const EdgeInsets.only(left:4.0),
//                            child: new Text((data["data"][index]["billingAddress"]["city"])
                     
//                    +"  "+ (data["data"][index]["billingAddress"]["zipCode"]),style:TextStyle(fontSize: 10.0),),
//                          ),
                     
//                      Padding(
//                    padding: const EdgeInsets.only(right: 33.0),
//                    child: 
//                     new Text(data["data"][index]["billingAddress"]["state" ],style: TextStyle(fontSize: 10.0),),
//                      ),
//                      Padding(
//                    padding: const EdgeInsets.only(right: 15.0),
//                    child:
//                     new Text(data["data"][index]["billingAddress"]["countryRegion"]),
//                      ),
                      
                      
// ],
              
//                         ),
                      
//                             ],),
//                         Text('Comments Here'),
//   ],
//    ),
//     ),
//   ],
//                       ),
//                       ),
//                 ),

// // Expansion List..............
// //More Information.....

//  Card(
//     child: ExpansionTile(
       
//      title: Row(
//        children: [
//           Icon(Icons.grid_view),
//          Padding(
//            padding: const EdgeInsets.only(left: 8.0),
//            child: Text(
//              'More Iformation',
//              style: TextStyle(
//                fontWeight: FontWeight.bold,color: Colors.black,
               
//                ),
//            ),
//          ),
//     ],
//      ),
//   children: [
//       Padding(
//         padding: const EdgeInsets.only(left: 35.0),
//         child: ListTile(
//           subtitle: Text('Payment Terms'),
//           title: Text('Due on Receipt'),
//           ),
//       ),
//  ],
// ),
// ),

// // Contact Person......

// Card(
//     child:   ExpansionTile(
//       title: Row(
//       children: [
//         Icon(Icons.perm_identity),
     
//       Padding(
//            padding: const EdgeInsets.only(left: 8.0),
//            child:Text(
//              'Contact Person',
//              style: TextStyle(
//                fontWeight: FontWeight.bold,
//                color: Colors.black,
//                ),),
//       ),
//       ],
//     ),
  
//   children: [
      
//         //Text("You haven't added any contact persons for this customer yet"),
 
//      Column(
//         children:[
//           new Text((data["data"][index]["contactPerson"][index]
//                             ["firstName"])+" "+
//                        (data["data"][index]["contactPerson"][index]
//                             ["lastName"]),style: TextStyle(fontWeight: FontWeight.bold),),
//           new Text((data["data"][index]["contactPerson"][index]
//                                 ["emailAddress"]),style: TextStyle(fontSize: 7.0,),),
          
//            new Text(data["data"][index]["contactPerson"][index]["mobile"]),
//            new Text(data["data"][index]["contactPerson"][index]["workPhone"]),
//                             ]
//           ),
  
// ],
// ),

// ),
            


//  new Text((data["data"][index]["phone"]["primaryContact"]) +
//                         " " +
//                         (data["data"][index]["phone"]["primaryContact"])),

                    
//                   // new Text(data["data"][index]["remarks"]["remarkstext"]),
//                     new Text(data["data"][index]["_id"]),
//                     new Text(data["data"][index]["ContactType"]),
//                     new Text(data["data"][index]["companyName"]),
                   
//                     new Text(data["data"][index]["website"]),
//                      new Text(data["data"][index]["createdAt"]
//                         ),
//                     new Text(data["data"][index]["updatedAt"]
//                         ),
                      // data["data"][index]["uploadDocument"],
            //       ],
               
        //     // );
        //   },
        // ),
    );
  }
}

             
               
               
              
             
              
                       
            
                   
                      
                        
                       
                         
                       
                       
                 
                  

                 



                  