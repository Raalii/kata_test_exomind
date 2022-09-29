import 'package:flutter/material.dart';
import 'package:meteo/ui/styles/colors.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  const SubmitButton({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsTheme.firstColor,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        hoverColor: ColorsTheme.firstColorDarker,
        splashColor: ColorsTheme.firstColorDarker,
        focusColor: ColorsTheme.firstColorDarker,
        highlightColor: ColorsTheme.firstColorDarker,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 19),
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Outfit',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              wordSpacing: 3,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
      ),
    );
  }
}
