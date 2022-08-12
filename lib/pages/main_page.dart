import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/main_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.black,
      body: GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return VStack(
            [
              const SizedBox(
                height: 80,
              ),
              SvgPicture.asset("assets/logo.svg"),
              const SizedBox(
                height: 80,
              ),
              "Match Time".text.white.xl3.make(),
              Container(height: 2, width: 160, color: Vx.white).marginAll(10),
              InkWell(
                child: controller.matchTime.text.xl5.bold.white.make().p12(),
                onTap: () {
                  controller.showFlutterPicker(context);
                },
              ),
              Container(height: 2, width: 160, color: Vx.white).marginAll(10),
              "Fast Options".text.xl.white.make(),
              HStack([
                InkWell(
                  child: makeFastOptionText("15m"),
                  onTap: () {
                    controller.fastOption(15);
                  },
                ),
                InkWell(
                  child: makeFastOptionText("10m"),
                  onTap: () {
                    controller.fastOption(10);
                  },
                ),
                InkWell(
                  child: makeFastOptionText("5m"),
                  onTap: () {
                    controller.fastOption(5);
                  },
                ),
              ]).marginSymmetric(vertical: 10),
              InkWell(
                child: "Start"
                    .text
                    .xl
                    .make()
                    .pSymmetric(v: 8, h: 48)
                    .box
                    .white
                    .make()
                    .cornerRadius(8),
                onTap: () => Get.offAndToNamed("/Match"),
              ),
              // const SizedBox.expand(),
              const Spacer(),
              Image.asset("assets/board.png").h20(context)
            ],
            crossAlignment: CrossAxisAlignment.center,
          ).hFull(context).wFull(context).box.linearGradient(
            [Vx.black, Vx.gray800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).make();
        },
      ),
    );
  }

  makeStartButton() {
    var widget = "Start".text.xl.make();
    return makeBox(widget);
  }

  makeBox(Widget widget) {
    widget.pSymmetric(v: 8, h: 48).box.white.make().cornerRadius(8);
  }

  makeFastOptionText(String text) =>
      text.text.xl.white.make().pSymmetric(h: 10, v: 6);
}
