import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'Londres', flag: 'GB', url: 'Europe/London', ),
    WorldTime(location: 'Atenas', flag: 'GR', url: 'Europe/Athens',),
    WorldTime(location: 'Cairo', flag: 'EG', url: 'Africa/Cairo',),
    WorldTime(location: 'Nairobi', flag: 'KE', url: 'Africa/Nairobi',),
    WorldTime(location: 'Chicago', flag: 'US', url: 'America/Chicago', ),
    WorldTime(location: 'Nueva York', flag: 'US', url: 'America/New_York', ),
    WorldTime(location: 'Seúl', flag: 'KR', url: 'Asia/Seoul', ),
    WorldTime(location: 'Jakarta', flag: 'ID', url: 'Asia/Jakarta',),
    WorldTime(location: 'Colombia', flag: 'CO', url: 'America/Bogota',),
    WorldTime(location: 'Chile', flag: 'CL', url: 'America/Santiago',),
    WorldTime(location: 'Argentina', flag: 'AR', url: 'America/Argentina/Salta',),
    WorldTime(location: 'Bolivia', flag: 'BO', url: 'America/La_Paz',),
    WorldTime(location: 'Uruguay', flag: 'UY', url: 'America/Montevideo',),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location'),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('https://flagsapi.com/${locations[index].flag}/flat/64.png')
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
