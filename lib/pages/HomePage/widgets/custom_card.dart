import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../utils/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.icon,
    required this.cardTitle,
    this.builtInIcon,
    required this.press,
  });
  final String? icon;
  final VoidCallback press;
  final String cardTitle;
  final IconData? builtInIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        color: Constants.DARK_BLUE_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: press,
          title: Text(
            cardTitle,
            style: TextStyle(
              color: Constants.LIGHT_BLUE_COLOR,
              fontSize: 20,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: builtInIcon != null
                ? Icon(
                    builtInIcon,
                    color: Constants.LIGHT_BLUE_COLOR,
                    size: 40,
                  )
                : SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      icon ?? "",
                      color: Constants.LIGHT_BLUE_COLOR,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
