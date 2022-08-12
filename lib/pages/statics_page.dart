import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class StaticsPage extends StatelessWidget {
  const StaticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool whiteWins = Get.arguments ?? true;
    var title = whiteWins ? "White Player\nWon" : "Black Player\nWon";
    var backgroundColor = whiteWins ? Vx.white : Vx.black;
    var textColor = whiteWins ? Vx.black : Vx.white;
    var asset = whiteWins ? "assets/black_pawn.svg" : "assets/white_pawn.svg";
    return Scaffold(
      body: VStack(
        [
          const SizedBox(height: 160),
          title.text.center.bold.xl6.color(textColor).make(),
          SvgPicture.asset(asset),
          const Spacer(),
          InkWell(
            child: Icon(
              Icons.home_rounded,
              size: 48,
              color: textColor,
            ),
            onTap: () => Get.offAndToNamed("/"),
          ),
          const SizedBox(height: 160),
        ],
        crossAlignment: CrossAxisAlignment.center,
      ).wFull(context).box.color(backgroundColor).make(),
    );
  }
}
