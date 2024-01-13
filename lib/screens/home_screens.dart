import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:learn_bloc/bloc/weather_bloc_bloc.dart';
import 'package:learn_bloc/constant/constant_colors.dart';
import 'package:learn_bloc/widget/custom_text.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          'assets/1.png',
          scale: 2,
        );
      case >= 300 && < 400:
        return Image.asset('assets/2.png', scale: 2);
      case >= 500 && < 600:
        return Image.asset('assets/3.png', scale: 2);
      case >= 600 && < 700:
        return Image.asset('assets/4.png', scale: 2);
      case >= 700 && < 800:
        return Image.asset('assets/5.png', scale: 2);
      case == 800:
        return Image.asset('assets/6.png', scale: 2);
      case > 800 && <= 804:
        return Image.asset('assets/7.png', scale: 2);
      default:
        return Image.asset('assets/7.png', scale: 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KDarkColors,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ktransparantColors,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
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
                      shape: BoxShape.circle, color: kPrimaryColor),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-2, -0.4),
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kPrimaryColor),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(color: kSecondaryColor),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: Container(
                  decoration: BoxDecoration(color: ktransparantColors),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text:
                                  "📍 ${state.weather.areaName} • ${state.weather.country}",
                              colors: kLinghtColors,
                              size: 15,
                              fontWeight: FontWeight.w300),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: getWeatherIcon(
                                state.weather.weatherConditionCode!),
                          ),
                          Center(
                            child: CustomText(
                                text:
                                    "${state.weather.temperature!.celsius!.toStringAsFixed(1)}°C",
                                colors: kLinghtColors,
                                size: 55,
                                fontWeight: FontWeight.w600),
                          ),
                          Center(
                            child: CustomText(
                                text: state.weather.weatherMain!.toUpperCase(),
                                colors: kLinghtColors,
                                size: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Center(
                            child: CustomText(
                                text: DateFormat('EEEE dd •')
                                    .add_jm()
                                    .format(state.weather.date!),
                                colors: kLinghtColors,
                                size: 15,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/11.png',
                                    scale: 8,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "Sunrise",
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w300),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                          text: DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunrise!),
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w700),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/12.png',
                                    scale: 8,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "Sunset",
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w300),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                          text: DateFormat()
                                              .add_jm()
                                              .format(state.weather.sunset!),
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w700),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: kGreyColor,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/13.png',
                                    scale: 8,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "Temp Max",
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w300),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                          text:
                                              "${state.weather.tempMax!.celsius!.toStringAsFixed(1)}°C",
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w700),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/14.png',
                                    scale: 8,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "Temp Min",
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w300),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                          text:
                                              "${state.weather.tempMin!.celsius!.toStringAsFixed(1)}°C",
                                          colors: kLinghtColors,
                                          size: 12,
                                          fontWeight: FontWeight.w700),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
