import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trainee_path/constants/constants.dart';
import 'package:trainee_path/models/contents/deparment_model.dart';
import 'package:trainee_path/views/tabs/home/main_topics_page.dart';
import 'package:trainee_path/views/tabs/home/subtopics_page.dart';

class DeparmentCard extends StatelessWidget {
  final DepartmentModel department;
  const DeparmentCard({Key? key, required this.department}) : super(key: key);
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainTopicsPage(
                    departmentModel: department,
                  ),
                ));
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(flex: 3, child: bgImage),
                  Expanded(flex: 5, child: cardTexts),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding get cardTexts {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          title,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subTitle,
              linearProgress,
            ],
          ),
        ],
      ),
    );
  }

  Flexible get subTitle {
    return Flexible(
      child: Text(
        "${department.topics.length} Adımdan 5’ini tamamladın.",
        style: kTextStyleNormal.copyWith(fontSize: 16),
      ),
    );
  }

  Text get title {
    return Text(
      department.title,
      style: kTextStyleBold.copyWith(fontSize: 22),
    );
  }

  Widget get bgImage {
    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(_circular)),
        image: DecorationImage(
          image: AssetImage(
            department.image,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  double get percent => 0.5;

  Widget get linearProgress {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      barRadius: const Radius.circular(20),
      width: 44.0,
      lineHeight: 10.0,
      percent: percent,
      progressColor: const Color(0xff00D9CD),
      backgroundColor: const Color(0xffE8EEF4),
    );
  }
}
