// ignore_for_file: must_be_immutable
import 'package:provider/provider.dart';
import 'package:challenge/consts/constants.dart';
import 'package:challenge/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/model/tour.dart';
import 'home_screen_provider.dart';

class FavoritsScreen extends StatefulWidget {
  const FavoritsScreen({super.key});

  @override
  State<FavoritsScreen> createState() => _FavoritsScreenState();
}

class _FavoritsScreenState extends State<FavoritsScreen> {
  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: true);
    return _getShowFavoritList(context, homeScreenProvider);
  }

  Widget _getShowFavoritList(
      BuildContext context, HomeScreenProvider provider) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) {
            return HomeScreen();
          }));
        }),
        backgroundColor: blue,
        centerTitle: true,
        title: Text('Your Favourite Tours'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _getToursList(provider),
          ],
        ),
      ),
    );
  }

  Widget _getToursList(HomeScreenProvider provider) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _getTourCard(provider.favorritsList[index], index, provider);
      }, childCount: provider.favorritsList.length),
    );
  }

  Widget _getTourCard(Tour data, int index, HomeScreenProvider provider) {
    return Dismissible(
      key: Key(index.toString()),
      onDismissed: (direction) {
        provider.favorritsList.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The Toure has been deleted'),
          duration: const Duration(seconds: 1),
        ));
      },
      background: Container(
        color: red,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image(
                        image: AssetImage(data.imageAddress),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                          fontFamily: 'GM', fontSize: 20, color: Colors.black),
                    ),
                    _getRating(data.rate),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Start From',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$ ${data.price} ',
                          style: TextStyle(
                              fontSize: 25,
                              color: blue,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '/person',
                          style: TextStyle(fontSize: 15, color: grey),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            _getTourDetailes(
                data.type, data.numberOfTours, data.numberOfPersons)
          ],
        ),
      ),
    );
  }

  Widget _getRating(double rate) {
    return RatingBar.builder(
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 22,
      unratedColor: Colors.grey.withAlpha(50),
      itemPadding: EdgeInsets.symmetric(horizontal: 1),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Widget _getTourDetailes(
      String type, String numberOfTours, int numberOfPersons) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
          height: 30,
          decoration: BoxDecoration(
              color: grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _getTourDetailesItem(type),
              _getTourDetailesItem(numberOfTours),
              _getTourDetailesItem(numberOfPersons.toString())
            ],
          )),
    );
  }

  Widget _getTourDetailesItem(String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text(
            "• ",
            style: TextStyle(fontSize: 20, color: grey),
          ),
          Text(
            detail,
            style: TextStyle(fontSize: 12, color: grey),
          )
        ],
      ),
    );
  }
}
