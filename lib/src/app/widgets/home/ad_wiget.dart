import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/module/ad_item.dart';
import '../../../domain/entities/module/module.dart';
import '../../widgets/home/module_title_widget.dart';
import '../../widgets/page_indicator.dart';
import '../../widgets/home/image_item_widget.dart';
import '../../widgets/home/marquee_item_widget.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({
    Key? key,
    required this.module,
  }) : super(key: key);
  final Module module;

  @override
  State<StatefulWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  void _timerFired() {
    final images = widget.module.images;
    if (images != null && images.isNotEmpty) {
      _currentPage++;
      controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      timer.reset();
    }
  }

  final PageController _controller = PageController();
  PageController get controller => _controller;
  late RestartableTimer _timer;
  RestartableTimer get timer => _timer;
  int selectedIndex = 0;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _timer = RestartableTimer(const Duration(seconds: 5), () => _timerFired());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.module.images;
    final width = MediaQuery.of(context).size.width;
    final ratio = widget.module.size!.ratio;
    final contentNotEmpty = widget.module.contentNotEmpty;
    final itemHeight = (!widget.module.isMarquee)
        ? 50.0
        : width * ratio + (contentNotEmpty ? 110.0 : 0.0);
    final height = (!widget.module.isMarquee
        ? itemHeight
        : widget.module.mode == DisplayMode.scroll
            ? itemHeight + (contentNotEmpty ? 15 : 0)
            : itemHeight * images!.length);
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        (widget.module.showTitle)
            ? ModuleTitleWidget(
                module: widget.module,
              )
            : Container(
                decoration: const BoxDecoration(color: Colors.red),
              ),
        SizedBox(
          width: width,
          height: height,
          child: (!widget.module.isMarquee)
              ? GestureDetector(
                  onTapDown: (details) => {timer.cancel()},
                  onTapUp: (detail) => {timer.reset()},
                  onTap: () => {},
                  child: PageView.builder(
                    controller: controller,
                    onPageChanged: (int page) {
                      setState(() {
                        selectedIndex = page % images!.length;
                      });
                    },
                    itemBuilder: (context, index) => MarqueeItemWidget(
                      item: images![index % images.length],
                    ),
                  ),
                )
              : (widget.module.mode == DisplayMode.scroll)
                  ? Stack(alignment: Alignment.bottomCenter, children: [
                      GestureDetector(
                        onTapDown: (details) => {timer.cancel()},
                        onTapUp: (detail) => {timer.reset()},
                        onTap: () => {},
                        child: PageView.builder(
                          controller: controller,
                          onPageChanged: (int page) {
                            setState(() {
                              selectedIndex = page % images!.length;
                            });
                          },
                          itemBuilder: (context, index) => ImageItemWidget(
                              item: images![index % images.length],
                              showContent: widget.module.contentNotEmpty,
                              ratio: widget.module.size!.ratio),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: 15,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: PageIndicator(
                              selectedIndex: selectedIndex,
                              itemsCount: images!.length,
                            )),
                      ),
                    ])
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: images!
                          .map(
                            (e) => SizedBox(
                                width: width,
                                height: itemHeight,
                                child: GestureDetector(
                                  onTap: () => {},
                                  child: ImageItemWidget(
                                      item: e,
                                      showContent:
                                          widget.module.contentNotEmpty,
                                      ratio: widget.module.size!.ratio),
                                )),
                          )
                          .toList()),
        )
      ]),
    );
  }
}
