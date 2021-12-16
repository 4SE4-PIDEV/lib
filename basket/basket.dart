import 'package:flutter/material.dart';

import 'element_info.dart';

class Basket extends StatelessWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text("Total : 500 TND", textScaleFactor: 1.5,)
          ],
        ),
        Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: const Divider(color: Colors.red)
        ),
        Expanded(
          child: ListView(
            children: [
              ElementInfo("assets/images/dmc5.jpg", 200),
              ElementInfo("assets/images/re8.jpg", 200),
              ElementInfo("assets/images/nfs.jpg", 100)
            ],
          ),
        )
      ],
    );
  }
}
