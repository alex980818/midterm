import 'package:flutter/material.dart';
import 'package:midterm/location.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';


void main() => runApp(InfoPage());

class InfoPage extends StatefulWidget {
  final Location location;
  const InfoPage({Key key, this.location}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              height: screenHeight / 3,
              width: screenWidth / 1.5,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl:
                    "http://slumberjer.com/visitmalaysia/images/${widget.location.imagename}",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            SizedBox(height: 6),
            Container(
                width: screenWidth / 1.2,
                //height: screenHeight / 2,
                child: Card(
                    elevation: 6,
                    child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: <Widget>[
                            Table(
                                defaultColumnWidth: FlexColumnWidth(1.0),
                                children: [
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text("Location Name",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ),
                                    TableCell(
                                        child: Container(
                                      height: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text(
                                            widget.location.loc_name,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                    )),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text("State",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ),
                                    TableCell(
                                        child: Container(
                                      height: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text(
                                            widget.location.state,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                    )),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          child: Text("Description",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ),
                                    TableCell(
                                      child: Container(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              widget.location.description,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text("Url",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ),
                                    TableCell(
                                        child: Container(
                                      height: 30,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 30,
                                        child: new InkWell(
                                            child: new Text(widget.location.url,
                                                style: TextStyle(
                                                  color: Colors.blue[200],
                                                )),
                                            onTap: () => launch('https://' +
                                                widget.location.url)),
                                      ),
                                    )),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text("Address",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ),
                                    TableCell(
                                        child: Container(
                                      height: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text(
                                            widget.location.state,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )),
                                    )),
                                  ]),
                                  TableRow(children: [
                                    TableCell(
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: Text("Phone",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ))),
                                    ),
                                    TableCell(
                                        child: Container(
                                      height: 30,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 30,
                                          child: GestureDetector(
                                            child: Text(
                                              widget.location.contact,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () => launch("tel://" +
                                                widget.location.contact),
                                          )),
                                    )),
                                  ]),
                                ]),
                            SizedBox(height: 3),
                          ],
                        )))),
          ],
        )),
      ),
    );
  }
}
