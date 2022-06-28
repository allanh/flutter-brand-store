import 'package:brandstores/src/app/widgets/product/product_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../domain/entities/product/image_info.dart';
import '../../../utils/screen_config.dart';

class ImageSliderWidget extends StatefulWidget {
  final List<MyPlusImageInfo> imageList;
  final ValueChanged<int>? imageTapped;

  const ImageSliderWidget({Key? key, required this.imageList, this.imageTapped})
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
                enlargeCenterPage: true,
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
            // 取得索引值
            var index = widget.imageList.indexOf(item);
            return Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    // 背景色
                    color: ImageType.video == item.type
                        ? Colors.black
                        : Colors.white),
                child: ImageType.video == item.type
                    // 影片
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [getVideo(item.url!)])
                    // 圖片
                    : getImage(index, item.url!));
          },
        );
      }).toList();

  /// 圖片
  Widget getImage(int index, String url) => InkWell(
      onTap: () {
        // 點擊圖片
        if (widget.imageTapped != null) {
          widget.imageTapped!(index);
        }
      },
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fill,
        alignment: Alignment.topCenter,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ));

  /// 影片
  Widget getVideo(String videoId) => ProudctVideoWidget(
        videoId: videoId,
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
                        // 圖片圓點
                        ? BoxDecoration(
                            shape: BoxShape.circle, color: _color(entry.key))
                        // 影片圓點
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
