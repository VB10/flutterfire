import 'package:flutter/material.dart';
import 'package:flutterfire/ui/view/shopping_interact/model/shop_model.dart';

import 'shop_view_normal.dart';

class ShopDetailView extends StatelessWidget {
  final Shop data;

  const ShopDetailView({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String image = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: buildHeroImage()),
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
      tag: data.description + "add",
      createRectTween: createRectTween,
      child: Image.network(
        data.image,
        fit: BoxFit.contain,
      ),
    );
  }
}
