import 'package:Socialxmatch/controller/initialController.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:app_usage/app_usage.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  InitialStatusController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
              title: Text(
                'Most Social Media Usage',
                style: TextStyle(color: Colors.blue.shade900, fontSize: 20),
              ),
              subtitle: Text(controller.mostUsedSocialMedia)),
          ListTile(
              title: Text(
                'Physical Activity Steps Count : ',
                style: TextStyle(color: Colors.blue.shade900, fontSize: 20),
              ),
              subtitle: Text(
                controller.nofSteps.toString(),
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
              // Replace with your implementation for displaying steps count
              ),
          ListTile(
              title: Text(
                'Music Taste: ',
                style: TextStyle(color: Colors.blue.shade900, fontSize: 20),
              ),
              subtitle: Text(
                controller.mostFrequentGenree,
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
              // Replace with your implementation for displaying music taste
              ),
          ListTile(
            title: Text(
              'Location',
              style: TextStyle(color: Colors.blue.shade900, fontSize: 20),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                controller.locationText,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
