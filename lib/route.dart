import 'package:flutter/material.dart';
import 'package:meteo/ui/main/home_screen.dart';
import 'package:meteo/ui/main/weather_screen.dart';

// route for the application

Map<String, StatefulWidget Function(dynamic)> appRoute = {
  "/": (context) => const HomeScreen(),
  "/weather": (context) => const WeatherScreen()
};
