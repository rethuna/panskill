import 'package:flutter/material.dart';

class SO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[dashBg, content],
      ),
    );
  }

  get dashBg => Column(
        children: <Widget>[
          Expanded(
            child: Container(color: Colors.deepPurple),
            flex: 3,
          ),
          Expanded(
            child: Container(color: Colors.transparent),
            flex: 5,
          ),
        ],
      );

  get content => Container(
        child: Column(
          children: <Widget>[
            header,
            grid,
          ],
        ),
      );

  get header => ListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 20, top: 20),
        leading: CircleAvatar(
          child: Image(
            image: AssetImage('data_repo/images/logo.png'),
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Services',
          style: TextStyle(color: Colors.blue),
        ),
      );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(32),
          color: Colors.white,
          child: GridView.count(
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            crossAxisCount: 3,
            childAspectRatio: .90,
            children: List.generate(8, (_) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[FlutterLogo(), Text('data')],
                  ),
                ),
              );
            }),
          ),
        ),
      );
}
