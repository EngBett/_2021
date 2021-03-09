import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:aylf/components/carousel_view.dart';
import 'package:aylf/size_config.dart';

class CarouselUi extends StatelessWidget {
  CarouselUi({Key key, this.animationController, this.animation})
      : super(key: key);
  final AnimationController animationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: getProportionateScreenHeight(275),
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 1500),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              enlargeCenterPage: true,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.vertical,
            ),
            items: [
              [
                ['00508F', '7CB9F2'],
                "We are AYLF",
                "We are about ..."
              ],
              [
                ['DB5860', 'F7AFB5'],
                "JESUS",
                "We believe everything rises and falls with leadership. If we influence the leadership culture then the society will be a better place."
              ],
              [
                ['0B9A17', 'FFBB00'],
                "FRIENDSHIP",
                "We believe if we live together as friends and in Love, then we can solve the most complex of problems."
              ],
              [
                ['AA7C00', 'ECD7A1'],
                "LEADERSHIP",
                "We believe everything rises and falls with leadership. If we influence the leadership culture then the society will be a better place."
              ]
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return CarouselView(
                    header: i[1],
                    subtitle: i[2],
                    startColor: List.from(i[0])[0],
                    endColor: List.from(i[0])[1],
                  );
                },
              );
            }).toList(),
          ),
        ), //Padding
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
