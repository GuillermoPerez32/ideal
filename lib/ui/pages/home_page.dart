import 'package:flutter/material.dart';
import 'package:ideal/data/mocks/houses.dart';
import 'package:ideal/ui/pages/house_detail_page.dart';

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
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
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
              return Card(
                elevation: 2,
                margin: EdgeInsets.only(bottom: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
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
            },
          ),
        ),
      ]),
    );
  }
}
