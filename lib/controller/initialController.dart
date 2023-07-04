import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:app_usage/app_usage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:Socialxmatch/util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:app_usage/app_usage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  DATA_ADDED,
  DATA_DELETED,
  DATA_NOT_ADDED,
  DATA_NOT_DELETED,
  STEPS_READY,
}

class InitialStatusController extends GetxController {
  @override
  void onInit() async {
    getUsageStats();
    _determinePosition().then((value) {});

    requestPermission();
  }

  String StringtoMatch = '';
  String locationText = 'Getting location...';
  String locationText2 = 'Getting location...';
  List<AppUsageInfo> _usageStats = [];
  List<SongModel> musicList = [];
  String mostFrequentGenree = "";
  String mostUsedSocialMedia = '';
  Duration maxUsage = Duration.zero;
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);
  var nofSteps = 0.obs;
  void fetchMusic() async {
    OnAudioQuery audioQuery = OnAudioQuery();
    List<SongModel> songs = await audioQuery.querySongs();

    musicList = songs;

    analyzeMusicTaste();
  }

  void requestPermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      fetchMusic();
    } else if (status.isDenied) {
      // Handle the case when the user denied the permission
    } else if (status.isPermanentlyDenied) {
      fetchMusic();
    }
  }

  void analyzeMusicTaste() {
    List<String> allGenres = [];

    // Extract all genres from the music list
    for (var song in musicList) {
      print("objectff");
      if (song.genre != null) {
        allGenres.add(song.genre!);
      }
    }

    // Find the most frequent genre
    Map<String, int> genreCount = {};
    String? mostFrequentGenre;
    int maxCount = 0;

    for (var genre in allGenres) {
      if (genreCount.containsKey(genre)) {
        genreCount[genre] = genreCount[genre]! + 1;
      } else {
        genreCount[genre] = 1;
      }

      if (genreCount[genre]! > maxCount) {
        maxCount = genreCount[genre]!;
        mostFrequentGenre = genre;
      }
    }
    print("sgdfshgdfghsfd:  ${mostFrequentGenre.toString().trim()}");
    if (mostFrequentGenre.toString().trim() == "Bollywood Music") {
      mostFrequentGenree = "Indian Pop";
    } else {
      mostFrequentGenree = mostFrequentGenre.toString();
    }
    print('Most Frequent Genre: $mostFrequentGenre');
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: 100));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      _usageStats = infoList;

      for (var info in infoList) {
        print(info.toString());
      }

      for (final stat in _usageStats) {
        String packageName = stat.packageName;
        Duration usage = stat.usage;

        if (socialMediaPackageNames.contains(packageName) && usage > maxUsage) {
          maxUsage = usage;
          mostUsedSocialMedia = socialMediaNames[packageName]!;
        }
      }

      print('Most used social media app: $mostUsedSocialMedia');
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  List<String> socialMediaPackageNames = [
    "com.facebook.katana",
    "com.facebook.orca",
    "com.facebook.pages.app",
    "com.instagram.android",
    "com.twitter.android",
    "com.linkedin.android",
    "com.snapchat.android",
    "com.pinterest",
    "com.reddit.frontpage",
    "com.whatsapp",
    "com.google.android.youtube",
    "com.google.android.apps.photos",
    "com.tiktok.music.ly",
    "com.netflix.mediaclient",
    "com.spotify.music",
    "com.apple.social.facebook",
    "com.apple.social.twitter",
    "com.apple.social.instagram",
    "com.apple.social.linkedin",
    "com.apple.social.snapchat",
  ];

