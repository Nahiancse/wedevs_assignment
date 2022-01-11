import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  String name;
  String short_description;
  String price;
  String regular_price;
  String sale_price;
  int total_sales;
  List image;
  bool on_sale;
  
  // String userName;
  // String phoneNumber;
  // String docNurId;
  // String gender;
  // String dateOfBirth;
  // String age;
  // String bloodGroup;
  // String nid;

  // String address;
  // String password;

  // String registrationNo;

  Product({
    required this.name,
    required this.short_description,
   
    required this.price,
    required this.regular_price,
    required this.sale_price,
    required this.total_sales,
    required this.image,
    required this.on_sale,
    // required this.age,
    // required this.bloodGroup,
    // required this.nid,
    // required this.address,
    // required this.password,
    // required this.registrationNo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      short_description: json['short_description'],
      price: json['price'],
      regular_price: json['regular_price'],
      sale_price: json['sale_price'],
      total_sales: json['total_sales'],
      image: json['images'],
      on_sale: json['on_sale'],
       
      // depid: json['Dept_ID'],
      // userName: json['userName'],
      // phoneNumber: json['PhoneNumber'],
      // docNurId: json['DocNurID'],
      // gender: json['Gender'],
      // dateOfBirth: json['DateOfBirth'],
      // age: json['Age'],
      // bloodGroup: json['BloodGroup'],
      // nid: json['NID'],
      // address: json['Address'],
      // password: json['Password'],
      // registrationNo: json['RegistrationNo'],
    );
  }
}

class ProductList {
  final List<Product> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<Product> products;
    products = parsedJson.map((i) => Product.fromJson(i)).toList();

    return ProductList(products: products);
  }
}

///////////////////////////////////////////////////////////////////////////////////

//fetch function
Future<ProductList> fetchAlbum() async {
   final String response = await rootBundle.loadString('assets/response.json');
   final data = await json.decode(response);
   return ProductList.fromJson(jsonDecode(response));

 
}

///////////////////////////////////////////////////////////////////////////////////

// void main() => runApp(const MyApp());

class Home extends StatefulWidget {
 

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  late Future<ProductList> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
             leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
          title: const Text('Product List'),
        ),
        body: Center(
          child: FutureBuilder<ProductList>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data!.products.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.75,
                ),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  
                                  child: Container(
                                
                                   
                                    child: Image(
                                      fit: BoxFit.fill,
                                       height: double.infinity,
                                    width: double.infinity,
                                    
                                      image: NetworkImage(
                                        
                                    "${snapshot.data!.products[index].image[0]['src']}",
                                  ),)
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  // padding: const EdgeInsets.symmetric(vertical: 10 / 4),
                                  child: Text(
                                    // products is out demo list
                                   "${snapshot.data!.products[index].name}",
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "\$${snapshot.data!.products[index].price}",
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    "${snapshot.data!.products[index].total_sales} sold",
                                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                      );
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      Card(
                        
                        
                          child: ListTile(
                            
                        title:
                            Text("${snapshot.data!.products[index].name}",style: TextStyle(fontWeight: FontWeight.bold),),
                        // title: Text("${snapshot.data!.doctors[index].firstName} ${snapshot.data!.doctors[index].lastName}"),
                        // subtitle: Text(subtitles[index]),
                        // leading: CircleAvatar(
                        //     backgroundImage: NetworkImage(
                        //         "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                        // trailing: Icon(icons[index])
                      // onTap: (){
                      //   print(snapshot.data!.doctors[index].depid);
                      //    Navigator.push(context, MaterialPageRoute(builder: (context) => CatWiseDocs(patientId: widget.patientId,departmentId:snapshot.data!.doctors[index].depid,depname: snapshot.data!.doctors[index].depname,pFirstName: widget.pFirstName,pLasttName: widget.pLastName,pPhone: widget.pPhone,pPhoto: widget.pPhoto,)));
                      // },
                      
                      )
                      
                      );
                    });
              }

              /////

              if (snapshot.hasData) {
                // return Text(snapshot.data!.doctors[1].de);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
  
}
