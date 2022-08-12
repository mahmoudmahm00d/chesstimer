import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/match_controller.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MatchController());
    return Scaffold(
      body: GetBuilder<MatchController>(
        init: MatchController(),
        builder: (_) => VStack(
          [
            InkWell(
              child: RotatedBox(
                quarterTurns: 2,
                child: BlackPlayerSpace(
                  time: controller.blackTime,
                  active: !controller.isWhiteTurn,
                ),
              ),
              onTap: () => controller.changePlayer(false),
            ),
            ToolsSpace(controller),
            InkWell(
              child: WhitePlayerSpace(
                time: controller.whiteTime,
                active: controller.isWhiteTurn,
              ),
              onTap: () => controller.changePlayer(true),
            ),
          ],
        ),
      ),
    );
  }
}

class WhitePlayerSpace extends StatelessWidget {
  const WhitePlayerSpace({
    Key? key,
    this.time = "00:03:00",
    this.active = false,
  }) : super(key: key);

  final String time;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        SizedBox(
          height: context.percentHeight * 10,
        ),
        active ? time.text.xl6.extraBold.make() : time.text.xl6.make(),
        const Spacer(),
        HStack([
          "White Player".text.xl4.bold.make(),
          SvgPicture.asset("assets/black_pawn.svg"),
        ]),
        SizedBox(
          height: context.percentHeight * 10,
        ),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).box.white.make().h(context.percentHeight * 45).wFull(context);
  }
}

class BlackPlayerSpace extends StatelessWidget {
  const BlackPlayerSpace({
    Key? key,
    this.time = "00:03:00",
    this.active = false,
  }) : super(key: key);

  final String time;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        SizedBox(
          height: context.percentHeight * 10,
        ),
        active
            ? time.text.white.xl6.extraBold.make()
            : time.text.white.xl6.make(),
        const Spacer(),
        HStack([
          "Black Player".text.white.xl4.bold.make(),
          SvgPicture.asset("assets/white_pawn.svg"),
        ]),
        SizedBox(
          height: context.percentHeight * 10,
        ),
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).box.black.make().h(context.percentHeight * 45).wFull(context);
  }
}

class ToolsSpace extends StatelessWidget {
  const ToolsSpace(this.matchController, {Key? key}) : super(key: key);
  final MatchController matchController;

  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        InkWell(
          child: const Icon(Icons.home_rounded, size: 36, color: Vx.white),
          onDoubleTap: () => matchController.returnToMainPage(),
        ).h10(context).wOneThird(context),
        InkWell(
          child: Icon(
              matchController.gamePaused ? Icons.play_arrow : Icons.pause,
              size: 36,
              color: Vx.white),
          onTap: () => matchController.pause(),
        ).h10(context).wOneThird(context),
        InkWell(
          child: const Icon(Icons.undo_rounded, size: 36, color: Vx.white),
          onDoubleTap: () => matchController.reset(),
        ).h10(context).wOneThird(context),
      ],
      alignment: MainAxisAlignment.spaceEvenly,
    ).wFull(context).h(context.percentHeight * 10).box.gray400.make();
  }
}
