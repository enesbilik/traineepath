import 'package:flutter/material.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/contents/main_topic_model.dart';

class TopicCard extends StatelessWidget {
  final MainTopic topicModel;
  const TopicCard({
    Key? key,
    required this.topicModel,
  }) : super(key: key);
  static const double _circular = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_circular)),
        child: InkWell(
          borderRadius: BorderRadius.circular(_circular),
          onTap: () {},
          child: Stack(
            //fit: StackFit.,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: bgImage),
                  Flexible(child: title),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get title {
    String _title = topicModel.title;
    _title = _title.length < 20 ? _title : _title.substring(0, 20);

    return Center(
      child: Text(
        _title,
        style: kTextStyleBold.copyWith(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget get bgImage {
    return Ink(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(_circular)),
        image: DecorationImage(
          image: AssetImage(
            "assets/images/image3.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
