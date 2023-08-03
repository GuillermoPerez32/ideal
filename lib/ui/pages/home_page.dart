import 'package:flutter/material.dart';
import 'package:ideal/data/mocks/houses.dart';
import 'package:ideal/ui/widgets/house_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final houses = mockHouses;

    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 100.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  fillColor: Colors.grey[150],
                  filled: true,
                  hintText: 'Busca por nombre, provincia o municipio',
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemCount: houses.length,
            itemBuilder: (BuildContext context, int index) {
              final house = houses[index];
              return HouseCard(house: house);
            },
          ),
        ),
      ]),
    );
  }
}
