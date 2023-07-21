import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ButtonState { normal, progress, done, error }

class ProgressIndicatingButton extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String title;

  @override
  ProgressIndicatingButtonState createState() =>
      ProgressIndicatingButtonState();

  const ProgressIndicatingButton({Key? key, this.onTap, this.title = 'TITILE'})
      : super(key: key);
}

class ProgressIndicatingButtonState extends State<ProgressIndicatingButton> {
  ButtonState buttonState = ButtonState.normal;

  void setNormalState() {
    setState(() {
      buttonState = ButtonState.normal;
    });
  }

  void setProgressState() {
    setState(() {
      buttonState = ButtonState.progress;
    });
  }

  void setDoneState() {
    setState(() {
      buttonState = ButtonState.done;
    });
  }

  void setErrorState() {
    setState(() {
      buttonState = ButtonState.error;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        buttonState = ButtonState.normal;
      });
      if (kDebugMode) {
        print('Button State back to normal was set');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
//                    width: 200,
          decoration: BoxDecoration(
            color: buttonState == ButtonState.error ? Colors.red : Colors.blue,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          height: 50,
          child: buttonState == ButtonState.normal
              ? Center(
                  child: Text(
                    widget.title,
                  ),
                )
              : buttonState == ButtonState.progress
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : buttonState == ButtonState.error
                      ? const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 45,
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
        ),
      ),
    );
  }
}
