import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../gallery_small_image_widget.dart';

/// 全螢幕的畫廊
class FullScreenImageSliderWidget extends StatefulWidget {
  const FullScreenImageSliderWidget(
      {Key? key, required this.imagePaths, this.currentIndex})
      : super(key: key);
  final List<String> imagePaths;
  final int? currentIndex;
  @override
  _FullScreenImageSliderWidgetState createState() =>
      _FullScreenImageSliderWidgetState();
}

class _FullScreenImageSliderWidgetState
    extends State<FullScreenImageSliderWidget> {
  // 目前索引值
  int _currentIndex = 0;
  // 是否顯示前一頁和下一頁按鈕
  bool get showArrow => widget.imagePaths.length > 1;
  final CarouselController _controller = CarouselController();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex ?? 0;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: <Widget>[
        // 可縮放的大圖
        _buildPhotoViewGallery(),
        // AppBAR
        _buildAppBar(),
        // 底部縮圖列
        _buildImageCarouselSlider(),
        // 前一頁按鈕
        if (showArrow && _currentIndex != 0) _buildBackImage(),
        // 下一頁按鈕
        if (showArrow && _currentIndex != (widget.imagePaths.length - 1))
          _buildNextImage(),
      ],
    );
  }

  /// 大圖
  PhotoViewGallery _buildPhotoViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: widget.imagePaths.length,
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(widget.imagePaths[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
        );
      },
      enableRotation: false,
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: _pageController,
      loadingBuilder: (BuildContext context, ImageChunkEvent? event) {
        return const Center(child: CircularProgressIndicator());
      },
      // 換頁動作
      onPageChanged: (int index) {
        _controller.animateToPage(index);
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  /// AppBar
  Widget _buildAppBar() => Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text(
          '${_currentIndex + 1} / ${widget.imagePaths.length}',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontSize: 16.0, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          // 關閉
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.pop();
            },
          )
        ],
      ));

  /// 底部縮圖列
  Widget _buildImageCarouselSlider() => Positioned(
      bottom: 30.0,
      left: 0.0,
      right: 0.0,
      child: CarouselSlider.builder(
          itemCount: widget.imagePaths.length,
          options: CarouselOptions(
              aspectRatio: 1,
              viewportFraction: 0.2,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              initialPage: _currentIndex,
              height: 60,
              // 換頁動作
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.jumpToPage(index);
              }),
          carouselController: _controller,
          // 縮圖樣式
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return GallerySmallImageWidget(
              imagePath: widget.imagePaths[index],
              selected: index == _currentIndex,
              onImageTap: () => _pageController.jumpToPage(index),
            );
          }));

  /// 前一頁
  Widget _buildBackImage() => Positioned.fill(
        child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex -= 1;
                  });
                  _controller.previousPage();
                },
                child: Container(
                  width: 35,
                  height: 35,
                  child: Image.asset('assets/images/icon_arrow_back_28.png'),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.2)),
                ))),
      );

  /// 下一頁
  Widget _buildNextImage() => Positioned.fill(
        child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex += 1;
                  });
                  _controller.nextPage();
                },
                child: Container(
                  width: 35,
                  height: 35,
                  child: Image.asset('assets/images/icon_arrow_right_28.png'),
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5)),
                ))),
      );
}
