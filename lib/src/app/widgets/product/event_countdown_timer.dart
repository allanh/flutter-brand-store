import 'dart:async';

import 'package:brandstores/src/app/utils/colors.dart';
import 'package:flutter/material.dart';

enum CountDownType {
  comingSoon, //	是否即將開賣
  flashSale // 限時搶購
}

class EventCountDownTimer extends StatefulWidget {
  /// 倒數類型
  final CountDownType type;

  /// The callback that is called when the countdown timer is ended.
  final VoidCallback onTimerEned;
  // 倒數結束時間
  final Duration duration;
  // 標語
  final String? slogan;

  const EventCountDownTimer(
      {Key? key,
      required this.type,
      required this.duration,
      this.slogan,
      required this.onTimerEned})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventCountDownTimerState();
}

class _EventCountDownTimerState extends State<EventCountDownTimer> {
  Timer? _timer;
  Duration _duration = const Duration();
  int get _day => _duration.inHours ~/ 24;

  @override
  void initState() {
    startTimer();
    reset();
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
        child: Column(children: [
          // 倒數計時區塊
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leadingView,
                  timerView,
                ]),
          ),
          // 促銷標語
          if (widget.slogan != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 12, right: 12),
              width: MediaQuery.of(context).size.width,
              height: 36,
              child: Text(
                widget.slogan!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'PingFangTC-Regular',
                    height: 1.142857,
                    fontSize: 14.0,
                    color: widget.type == CountDownType.comingSoon
                        ? MyPlusColor.comingSoon
                        : MyPlusColor.strawberry),
              ),
              decoration: const BoxDecoration(color: Colors.white),
            )
        ]),
        decoration: BoxDecoration(
            gradient: widget.type == CountDownType.comingSoon
                ? MyPlusColor.comingSoonGradient
                : MyPlusColor.flashSaleGradient),
      );

  /// 倒數類型文字 widget
  Widget get leadingView => Row(children: [
        Image(
            image: widget.type == CountDownType.comingSoon
                ? const AssetImage("assets/images/icon_clock.png")
                : const AssetImage("assets/images/icon_lightning.png")),
        const SizedBox(width: 5),
        Text(
          widget.type == CountDownType.comingSoon ? '即將開賣' : '限時搶購',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'PingFangTC-Semibold',
              height: 1.142857,
              fontSize: 14.0,
              color: Colors.white),
        ),
      ]);

  /// 計時器 widget
  Widget get timerView => Row(
        children: [
          Text(
            widget.type == CountDownType.comingSoon
                ? '開賣倒數 $_day 天'
                : '距結束只剩 $_day 天',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'PingFangTC-Regular',
                height: 1.142857,
                fontSize: 14.0,
                color: Colors.white),
          ),
          const SizedBox(width: 8),
          buildTime(),
        ],
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours % 24);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours),
      timeColon,
      buildTimeCard(time: minutes),
      timeColon,
      buildTimeCard(time: seconds),
    ]);
  }

  /// 建立時分秒的方格
  Widget buildTimeCard({required String time}) => Container(
        width: 24,
        height: 22,
        margin: const EdgeInsets.only(top: 7, bottom: 7),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'PingFangTC-Regular',
              fontSize: 14.0,
              color: widget.type == CountDownType.comingSoon
                  ? MyPlusColor.comingSoon
                  : MyPlusColor.strawberry),
        ),
      );

  Widget get timeColon => const SizedBox(
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
      );

  /// 重設計時器
  void reset() {
    setState(() => _duration = widget.duration);
  }

  /// 建立倒數計時器
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // 倒數結束
      if (_duration.inSeconds == 0) {
        widget.onTimerEned();
      }
      addTime();
    });
  }

  /// 增加時間
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
}
