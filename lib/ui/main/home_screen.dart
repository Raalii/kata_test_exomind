import 'package:flutter/material.dart';
import 'package:meteo/ui/styles/text_style.dart';
import 'package:meteo/ui/widget/basic/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue sur ma petite application',
              style: ThemeTextStyle.sectionTitle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 20,
            ),
            SubmitButton(
              text: 'Continuer',
              onTap: () {
                Navigator.pushNamed(context, '/weather');
              },
            )
          ],
        ),
      ),
    );
  }
}
