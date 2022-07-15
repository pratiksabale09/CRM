import 'dart:async';

import 'package:flutter/material.dart';

class PulsatingCircleIconButton extends StatefulWidget {
  final GestureTapCallback onTap;

  const PulsatingCircleIconButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _PulsatingCircleIconButtonState createState() =>
      _PulsatingCircleIconButtonState();
}

class _PulsatingCircleIconButtonState extends State<PulsatingCircleIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  double _containerPaddingLeft = 20.0;
  double _containerPaddingTop = 10.0;
  late double _animationValue;
  double translateX = 0;
  double translateY = 0;
  double rotate = 0;
  double scale = 1;

  late bool show;
  bool sent = false;
  Color _color = Colors.lightBlue;

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingTop = 10.0;
          _color = Colors.green;
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _containerPaddingTop = 10.0;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _containerPaddingTop = 10.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          _containerPaddingTop = 10.0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _animationController.forward();
          Timer(const Duration(milliseconds:500), widget.onTap);

        },
        child: AnimatedContainer(
            height: 50,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  color: _color,
                  blurRadius: 21,
                  spreadRadius: -15,
                  offset: const Offset(
                    0.0,
                    20.0,
                  ),
                )
              ],
            ),
            padding: EdgeInsets.only(
                left: _containerPaddingLeft,
                right: 20.0,
                top: _containerPaddingTop,
                bottom: 10.0),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (!sent)
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                        curve: Curves.fastOutSlowIn,
                        // transform: Matrix4.translationValues(
                        //     _translateX, _translateY, 0)
                        //   ..rotateZ(_rotate)
                        //   ..scale(_scale),
                      )
                    : Container(),
                AnimatedSize(
                  // ignore: deprecated_member_use
                  vsync: this,
                  duration: const Duration(milliseconds: 600),
                  child: show ? const SizedBox(width: 10.0) : Container(),
                ),
                AnimatedSize(
                  // ignore: deprecated_member_use
                  vsync: this,
                  duration: const Duration(milliseconds: 200),
                  child: show ? const Text("Book Trip") : Container(),
                ),
              ],
            )));
  }
}
