import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './report_a_boar.dart';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Dzik Busters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(ReportABoar.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text(''),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                  greatPlaces.items[i].image,
                                ),
                              ),
                              title: Text(greatPlaces.items[i].title),
                              subtitle:
                                  Text(greatPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlaces.items[i].id,
                                );
                              },
                            ),
                      ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa zgłoszeń',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt),
            label: 'Dodaj zgłoszenie',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: null,
      ),
    );
  }
}