import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          children: [
            DrawerHeader(
              child: Text("Quốc Cường"),
            ),
            ListTile(
              title: FlatButton(
                child: Text("Menu 1"),
                onPressed: (){},
              ),
              leading: Text("1"),
              trailing: Icon(Icons.comment),
            )
          ],
        ),
      ),
    );
  }
}
