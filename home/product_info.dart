import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../product_details.dart';

class ProductInfo extends StatelessWidget {
  final String _id;
  final String _image;
  final String _title;
  final String _description;
  final int _price;
  final int _quantity;

  ProductInfo(this._id, this._image, this._title, this._description,
      this._price, this._quantity);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("gameId", _id);
          prefs.setString("gameImage", _image);
          prefs.setString("gameTitle", _title);
          prefs.setString("gameDescription", _description);
          prefs.setInt("gamePrice", _price);
          prefs.setInt("gameQuantity", _quantity);

          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails();
            },
          ));
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
              child: Image.network("http://10.0.2.2:9090/img/" + _image, width: 200, height: 94),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_title),
                const SizedBox(
                  height: 10,
                ),
                Text(_price.toString() + " TND", textScaleFactor: 2)
              ],
            )
          ],
        ),
      ),
    );
  }
}
