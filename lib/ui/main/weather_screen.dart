import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meteo/controllers/get_lon_and_lat.dart';
import 'package:meteo/controllers/get_weather.dart';
import 'package:meteo/model/geolocation.dart';
import 'package:meteo/model/weather.dart';
import 'package:meteo/ui/styles/colors.dart';
import 'package:meteo/ui/styles/text_style.dart';
import 'package:meteo/ui/widget/basic/button.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  List<String> countryList = ['Rennes', 'Paris', 'Nantes', 'Bordeaux', 'Lyon'];

  List<String> messages = [
    'Nous téléchargeons les données…',
    'C’est presque fini…',
    'Plus que quelques secondes avant d’avoir le résultat…',
    // 'Chargement terminé !'
  ];

  List<Widget> weatherCountrylist = [];
  int index = 0;
  double percent = 0.0;
  late Timer timer;
  bool loading = true;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), update);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _getCountryOrder(int second) {
    int currIndex = 0;

    switch (second) {
      case 1:
        currIndex = 0;
        break;
      default:
        currIndex = second ~/ 10;
    }
    return countryList[currIndex];
  }

  Future<WeatherResponseWithError> _getWeather(int second) async {
    GeolocationWithError longAndLat =
        await _getLonAndLat(query: _getCountryOrder(second));
    if (longAndLat.error != null) {
      return WeatherResponseWithError(error: longAndLat.error);
    }

    WeatherResponseWithError map = await getWeather(
      lat: longAndLat.response!.lat * 1.0,
      lon: longAndLat.response!.lon * 1.0,
    );
    return map;
  }

  Future<GeolocationWithError> _getLonAndLat({required String query}) async {
    GeolocationWithError map = await getLonAndLat(query: query);
    return map;
  }

  // restart the loading
  void restart() {
    percent = 0;
    index = 0;
    weatherCountrylist = [];
    loading = true;
    setState(() {});
    timer = Timer.periodic(const Duration(seconds: 1), update);
  }

  // update function for loading and APIs call
  void update(Timer currTime) {
    int second = currTime.tick;
    if (mounted) {
      setState(() {
        percent += 1.667;
        // augmente le pourcentage
        if (percent >= 100) {
          percent = 100;
          loading = false;
          timer.cancel();
          return;
        }

        // . CHANGEMENT DE MESSAGE
        if (second % 6 == 0) {
          index = index == 2 ? 0 : index + 1;
        }

        // . APPEL API

        if (second % 10 == 0 && second < 50 || second == 1) {
          weatherCountrylist.add(
            FutureBuilder<WeatherResponseWithError>(
              future: _getWeather(second),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none) {
                  //print('project snapshot data is: ${projectSnap.data}');
                  return Container();
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.error != null) {
                  return Text(
                    "${snapshot.data!.error}",
                    style: ThemeTextStyle.errorMessage(),
                  );
                }

                return Column(
                  children: [
                    Image.network(
                        'https://openweathermap.org/img/w/${snapshot.data!.response!.weather[0].icon}.png'),
                    Text('Ville : ${snapshot.data!.response!.name}'),
                    Text(
                        'Température : ${(snapshot.data!.response!.main.temp - 275).toInt()}'),
                  ],
                );
              },
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !loading
                  ? Container()
                  : Text(
                      messages[index],
                      textAlign: TextAlign.center,
                      style: ThemeTextStyle.sectionTitle(fontSize: 20.0),
                    ),
              const SizedBox(
                height: 50,
              ),
              loading
                  ? LinearPercentIndicator(
                      animateFromLastPercent: true,
                      //leaner progress bar
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 40.0,
                      percent: percent / 100,
                      center: Text(
                        "${percent.toInt()}%",
                        style: ThemeTextStyle.sectionTitle(fontSize: 20),
                      ),

                      barRadius: const Radius.circular(20),
                      progressColor: ColorsTheme.firstColor,
                      backgroundColor: Colors.grey[300],
                    )
                  : SubmitButton(
                      text: 'Recommencer',
                      onTap: (() {
                        restart();
                      }),
                    ),
              !loading
                  ? Column(
                      children: weatherCountrylist,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
