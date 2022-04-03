import 'package:flutter/material.dart';
import 'package:trainee_path/base/base_state.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/contents/content_model.dart';
import 'package:trainee_path/widgets/customs/custom_button.dart';
import 'package:trainee_path/widgets/customs/custom_visible_column.dart';

import '../../../widgets/cards/youtube_player.dart';

class ContentPage extends StatefulWidget {
  final Content content;
  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends BaseState<ContentPage> {
  ScrollController scrollController = ScrollController(
    keepScrollOffset: true,
    debugLabel: 'debug',
    initialScrollOffset: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(),
      body: SizedBox(
        width: dynamicWidth(1),
        height: dynamicHeight(1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomVisibleColumn(
                  padding: basePadding,
                  children: [baseSpace0, _mainTitle],
                  visible: widget.content.mainTitle.isNotEmpty),
              CustomVisibleColumn(
                  padding: basePadding,
                  children: [baseSpace2, _image],
                  visible: widget.content.image.isNotEmpty),
              CustomVisibleColumn(
                  padding: basePadding,
                  children: [baseSpace2, _title(widget.content.title)],
                  visible: widget.content.title.isNotEmpty),
              CustomVisibleColumn(
                  padding: basePadding,
                  children: [baseSpace2, _content(widget.content.titleContent)],
                  visible: widget.content.titleContent.isNotEmpty),
              CustomVisibleColumn(
                  padding: basePadding,
                  children: [baseSpace2, _title(widget.content.subtitle)],
                  visible: widget.content.subtitle.isNotEmpty),
              CustomVisibleColumn(
                  padding: basePadding,
                  children: [
                    baseSpace3,
                    _content(widget.content.subtitleContent)
                  ],
                  visible: widget.content.subtitleContent.isNotEmpty),
              CustomVisibleColumn(
                children: [baseSpace3, _videoCard(widget.content.video)],
                visible: widget.content.video.isNotEmpty,
              ),
              quarterHeight,
              CustomButton(text: 'Tamamla', click: () {}),
              baseSpace3,
            ],
          ), /*  */
        ),
      ),
    );
  }

  Padding get _mainTitle {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        widget.content.mainTitle,
        style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(30)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get _image {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/images/image3.jpg',
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: kTextStyleBold.copyWith(fontSize: dynamicFontSize(25)),
      textAlign: TextAlign.left,
    );
  }

  Widget _content(String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dynamicWidth(0.06)),
      child: Text(
        content,
        style: kTextStyleNormal.copyWith(
            fontSize: dynamicFontSize(20),
            color: kTextColor.withOpacity(0.8),
            height: 1.3,
            letterSpacing: 0.2),
      ),
    );
  }

  Widget _videoCard(String videoUrl) {
    return YoutubePlayerCard(videoId: videoUrl);
  }
}
