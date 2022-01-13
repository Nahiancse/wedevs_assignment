import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //  final GlobalKey<> _formkey = GlobalKey<ExpansionTileState>();
  TextEditingController _firsName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  String? key;
  String firstName = 'Demo';
  String lastName = 'Name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "${firstName} ${lastName}",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                ),
              ),
              Text(
                "dokan@gmail.com",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[500],
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(15),
                child: Card(
                  elevation: 5,
                  child: Container(
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: Row(
                            children: [
                              Icon(Icons.people),
                              SizedBox(width: 20),
                              Expanded(child: Text('Account')),
                            ],
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'First Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            controller: _firsName,
                                            keyboardType: TextInputType.text,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Please enter first name";
                                              }
                                              return null;
                                            },
                                            onSaved: (String? name) {},
                                            decoration: InputDecoration(
                                                hintText: 'enter first name',
                                                border: InputBorder.none,
                                                fillColor: Color(0xfff3f3f4),
                                                filled: true))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Last Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                            controller: _lastName,
                                            keyboardType: TextInputType.text,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "Please enter last name";
                                              }
                                              return null;
                                            },
                                            onSaved: (String? name) {},
                                            decoration: InputDecoration(
                                                hintText: 'enter last name',
                                                border: InputBorder.none,
                                                fillColor: Color(0xfff3f3f4),
                                                filled: true)),
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
                                                  onPressed: () {},
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
                                                      firstName =
                                                          _firsName.text;
                                                      lastName = _lastName.text;
                                                      _firsName.clear();
                                                      _lastName.clear();
                                                    });
                                                  },
                                                  child: Text('Save')),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        ExpansionTile(
                          title: Row(
                            children: [
                              Icon(Icons.lock),
                              SizedBox(width: 20),
                              Expanded(child: Text('Password')),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        ExpansionTile(
                          title: Row(
                            children: [
                              Icon(Icons.notifications),
                              SizedBox(width: 20),
                              Expanded(child: Text('Notification')),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black54,
                        ),
                        ExpansionTile(
                          title: Row(
                            children: [
                              Icon(Icons.favorite),
                              SizedBox(width: 20),
                              Expanded(child: Text('Wishlist')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
