import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import '../../../utils/constants.dart';

class CustomSettingsButton extends StatefulWidget {
  final BoxConstraints constrains;
  final String buttonText;
  final String? pngIcon;
  final IconData? buttonIcon;
  CustomSettingsButton({
    super.key,
    required this.constrains,
    required this.buttonText,
    this.buttonIcon,
    this.pngIcon,
  });

  @override
  State<CustomSettingsButton> createState() => _CustomSettingsButtonState();
}

class _CustomSettingsButtonState extends State<CustomSettingsButton> {
  bool isSwitchOn = false;
  final _controller = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: widget.constrains.maxWidth * .02,
      ),
      padding: EdgeInsets.all(
        widget.constrains.maxWidth * .04,
      ),
      height: widget.constrains.maxHeight * .095,
      decoration: BoxDecoration(
        color: Constants.DARK_GRAY_COLOR,
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.buttonText,
            style: TextStyle(
              fontSize: 20,
              color: Constants.LIGHT_BLUE_COLOR,
            ),
          ),
          widget.pngIcon != null
              ? Image.asset(
                  Constants.MCQS_FORWARD_ICON,
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                    border: Border.all(
                      width: 2,
                      color: _controller.value
                          ? Constants.DARK_BLUE_COLOR
                          : Constants.LIGHT_BLUE_COLOR,
                    ),
                  ),
                  child: AdvancedSwitch(
                    controller: _controller,
                    inactiveColor: Constants.DARK_BLUE_COLOR,
                    activeColor: Constants.LIGHT_BLUE_COLOR,
                    inactiveChild: Text(
                      "On",
                      style: TextStyle(
                        color: Constants.LIGHT_BLUE_COLOR,
                      ),
                    ),
                    activeChild: Text(
                      "Off",
                      style: TextStyle(
                        color: Constants.DARK_BLUE_COLOR,
                      ),
                    ),
                    thumb: ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (_, value, __) {
                        return Icon(
                          value ? Icons.circle : Icons.circle,
                          color: value
                              ? Constants.DARK_BLUE_COLOR
                              : Constants.LIGHT_BLUE_COLOR,
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
