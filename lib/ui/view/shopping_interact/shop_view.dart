import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'model/shop_model.dart';
import 'shop_view_detail.dart';
import 'shop_view_normal.dart';

class ShoppingView extends StatefulWidget {
  @override
  _ShoppingViewState createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  int _index = 0;
  double height = 100;
  List<Shop> selectedShops = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, body: buildPageView(context));
  }

  PageController get controller =>
      PageController(viewportFraction: _index == 1 ? 0.5 : 1);
  static const opacityCurve =
      const Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);

  void onPageChange(int index) {
    setState(() {
      _index = index;
    });
  }

  PageView buildPageView(BuildContext context) {
    return PageView(
      controller: controller,
      pageSnapping: false,
      onPageChanged: onPageChange,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _headerColumn,
        Container(
          color: Colors.black,
        )
      ],
    );
  }

  Widget get footer => AnimatedContainer(
        height: _index == 1 ? 0 : 100,
        duration: Duration(milliseconds: 500),
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Text(
              "Cards",
              style: TextStyle(color: Colors.white),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: selectedShops.length,
              itemBuilder: (context, index) => Material(
                child: Hero(
                  child: Card(child: Text("data")),
                  tag: selectedShops[index].description + "add",
                ),
              ),
              scrollDirection: Axis.horizontal,
            ))
          ],
        ),
      );

  Widget get _headerColumn => Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30))),
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: buildStaggeredGridView(data),
              ),
            ),
          ),
          footer
        ],
      );

  StaggeredGridView buildStaggeredGridView(List<Shop> data) {
    return StaggeredGridView.countBuilder(
      itemCount: data.length,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      shrinkWrap: true,
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(1);
      },
      itemBuilder: (context, index) => Card(
        child: buildHero(data, index),
      ),
    );
  }

  Widget buildHero(List<Shop> data, int index) {
    return Hero(
      tag: data[index].description,
      createRectTween: createRectTween,
      child: Material(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () => onTap(data[index]),
            child: buildWrapCard(data[index]),
          ),
        ),
      ),
    );
  }

  Future<void> onTap(Shop data) async {
    var item = await Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: opacityCurve.transform(animation.value),
              child: ShopDetailView(
                data: data,
              ),
            );
          });
    }));

    if (item is Shop) {
      if (!selectedShops
          .any((param) => param.description == item.description)) {
        selectedShops.add(item);
        setState(() {});
      }
    }
  }

  Widget buildWrapCard(Shop data) {
    return Container(
      child: Wrap(
        runSpacing: 20,
        direction: Axis.vertical,
        spacing: 20,
        children: <Widget>[
          Image.network(
            data.image,
            fit: BoxFit.fitHeight,
          ),
          Text("${data.price} \$ "),
          Text(data.description),
          Text(data.weigth ?? "")
        ],
      ),
    );
  }
}

extension _DataBinding on _ShoppingViewState {
  List<Shop> get data => [
        Shop(
            description: "test",
            image: "https://picsum.photos/200/100",
            price: 15),
        Shop(
            description: "test1",
            image: "https://picsum.photos/200/200",
            price: 15),
        Shop(
            description: "test2",
            image: "https://picsum.photos/201/400",
            price: 15),
        Shop(
            description: "test3",
            image: "https://picsum.photos/100/300",
            price: 15),
        Shop(
            description: "test4",
            image: "https://picsum.photos/200/350",
            price: 15),
        Shop(
            description: "test5",
            image: "https://picsum.photos/300/306",
            price: 15),
        Shop(
            description: "test6",
            image: "https://picsum.photos/200/340",
            price: 15),
        Shop(
            description: "test7",
            image: "https://picsum.photos/200/500",
            price: 15),
      ];
}
