import 'dart:async';

import 'package:brandstores/src/app/utils/colors.dart';
import 'package:flutter/material.dart';

enum CountDownType {
  comingSoon, //	是否即將開賣
  flashSale // 限時搶購
}

class EventCountDownTimer extends StatefulWidget {
  final CountDownType type;

  /// The callback that is called when the count timer is ended.
  final VoidCallback? onTimerEned;
  final Duration duration;

  const EventCountDownTimer(
      {Key? key, required this.type, required this.duration, this.onTimerEned})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventCountDownTimerState();
}

class _EventCountDownTimerState extends State<EventCountDownTimer> {
  Timer? _timer;
  Duration _duration = const Duration();
  Color _textColor = MyPlusColor.comingSoon;
  Gradient _gradient = MyPlusColor.comingSoonGradient;

  @override
  void initState() {
    startTimer();
    reset();
    _textColor = widget.type == CountDownType.comingSoon
        ? MyPlusColor.comingSoon
        : MyPlusColor.strawberry;
    _gradient = widget.type == CountDownType.comingSoon
        ? MyPlusColor.comingSoonGradient
        : MyPlusColor.flashSaleGradient;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 36,
        child: buildTime(),
        decoration: BoxDecoration(gradient: _gradient),
      );

  void reset() {
    setState(() => _duration = widget.duration);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = _duration.inSeconds - addSeconds;
      if (seconds < 0) {
        _timer?.cancel();
      } else {
        _duration = Duration(seconds: seconds);
      }
    });
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours),
      const SizedBox(
        width: 12,
        height: 22,
        child: Center(
            child: Text(
          ':',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'PingFangTC-Regular',
              fontSize: 12.0,
              color: Colors.white),
        )),
      ),
      buildTimeCard(time: minutes),
      const SizedBox(
        width: 12,
        height: 22,
        child: Center(
            child: Text(
          ':',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'PingFangTC-Regular',
              fontSize: 12.0,
              color: Colors.white),
        )),
      ),
      buildTimeCard(time: seconds),
    ]);
  }

  Widget buildTimeCard({required String time}) => Container(
        width: 24,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'PingFangTC-Regular',
              fontSize: 14.0,
              color: _textColor),
        ),
      );
}
