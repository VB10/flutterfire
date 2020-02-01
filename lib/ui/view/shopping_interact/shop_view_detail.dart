import 'package:flutter/material.dart';
import 'package:flutterfire/ui/view/shopping_interact/model/shop_model.dart';
import 'dart:math' as math;

import 'shop_view_normal.dart';

class RadialExpansion extends StatelessWidget {
  RadialExpansion({
    Key key,
    this.maxRadius,
    this.child,
  })  : clipRectExtent = 2.0 * (maxRadius / math.sqrt2),
        super(key: key);

  final double maxRadius;
  final clipRectExtent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The ClipOval matches the RadialExpansion widget's bounds,
    // which change per the Hero's bounds as the Hero flies to
    // the new route, while the ClipRect's bounds are always fixed.
    return Center(
      child: SizedBox(
        width: clipRectExtent,
        height: clipRectExtent,
        child: ClipRect(
          child: child,
        ),
      ),
    );
  }
}

const double kMinRadius = 32.0;
const double kMaxRadius = 128.0;

class ShopDetailView extends StatelessWidget {
  static RectTween _createRectTween(Rect begin, Rect end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  final Shop data;

  const ShopDetailView({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String image = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).canvasColor,
          alignment: FractionalOffset.topCenter,
          child: SizedBox(
            // width: kMaxRadius * 2.0,
            // height: kMaxRadius * 2.0,
            child: buildHeroImage(),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
              width: kMaxRadius * 2,
              height: kMaxRadius * 2,
              child: buildHeroImage()),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Text(data.description ?? ""),
          Text(data.price.toString() ?? ""),
          Text(data.weigth ?? ""),
          Material(
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(data);
                },
                child: Text("Add To Card")),
          )
        ],
      ),
    );
  }

  Hero buildHeroImage() {
    return Hero(
      tag: data.image + "add",
      createRectTween: _createRectTween,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            RadialExpansion(
              maxRadius: 150,
              child: Image.network(
                data.image,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "hello",
              style: TextStyle(fontSize: 35),
            )
          ],
        ),
      ),
    );
  }
}
