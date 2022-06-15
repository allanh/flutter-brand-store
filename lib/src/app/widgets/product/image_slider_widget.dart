import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../domain/entities/module/module.dart';
import '../../../domain/entities/product/image_info.dart';
import '../../utils/screen_config.dart';
import '../home/video_widget.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<MyPlusImageInfo> imageList;

  const ImageSliderWidget({Key? key, required this.imageList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) => widget.imageList.isNotEmpty
      ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          CarouselSlider(
            options: CarouselOptions(
                aspectRatio: 1,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                //enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            carouselController: _controller,
            items: _items,
          ),
          if (widget.imageList.length > 1) _indictor
        ])
      : const Center(child: CircularProgressIndicator());

  /// 圖片或影片列表
  List<Widget> get _items => widget.imageList.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
                width: SizeConfig.screenWidth,
                child: ImageType.video == item.type
                    ? getVideo(item.url!)
                    : getImage(item.url!));
          },
        );
      }).toList();

  /// 圖片
  Widget getImage(String url) => CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fill,
        alignment: Alignment.topCenter,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );

  /// 影片
  Widget getVideo(String url) => VideoWidget(
        module: Module(ModuleType.video, 0, 0, 0, false, ''),
      );

  /// 小圓點
  Widget get _indictor => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.imageList.isNotEmpty
          ? widget.imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                    width: 7.0,
                    height: 7.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 11.0, horizontal: 4.0),
                    decoration: (entry.value.type == ImageType.image)
                        ? BoxDecoration(
                            shape: BoxShape.circle, color: _color(entry.key))
                        : BoxDecoration(
                            image: DecorationImage(
                                image: const AssetImage(
                                    "assets/images/icon_video_indictor.png"),
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    _color(entry.key), BlendMode.modulate)),
                          )),
              );
            }).toList()
          : []);

  /// 圓點的顏色
  Color _color(int key) => (_current == key)
      ? Theme.of(context).primaryColor
      : (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black)
          .withOpacity(0.7);
}
