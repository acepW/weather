import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:learn_bloc/bloc/weather_bloc_bloc.dart';
import 'package:learn_bloc/constant/constant_colors.dart';
import 'package:learn_bloc/screens/home_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.red),
        color: Colors.red,
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: _determinePosition(),
            builder: (context, snap) {
              if (snap.hasData) {
                return BlocProvider<WeatherBlocBloc>(
                  create: (context) => WeatherBlocBloc()
                    ..add(FetchWeather(snap.data as Position)),
                  child: HomeScreens(),
                );
              } else {
                return Scaffold(
                    backgroundColor: KDarkColors,
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          40, 1.2 * kToolbarHeight, 40, 20),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional(2, -0.4),
                                child: Container(
                                  height: 260,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimaryColor),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-2, -0.4),
                                child: Container(
                                  height: 260,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kPrimaryColor),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, -1.2),
                                child: Container(
                                  height: 260,
                                  width: 260,
                                  decoration:
                                      BoxDecoration(color: kSecondaryColor),
                                ),
                              ),
                              BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: ktransparantColors),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: kRedColor,
                                  ),
                                ),
                              )
                            ],
                          )),
                    ));
              }
            }));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
