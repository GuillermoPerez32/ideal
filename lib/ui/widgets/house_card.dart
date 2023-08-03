import 'package:flutter/material.dart';
import 'package:ideal/data/models/house.dart';
import 'package:ideal/ui/pages/house_detail_page.dart';

class HouseCard extends StatelessWidget {
  const HouseCard({
    super.key,
    required this.house,
  });

  final House house;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () => Navigator.of(context)
            .pushNamed(HouseDetailPage.routeName, arguments: house),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                house.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
