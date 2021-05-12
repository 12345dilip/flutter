import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testpro/first_page.dart';
import 'package:testpro/signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testpro/router.dart';
import 'package:provider/provider.dart';


// void main() {
//   runApp(HomeApp());
// }

// class HomeApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<ItemAddNotifier>(
//           create: (BuildContext context) {
//             return ItemAddNotifier();
//           },
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomeScreen(),
//       ),
//       );
//   }
// }


// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomeScreen'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   fullscreenDialog: true,
//                   builder: (context) {
//                     return AddItemsScreen();
//                   },
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//       body: Container(
//         padding: EdgeInsets.all(30.0),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Consumer<ItemAddNotifier>(
//                 builder: (context, itemAddNotifier, _) {
//                   return ListView.builder(
//                     itemCount: itemAddNotifier.itemList.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: EdgeInsets.all(15.0),
//                         child: Text(
//                           itemAddNotifier.itemList[index].itemName,
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             color: Colors.black,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// class AddItemsScreen extends StatelessWidget {

// final _itemNameController =TextEditingController();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.red,
//         title: Text('ad item'),
//         actions: [
//           IconButton(icon: Icon(Icons.add), onPressed: (){
//              Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   fullscreenDialog: true,
//                   builder: (context) {
//                     return ShopName();
//                   },
//                 ),
//               );
//           })
//         ],
//       ),
//      body: Column(
//        children: [
//          TextField(
//  controller: _itemNameController,
//  decoration: InputDecoration(
//  contentPadding: EdgeInsets.all(15.0),
//  hintText: 'Item Name',
//  ),
// ),
// SizedBox(
//  height: 20.0,
// ),
// RaisedButton(child: Text('ADD ITEM'),
//  onPressed: () async {
//  if (_itemNameController.text.isEmpty) {
//  return;
//  }
//  await Provider.of<ItemAddNotifier>(context, listen: false)
//  .addItem(_itemNameController.text);
//  Navigator.pop(context);
//  },)
//        ],
//      ),

//     );
//   }
// }

// class ShopName  extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
      
//     );
//   }
// }


// class Item {
//   String itemName;
//   Item(this.itemName);
// }


// class ItemAddNotifier extends ChangeNotifier {
//   //
//   List itemList = [];
// addItem( itemName){
//     Item item = Item(itemName);
//     itemList.add(item);
//     notifyListeners();
//   }
// }

void main() {
 
  runApp(new MaterialApp(
  
    debugShowCheckedModeBanner: false,
    home: MyApp(
      router: AppRouter(),
    ),
    
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  MyApp({Key key, this.router}) : super(key: key);
  final storage = FlutterSecureStorage();


  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
         fontFamily: 'Poppins',
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateSettings,
      color: Colors.blue,
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.split(".");
              if (jwt.length != 3) {
                return Signin();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return FirstPage(str, payload);
                } else {
                  return Signin();
                }
              }
            } else {
              return Signin();
            }
          }),
          
    );
  }
}
