import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutterfire/ui/view/shopping_interact/shop_view_detail.dart';

import 'model/shop_model.dart';

RectTween createRectTween(Rect begin, Rect end) {
  return MaterialRectCenterArcTween(begin: begin, end: end);
}

class ShoppingViewNormal extends StatefulWidget {
  @override
  _ShoppingViewNormalState createState() => _ShoppingViewNormalState();
}

class _ShoppingViewNormalState extends State<ShoppingViewNormal> {
  static const double kMinRadius = 32.0;
  static const double kMaxRadius = 128.0;
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3 / 4),
          itemCount: data.length,
          itemBuilder: (context, index) => Card(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Hero(
                    createRectTween: createRectTween,
                    tag: data[index].description,
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                            return AnimatedBuilder(
                                animation: animation,
                                builder: (BuildContext context, Widget child) {
                                  return Opacity(
                                    opacity:
                                        opacityCurve.transform(animation.value),
                                    child: ShopDetailView(
                                      data: data[index],
                                    ),
                                  );
                                });
                          }));
                        },
                        child: Image.network(
                          data[index].image,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                ),
                Text("a")
              ],
            ),
          ),
        ));
  }
}

extension ShopViewData on _ShoppingViewNormalState {
  List<Shop> get data => [
        Shop(
            description: "test",
            image: "https://picsum.photos/200/100",
            price: 15),
        Shop(
            description: "test2",
            image: "https://picsum.photos/200/200",
            price: 15),
        Shop(
            description: "test3",
            image: "https://picsum.photos/201/400",
            price: 15),
        Shop(
            description: "test4",
            image: "https://picsum.photos/100/300",
            price: 15),
        Shop(
            description: "test5",
            image: "https://picsum.photos/200/350",
            price: 15),
        Shop(
            description: "test6",
            image: "https://picsum.photos/300/306",
            price: 15),
        Shop(
            description: "test7",
            image: "https://picsum.photos/200/340",
            price: 15),
        Shop(
            description: "test8",
            image: "https://picsum.photos/200/500",
            price: 15),
      ];
}
