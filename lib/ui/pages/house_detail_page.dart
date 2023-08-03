import 'package:flutter/material.dart';
import 'package:ideal/data/models/house.dart';

class HouseDetailPage extends StatelessWidget {
  static const routeName = '/house';

  const HouseDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final house = ModalRoute.of(context)!.settings.arguments as House;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: house.name,
          child: Image.network(
            house.image,
            height: 150,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            isAntiAlias: true,
          ),
        ),
      ),
    );
  }
}
