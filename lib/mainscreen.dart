import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:midterm/infopage.dart';
import 'package:midterm/location.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MainScreen());

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int curnumber = 1;
  String curstate = "Recent";
  List locationdata;
  String titlecenter = "No location found";
  double screenHeight, screenWidth;
  String value = "Recent";
  String _value;
  int index;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
   // _loadPref();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            drawer: null,
            //mainDrawer(context),
            appBar: AppBar(
              title: Text(
                'Location List',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem<String>(
                        child: Text('Recent'),
                        value: "Recent",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Johor'),
                        value: "Johor",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Kedah'),
                        value: "Kedah",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Kelantan'),
                        value: "Kelantan",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Perak'),
                        value: "Perak",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Selangor'),
                        value: "Selangor",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Melaka'),
                        value: "Melaka",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Negeri Sembilan'),
                        value: "Negeri Sembilan",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Pahang'),
                        value: "Pahang",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Perlis'),
                        value: "Perlis",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Penang'),
                        value: "Penang",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Sabah'),
                        value: "Sabah",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Sarawak'),
                        value: "Sarawak",
                      ),
                      DropdownMenuItem<String>(
                        child: Text('Terengganu'),
                        value: "Terangganu",
                      ),
                    ],
                    onChanged: (String value) {
                      setState(() {
                        _sortLocation(value);
                         _savepref(value);
                      });
                    },
                    isExpanded: true,
                    hint: Text('$value'),
                    value: _value,
                  ),
                  Text(curstate,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  locationdata == null
                      ? Flexible(
                          child: Container(
                              child: Center(
                                  child: Text(
                          titlecenter,
                          style: TextStyle(
                              color: Color.fromRGBO(101, 255, 218, 50),
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ))))
                      : Flexible(
                          child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.7,
                              children:
                                  List.generate(locationdata.length, (index) {
                                return Container(
                                    child: GestureDetector(
                                        onTap: () => _toInfoPage(index),
                                        child: Card(
                                            elevation: 10,
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    height: screenHeight / 4.5,
                                                    width: screenWidth / 3,
                                                    child: ClipOval(
                                                        child:
                                                            CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      imageUrl:
                                                          "http://slumberjer.com/visitmalaysia/images/${locationdata[index]['imagename']}",
                                                      placeholder: (context,
                                                              url) =>
                                                          new CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(Icons.error),
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    locationdata[index]
                                                        ['loc_name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    locationdata[index]
                                                        ['state'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))));
                              })))
                ]))));
  }

  void _loadData() {
    String urlLoadJobs =
        "http://slumberjer.com/visitmalaysia/load_destinations.php";
    http.post(urlLoadJobs, body: {}).then((res) {
      setState(() {
        var extractdata = json.decode(res.body);
        locationdata = extractdata["locations"];
      });
    }).catchError((err) {
      print(err);
    });
  }

  void _sortLocation(String state) {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: true);
      pr.style(message: "Searching...");
      pr.show();
      String urlLoadJobs =
          "http://slumberjer.com/visitmalaysia/load_destinations.php";
      http.post(urlLoadJobs, body: {
        "state": state,
      }).then((res) {
        setState(() {
          curstate = state;

          //if(state)
          if (curstate == "Recent") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen()));
          } else {
            var extractdata = json.decode(res.body);
            if (locationdata == null) {
              Flexible(
                  child: Container(
                      child: Center(
                          child: Text(
                titlecenter,
                style: TextStyle(
                    color: Color.fromRGBO(101, 255, 218, 50),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ))));
            } else {
              locationdata = extractdata["locations"];
              FocusScope.of(context).requestFocus(new FocusNode());
              pr.dismiss();
            }
          }
        });
      }).catchError((err) {
        print(err);

        pr.dismiss();
      });
      pr.dismiss();
    } catch (e) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  // Future<void> loadPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //  String state = prefs.getString('state');
  // return state;
  // }

  void _savepref(String value) async {
    String state = value;
     SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('state',state);
  }

  _toInfoPage(int index) async {
    print(locationdata[index]['loc_name']);
    Location location = new Location(
        pid: locationdata[index]['pid'],
        loc_name: locationdata[index]['loc_name'],
        state: locationdata[index]['state'],
        description: locationdata[index]['description'],
        latitude: locationdata[index]['latitude'],
        longitude: locationdata[index]['lonitude'],
        url: locationdata[index]['url'],
        address: locationdata[index]['address'],
        contact: locationdata[index]['contact'],
        imagename: locationdata[index]['imagename']);
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => InfoPage(
                  location: location,
                )));
    _loadData();
  }

  // void _loadPref() async {
  //   //start _loadPref method
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String state = (prefs.getString('state')) ?? '';
  //   if (state.isNotEmpty) {
  //     setState(() {
  //       value = state;
  //     });
  //   } else {
  //     setState(() {
  //       prefs.setString('state', "Kedah");
  //     });
  //   }
  // } 

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            content: new Text(
              'Do you want to exit an App',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                      color: Color.fromRGBO(101, 255, 218, 50),
                    ),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color.fromRGBO(101, 255, 218, 50),
                    ),
                  )),
            ],
          ),
        ) ??
        false;
  }
}
