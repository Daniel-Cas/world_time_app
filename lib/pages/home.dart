import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data['isDayTime']);

    String backgroundImage = data['isDayTime']  ? 'day.jpg' : 'nigth.jpg';
    Color backgroundColor = data['isDayTime']  ? Colors.white : Colors.blue.shade900;

    return Scaffold(
      backgroundColor: backgroundColor,
        body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/$backgroundImage'),
                  fit: BoxFit.cover,
                )
              ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
        child: Column(
          children: <Widget>[
            OutlinedButton.icon(
              onPressed: () async {
                dynamic result = await Navigator.pushNamed(context, '/location');
                setState(() {
                  data = {
                    'time': result['time'],
                    'location': result['location'],
                    'isDayTime': result['isDayTime'],
                    'flag': result['flag'],
                  };
                });
              },
              label: Text(' Edit location'),
              icon: Icon(Icons.edit_location,color: data['isDayTime']   ? Colors.black : Colors.white,),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateColor.resolveWith((states) => data['isDayTime']    ? Colors.black : Colors.white),
                  textStyle: MaterialStateProperty.resolveWith(
                      (states) => TextStyle(
                          fontSize: 20,
                        color: data['isDayTime']    ? Colors.black : Colors.white
                      ))),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data['location'] ?? '',
                  style: TextStyle(
                    fontSize: 28,
                    letterSpacing: 2.0,
                    color: data['isDayTime']    ? Colors.black : Colors.white
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              data['time'] ?? 'Don\'t found time',
              style: TextStyle(
                fontSize: 66.0,
                color: data['isDayTime']    ? Colors.black : Colors.white
              ),
            )
          ],
        ),
      ),
    )));
  }
}