// Map of social media package names to their corresponding names
  Map<String, String> socialMediaNames = {
    "com.facebook.katana": "Facebook",
    "com.facebook.orca": "Facebook Messenger",
    "com.facebook.pages.app": "Facebook Pages",
    "com.instagram.android": "Instagram",
    "com.twitter.android": "Twitter",
    "com.linkedin.android": "LinkedIn",
    "com.snapchat.android": "Snapchat",
    "com.pinterest": "Pinterest",
    "com.reddit.frontpage": "Reddit",
    "com.whatsapp": "WhatsApp",
    "com.google.android.youtube": "YouTube",
    "com.google.android.apps.photos": "Google Photos",
    "com.tiktok.music.ly": "TikTok",
    "com.netflix.mediaclient": "Netflix",
    "com.spotify.music": "Spotify",
    "com.apple.social.facebook": "Facebook (iOS)",
    "com.apple.social.twitter": "Twitter (iOS)",
    "com.apple.social.instagram": "Instagram (iOS)",
    "com.apple.social.linkedin": "LinkedIn (iOS)",
    "com.apple.social.snapchat": "Snapchat (iOS)",
  };

  String formatDuration(Duration duration) {
    String days = duration.inDays.toString();
    String hours = duration.inHours.remainder(24).toString();
    String minutes = duration.inMinutes.remainder(60).toString();

    return '$days days, $hours hours, $minutes minutes';
  }

  Future<dynamic> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return _getCurrentLocation();
  }

  Future<String> getLocationName(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String locationName =
            '${placemark.street},${placemark.subLocality}, ${placemark.locality}, ${placemark.country}';
        return locationName;
      }
    } catch (e) {
      print('Error: $e');
    }
    return "";
  }

  _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String location =
          await getLocationName(position.latitude, position.longitude);
      print('Location: $location');

      locationText = 'Latitude: ${position.latitude},\n'
          'Longitude: ${position.longitude},\n'
          'Location Name: $location';

      locationText2 = location;
    } catch (e) {
      locationText = 'Error getting location: $e';
    }
  }

  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;

  // Define the types to get.
  // NOTE: These are only the ones supported on Androids new API Health Connect.
  // Both Android's Google Fit and iOS' HealthKit have more types that we support in the enum list [HealthDataType]
  // Add more - like AUDIOGRAM, HEADACHE_SEVERE etc. to try them.
  static final types = dataTypesAndroid;
  // Or selected types
  // static final types = [
  //   HealthDataType.WEIGHT,
  //   HealthDataType.STEPS,
  //   HealthDataType.HEIGHT,
  //   HealthDataType.BLOOD_GLUCOSE,
  //   HealthDataType.WORKOUT,
  //   HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
  //   HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
  //   // Uncomment these lines on iOS - only available on iOS
  //   // HealthDataType.AUDIOGRAM
  // ];

  // with coresponsing permissions
  // READ only
  // final permissions = types.map((e) => HealthDataAccess.READ).toList();
  // Or READ and WRITE
  final permissions = types.map((e) => HealthDataAccess.READ_WRITE).toList();

  // create a HealthFactory for use in the app

  Future authorize() async {
    // If we are trying to read Step Count, Workout, Sleep or other data that requires
    // the ACTIVITY_RECOGNITION permission, we need to request the permission first.
    // This requires a special request authorization call.
    //
    // The location permission is requested for Workouts using the Distance information.
    await Permission.activityRecognition.request();
    await Permission.location.request();

    // Check if we have permission
    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);

    // hasPermissions = false because the hasPermission cannot disclose if WRITE access exists.
    // Hence, we have to request with WRITE as well.
    hasPermissions = false;

    bool authorized = false;
    if (!hasPermissions) {
      // requesting access to the data types before reading them
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
      } catch (error) {
        print("Exception in authorize: $error");
      }
    }

    _state = (authorized) ? AppState.AUTHORIZED : AppState.AUTH_NOT_GRANTED;
  }

  /// Fetch data points from the health plugin and show them in the app.
  Future fetchData() async {
    _state = AppState.FETCHING_DATA;

    // get data within the last 24 hours
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(hours: 24));

    // Clear old data points
    _healthDataList.clear();

    try {
      // fetch health data
      List<HealthDataPoint> healthData =
          await health.getHealthDataFromTypes(yesterday, now, types);
      // save all the new data points (only the first 100)
      _healthDataList.addAll(
          (healthData.length < 100) ? healthData : healthData.sublist(0, 100));
    } catch (error) {
      print("Exception in getHealthDataFromTypes: $error");
    }

    // filter out duplicates
    _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

    // print the results
    _healthDataList.forEach((x) => print(x));

    // update the UI to display the results

    _state = _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
  }

  /// Add some random health data.
  Future addData() async {
    final now = DateTime.now();
    final earlier = now.subtract(Duration(minutes: 20));

    // Add data for supported types
    // NOTE: These are only the ones supported on Androids new API Health Connect.
    // Both Android's Google Fit and iOS' HealthKit have more types that we support in the enum list [HealthDataType]
    // Add more - like AUDIOGRAM, HEADACHE_SEVERE etc. to try them.
    bool success = true;
    success &= await health.writeHealthData(
        10, HealthDataType.BODY_FAT_PERCENTAGE, earlier, now);
    success &= await health.writeHealthData(
        1.925, HealthDataType.HEIGHT, earlier, now);
    success &=
        await health.writeHealthData(90, HealthDataType.WEIGHT, earlier, now);
    success &= await health.writeHealthData(
        90, HealthDataType.HEART_RATE, earlier, now);
    success &=
        await health.writeHealthData(90, HealthDataType.STEPS, earlier, now);
    success &= await health.writeHealthData(
        200, HealthDataType.ACTIVE_ENERGY_BURNED, earlier, now);
    success &= await health.writeHealthData(
        70, HealthDataType.HEART_RATE, earlier, now);
    success &= await health.writeHealthData(
        37, HealthDataType.BODY_TEMPERATURE, earlier, now);
    success &= await health.writeBloodOxygen(98, earlier, now, flowRate: 1.0);
    success &= await health.writeHealthData(
        105, HealthDataType.BLOOD_GLUCOSE, earlier, now);
    success &=
        await health.writeHealthData(1.8, HealthDataType.WATER, earlier, now);
    success &= await health.writeWorkoutData(
        HealthWorkoutActivityType.AMERICAN_FOOTBALL,
        now.subtract(Duration(minutes: 15)),
        now,
        totalDistance: 2430,
        totalEnergyBurned: 400);
    success &= await health.writeBloodPressure(90, 80, earlier, now);

    // Store an Audiogram
    // Uncomment these on iOS - only available on iOS
    // const frequencies = [125.0, 500.0, 1000.0, 2000.0, 4000.0, 8000.0];
    // const leftEarSensitivities = [49.0, 54.0, 89.0, 52.0, 77.0, 35.0];
    // const rightEarSensitivities = [76.0, 66.0, 90.0, 22.0, 85.0, 44.5];

    // success &= await health.writeAudiogram(
    //   frequencies,
    //   leftEarSensitivities,
    //   rightEarSensitivities,
    //   now,
    //   now,
    //   metadata: {
    //     "HKExternalUUID": "uniqueID",
    //     "HKDeviceName": "bluetooth headphone",
    //   },
    // );

    _state = success ? AppState.DATA_ADDED : AppState.DATA_NOT_ADDED;
  }

  /// Delete some random health data.
  Future deleteData() async {
    final now = DateTime.now();
    final earlier = now.subtract(Duration(hours: 24));

    bool success = true;
    for (HealthDataType type in types) {
      success &= await health.delete(type, earlier, now);
    }

    _state = success ? AppState.DATA_DELETED : AppState.DATA_NOT_DELETED;
  }

  /// Fetch steps from the health plugin and show them in the app.
  Future fetchStepData() async {
    int? steps;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');

      nofSteps.value = (steps == null) ? 0 : steps;
      _state = (steps == null) ? AppState.NO_DATA : AppState.STEPS_READY;
    } else {
      print("Authorization not granted - error in authorization");
      _state = AppState.DATA_NOT_FETCHED;
    }
  }

  Future revokeAccess() async {
    try {
      await health.revokePermissions();
    } catch (error) {
      print("Caught exception in revokeAccess: $error");
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              strokeWidth: 10,
            )),
        Text('Fetching data...')
      ],
    );
  }

  Widget _contentDataReady() {
    return ListView.builder(
        itemCount: _healthDataList.length,
        itemBuilder: (_, index) {
          HealthDataPoint p = _healthDataList[index];
          if (p.value is AudiogramHealthValue) {
            return ListTile(
              title: Text("${p.typeString}: ${p.value}"),
              trailing: Text('${p.unitString}'),
              subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
            );
          }
          if (p.value is WorkoutHealthValue) {
            return ListTile(
              title: Text(
                  "${p.typeString}: ${(p.value as WorkoutHealthValue).totalEnergyBurned} ${(p.value as WorkoutHealthValue).totalEnergyBurnedUnit?.name}"),
              trailing: Text(
                  '${(p.value as WorkoutHealthValue).workoutActivityType.name}'),
              subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
            );
          }
          return ListTile(
            title: Text("${p.typeString}: ${p.value}"),
            trailing: Text('${p.unitString}'),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
          );
        });
  }

  Widget _contentNoData() {
    return Text('No Data to show');
  }

  Widget _contentNotFetched() {
    return Column(
      children: [
        Text('Press the download button to fetch data.'),
        Text('Press the plus button to insert some random data.'),
        Text('Press the walking button to get total step count.'),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _authorized() {
    return Text('Authorization granted!');
  }

  Widget _authorizationNotGranted() {
    return Text('Authorization not given. '
        'For Android please check your OAUTH2 client ID is correct in Google Developer Console. '
        'For iOS check your permissions in Apple Health.');
  }

  Widget _dataAdded() {
    return Text('Data points inserted successfully!');
  }

  Widget _dataDeleted() {
    return Text('Data points deleted successfully!');
  }

  Widget _stepsFetched() {
    return Text(' $nofSteps');
  }

  Widget _dataNotAdded() {
    return Text('Failed to add data');
  }

  Widget _dataNotDeleted() {
    return Text('Failed to delete data');
  }

  Widget _content() {
    if (_state == AppState.DATA_READY)
      return _contentDataReady();
    else if (_state == AppState.NO_DATA)
      return _contentNoData();
    else if (_state == AppState.FETCHING_DATA)
      return _contentFetchingData();
    else if (_state == AppState.AUTHORIZED)
      return _authorized();
    else if (_state == AppState.AUTH_NOT_GRANTED)
      return _authorizationNotGranted();
    else if (_state == AppState.DATA_ADDED)
      return _dataAdded();
    else if (_state == AppState.DATA_DELETED)
      return _dataDeleted();
    else if (_state == AppState.STEPS_READY)
      return _stepsFetched();
    else if (_state == AppState.DATA_NOT_ADDED)
      return _dataNotAdded();
    else if (_state == AppState.DATA_NOT_DELETED)
      return _dataNotDeleted();
    else
      return _contentNotFetched();
  }
}
