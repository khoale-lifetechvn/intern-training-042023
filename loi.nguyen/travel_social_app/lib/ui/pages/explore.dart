import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_social_app/ui/presentation/home_view/base_home_view.dart';
import 'package:travel_social_app/ui/widgets/exploregrids.dart';

class Explore extends BaseHomeView {
  const Explore({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: const [
                Text(
                  'Trending',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(width: 3),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Icon(
                    Ionicons.chevron_down,
                    size: 15,
                  ),
                )
              ],
            ),
          ),
          const Flexible(
            child: ExploreGrids(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Explore',
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
    );
  }
}
