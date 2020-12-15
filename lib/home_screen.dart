import 'package:flutter/material.dart';


class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {


  Future<bool> loadQOF() => Future.delayed(Duration(seconds: 1), (){
    debugPrint('Step 2, fetch data');
    return true;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: FutureBuilder(
        // read this medium post https://medium.com/swlh/flutter-futurebuilder-383b6ed63f18
        future: loadQOF(),
        builder: (context, snapshot) {

          // if the future as finished!, return this widget
          if (snapshot.hasData){
            debugPrint('Step3, build widget: ${snapshot.data}');
            return Center(
              child: Container(
                child: Text(
                  'hasData: ${snapshot.data}'
                  )
               )
            );
          }
          
          // if there was an error in interacting with the snapshot
          else if (snapshot.hasError) {
            return Text(
              'Something went wrong'
            );
          }
          
          // if there is no error and the snapshot as not been loaded, return a circular progressbar
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}