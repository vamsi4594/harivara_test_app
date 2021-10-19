import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _angle = 0.0;
  double changeAngle = 0.05;
  double _maxRightAngle = 1.0;
  double _maxLeftAngle = -1.0;
  int leftTextLength = 0;
  int rightTextLength = 0;
  //int previousValue = 0;

  int maxCount;
  int diffValue = 0;
  TextEditingController leftTFController = TextEditingController();
  TextEditingController rightTFController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxCount = (_maxRightAngle / changeAngle).toInt() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TEST APP',
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: leftTFController,
                        decoration: InputDecoration(
                            hintText: 'Type Here ...',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            )),
                        maxLines: 20,
                        onChanged: (String value){
                          setState(() {
                            leftTextLength = value.length;
                            rotateTransform();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: rightTFController,
                        decoration: InputDecoration(
                            hintText: 'Type Here ...',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                            )),
                        maxLines: 20,
                        onChanged: (String value){
                          setState(() {
                            rightTextLength = value.length;
                            rotateTransform();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //color: Colors.yellowAccent,
                height: MediaQuery.of(context).size.height / 3,
                child: Center(
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 100,
                    child: Transform.rotate(
                      angle: _angle,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue.shade700, width: 10.0)),
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '$leftTextLength',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(top: 0, bottom: 0),
                                  width: 150,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '$rightTextLength',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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

  rotateTransform() async {
    diffValue = rightTextLength - leftTextLength;
    print('diff value: $diffValue');
    await Future.delayed(Duration(milliseconds: 300), () {
      int modDiff ;
      diffValue < 0 ? modDiff = diffValue * -1 : modDiff = diffValue;
      print('mod diff: $modDiff');
      if(modDiff <= maxCount){
        _angle = diffValue * changeAngle;
        _angle = double.parse((_angle).toStringAsFixed(2));
        print('Angle: $_angle');
        setState(() {});
      }else{
        diffValue < 0 ? _angle = _maxLeftAngle : _angle = _maxRightAngle ;
        setState(() {});
      }
    });
  }
}
