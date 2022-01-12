import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';


import 'package:flutter/material.dart';
 

class Product {
  String name;
  String short_description;
  String price;
  String regular_price;
  String sale_price;
  int total_sales;
  List image;
  bool on_sale;
  
  

  Product({
    required this.name,
    required this.short_description,
   
    required this.price,
    required this.regular_price,
    required this.sale_price,
    required this.total_sales,
    required this.image,
    required this.on_sale,

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
   PageController? pageController;
  int page = 0;

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
                return Column(
                  children: [
                    Container(
                              // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 60.0,
                      child:Card(
                        elevation: 5,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[  GestureDetector(onTap:(){ss();},child: Row(children:[ Icon(Icons.compare_arrows),Text('Filter')])),
                                  Row(children:[Text('Sort by'),Icon(Icons.arrow_drop_down),Icon(Icons.menu)]),]),
                    )),
                    Expanded(
                      child: GridView.builder(
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
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            if(snapshot.data!.products[index].on_sale==true)...[
                            Text(
                                              
                                              "\$${snapshot.data!.products[index].regular_price}",
                                              style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                                            ),
                                            ]else...[
                            Text(
                                              
                                              "\$${snapshot.data!.products[index].regular_price}",
                                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                                            ),
                                            ],
                                          
                                            
                                             
                                            
                                            if(snapshot.data!.products[index].on_sale==true)...[
                            Text(
                                              
                                              "\$${snapshot.data!.products[index].sale_price}",
                                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                                            ),
                                            ],
                                            // Text( 
                                            //   "\$${snapshot.data!.products[index].regular_price}",
                                            //   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                                            // ),
                                          ],
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
                          }),
                    ),
                  ],
                );
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
  


   void ss() {
   
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // leading: new Icon(Icons.photo),
                // title: new Text(_firstName.text),
                // onTap: () {
                //   Navigator.pop(context);
                // },
              ),
              Row(
  children: [
    Text('Newest'),
    Checkbox(
      value: true,
      onChanged: (value) {
        setState(() {
          
        });
      },
    ),
    
  ],
),
              Row(
  children: [
    Text('Oldest'),
    Checkbox(
      value: true,
      onChanged: (value) {
        setState(() {
          
        });
      },
    ),
    
  ],
),
              Row(
  children: [
    Text('BestSelling'),
    Checkbox(
      value: true,
      onChanged: (value) {
        setState(() {
          
        });
      },
    ),
    
  ],
),
Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    
                                                  },
                                                  child: Text('Cancel')),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.blue),
                                                  onPressed: () {
                                                    setState(() {
                                                    
                                                    });
                                                  },
                                                  child: Text('Apply')),
                                            ],
                                          ),
                                        ),
              // ListTile(
              //   title: Text(
              //     'Name: ${_firstName.text} ${_lastName.text}',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.photo),
              //   // title: new Text(_firstName.text),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // ListTile(
              //   title: Text(
              //     'Phone: ${_phone.text}',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.music_note),
              //   // title: new Text('Music'),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // ListTile(
              //   title: Text(
              //     'Date: ${_dateOfBirth.text}',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.music_note),
              //   // title: new Text('Music'),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // // ListTile(
              // //   title: Text(
              // //     'Email: ${_email.text}',
              // //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // //   ),
              // //   // leading: new Icon(Icons.videocam),
              // //   // title: new Text('Video'),
              // //   // onTap: () {
              // //   //   Navigator.pop(context);
              // //   // },
              // // ),
              
              // ListTile(
              //   title: Text(
              //     'Time: ${_mySelection.toString()}',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.videocam),
              //   // title: new Text('Video'),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // ListTile(
              //   title: Text(
              //     'Service Type: $serviceTypeRadio',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.videocam),
              //   // title: new Text('Video'),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // ListTile(
              //   title: Text(
              //     'Payment Type: $paymentTypeRadio',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.videocam),
              //   // title: new Text('Video'),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // ListTile(
              //   title: Text(
              //     'Price: $price',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   // leading: new Icon(Icons.videocam),
              //   // title: new Text('Video'),
              //   // onTap: () {
              //   //   Navigator.pop(context);
              //   // },
              // ),
              // RaisedButton(
              //     padding:
              //         EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              //     child: Text(
              //       'Confirm',
              //       style: TextStyle(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   onPressed: (){},
              //     // onPressed: () {
              //     //   UserBooking();
              //     //   Navigator.push(
              //     //       context,
              //     //       MaterialPageRoute(
              //     //           builder: (context) => Home(
              //     //                 patientId: widget.patientId,
              //     //                 firstName: widget.pFristName,
              //     //                 lastName: widget.pLastName,
              //     //                 phone: widget.pPhone,
              //     //                 photo: widget.pPhoto,
              //     //               )));
              //     // }),
              // ),
              Divider()
            ],
          );
        });
  }

}
