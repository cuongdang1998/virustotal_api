import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchFileScanReport _fetchFileScanReport=FetchFileScanReport();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan File"),
      ),
      body: FutureBuilder<List<Scan>>(
        future: _fetchFileScanReport.fetchFileScanList(),
         builder: (BuildContext context, snapshot){
          print(snapshot.data.toString());
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Container(child: Center(child: CircularProgressIndicator(),));
            case ConnectionState.active:
              var a= snapshot.data;
              print(a.length);
              return snapshot.hasError ? Container(child: Center(child: Text("Error"),)):
                  ListView.builder(
                    itemCount: a.length,
                    itemBuilder: (context, index){
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(a[index].keyscan, style: Theme.of(context).textTheme.headline5,)
                          ],
                        ),
                      );
                  });
          }
         },
      ),
    );
  }
}