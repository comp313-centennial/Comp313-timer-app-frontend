import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CountDownTimer extends StatefulWidget {

  final int timerValue;
  final String timerTitle;

  const CountDownTimer({Key key, this.timerValue, this.timerTitle}) : super(key: key);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  int timerValue;
  TextEditingController timerController = TextEditingController();
  final assetsAudioPlayer = AssetsAudioPlayer();
  final audioList = [
    'assets/alarm1.mp3',
    'assets/alarm2.mp3',
    'assets/alarm3.mp3',
    'assets/alarm4.mp3'
  ];
  String alarmTone = 'assets/alarm1.mp3';

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    timerValue = widget.timerValue == null ? 50 : widget.timerValue;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timerValue),
    );
    controller..addStatusListener((AnimationStatus status) {
      if (timerString == '0:00') {
        assetsAudioPlayer.open(Audio(alarmTone),
          autoStart: true,
        );
      }
    });
    if(widget.timerValue != null) controller.reverse(from: 1);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: controller.isAnimating ? Container() : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: TextFormField(
                          controller: timerController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter time in seconds',
                          ),
                        ),
                      ),
                      FloatingActionButton.extended(
                          heroTag: "btn1",
                          onPressed: () {
                            controller.duration = Duration(seconds: int.parse(timerController.text));
                            controller.reverse(from: 1);
                          },
                          icon: Icon(Icons.timer),
                          label: Text("Start"))
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  margin: EdgeInsets.only(left: 30, top: 70),
                  child: DropdownButton<String>(
                    value: alarmTone,
                    items: audioList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Alarm ${audioList.indexOf(value) + 1}'),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        alarmTone = value;
                      });
                    },
                  )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.amber,
                    height:
                        controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        widget.timerTitle,
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return FloatingActionButton.extended(
                                    heroTag: "btn2",
                                    onPressed: () {
                                      if (controller.isAnimating)
                                        controller.stop();
                                      else {
                                        controller.reverse(
                                            from: controller.value == 0.0
                                                ? 1.0
                                                : controller.value);
                                      }
                                    },
                                    icon: Icon(controller.isAnimating
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    label: Text(
                                        controller.isAnimating ? "Pause" : "Play"));
                              }),
                          AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return FloatingActionButton.extended(
                                    heroTag: "btn3",
                                    onPressed: () {
                                      assetsAudioPlayer.stop();
                                      controller.reset();
                                    },
                                    icon: Icon(Icons.replay),
                                    label: Text("Reset"));
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
