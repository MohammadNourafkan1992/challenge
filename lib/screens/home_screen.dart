import 'package:challenge/consts/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../consts/fake_data.dart';
import '../data/model/tour.dart';
import 'favourites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Tour> tourList = fakeList;
List<Tour> favoritsList = [];
int counter = favoritsList.length;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        body: Column(
          children: [getNavigation(), getScrollingCards()],
        ));
  }

  Widget getNavigation() {
    return Expanded(
      flex: 40,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8)),
            gradient: LinearGradient(
                colors: [blue, lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 20,
              ),
              _getAppBar(),
              _getTopChoices(),
              _getLabel(),
              _getSearchBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getAppBar() {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.list)),
        Spacer(),
        Text(
          counter.toString(),
          style: TextStyle(fontFamily: 'Arial', fontSize: 20, color: white),
        ),
        IconButton(
            onPressed: () async {
              List<Tour> remainedList = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return FavoritsScreen(
                  favouritesList: favoritsList,
                );
              }));
              favoritsList = remainedList;
              counter = favoritsList.length;
              setState(() {});
            },
            icon: FaIcon(FontAwesomeIcons.solidHeart))
      ],
    );
  }

  Widget _getTopChoices() {
    return Row(
      children: [
        _choices('Trending', 0, 0),
        _choices('Featured', 1, 0),
        _choices('New', 2, 0)
      ],
    );
  }

  Widget _choices(String title, int number, int selected) {
    return number == selected
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: whiteWithOpacity_02),
            child: Text(title, style: TextStyle(color: white, fontSize: 14)),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(title, style: TextStyle(color: white, fontSize: 12)),
          );
  }

  Widget _getLabel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
        ),
        Text(
          'Travel',
          style: TextStyle(fontFamily: 'GM', fontSize: 25, color: white),
        ),
        Text(
          'around the world.',
          style: TextStyle(fontFamily: 'GM', fontSize: 25, color: white),
        )
      ],
    );
  }

  Widget _getSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Container(
        decoration: BoxDecoration(
            color: whiteWithOpacity_04, borderRadius: BorderRadius.circular(6)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Icon(Icons.location_pin)),
          Expanded(
              child: TextField(
            style: TextStyle(color: white, fontSize: 18),
            decoration: InputDecoration(
                hintText: 'Search your destination ...',
                hintStyle: TextStyle(color: white),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
          ))
        ]),
      ),
    );
  }

  Widget getScrollingCards() {
    return Expanded(
      flex: 60,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: CustomScrollView(
          slivers: [_getFixedTitle(), _getToursList(tourList)],
        ),
      ),
    );
  }

  SliverToBoxAdapter _getFixedTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Place arround you',
              style: TextStyle(
                  fontFamily: 'GM', fontSize: 18, color: Colors.black),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(fontFamily: 'GM', fontSize: 14, color: grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getToursList(List tourList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _getTourCard(tourList[index]);
      }, childCount: tourList.length),
    );
  }

  Widget _getTourCard(Tour data) {
    return InkWell(
      onTap: () {
        favoritsList.add(data);
        favoritsList = favoritsList.toSet().toList();
        counter = favoritsList.length;
        setState(() {});
      },
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
          _getTourDetailes(data.type, data.numberOfTours, data.numberOfPersons)
        ],
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
