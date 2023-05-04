import 'package:flutter/material.dart';
import 'package:travel_social_app/tabs/fav_trips.dart';
import 'package:travel_social_app/tabs/mytrips.dart';
import 'package:travel_social_app/tabs/whishlist.dart';
import 'package:travel_social_app/widgets/appbar.dart';
import 'package:flutter_point_tab_bar/pointTabBar.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TabBar(
                      controller: _tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                      indicatorColor: const Color(0xfff3f4f9),
                      indicator: const PointTabIndicator(
                        position: PointTabIndicatorPosition.bottom,
                        insets: EdgeInsets.only(bottom: 3),
                        color: Colors.red,
                      ),
                      indicatorWeight: 1.0,
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      tabs: const <Widget>[
                        Tab(
                          child: Text(
                            'My Trips',
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'Ubuntu-Regular'),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Favorite Trips',
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'Ubuntu-Regular'),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Wishlist',
                            style: TextStyle(
                                fontSize: 12, fontFamily: 'Ubuntu-Regular'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'On-Going',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu-Regular',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Up-Coming',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu-Regular',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Ubuntu-Regular',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const <Widget>[
                        MyTrips(),
                        FavoriteTrips(),
                        Whishlist(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Trips',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Ubuntu-Regular',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
