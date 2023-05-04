import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:travel_social_app/utils/data.dart';

class MyTrips extends StatefulWidget {
  const MyTrips({super.key});

  @override
  State<MyTrips> createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        Map datar = data[index];
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: AssetImage(datar['saved']),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Iconsax.location,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              datar['places'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Ubuntu-Regular',
                              ),
                            ),
                            const Spacer(),
                            Text(
                              Random().nextInt(2000).toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Ubuntu-Regular',
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'likes',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Ubuntu-Regular',
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Ionicons.heart,
                              size: 15,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.share,
                              size: 15,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'oct 01, 2019 - oct 21, 2019 ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontFamily: 'Ubuntu-Regular',
                              ),
                            ),
                            Text(
                              '13 DAYS / 14 NIGHTS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Ubuntu-Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Exploring Nature de la France',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu-Regular',
                ),
              ),
              const Text(
                'oct 01, 2019 - oct 21, 2019',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontFamily: 'Ubuntu-Regular',
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Nature',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu-Regular',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Resort',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Ubuntu-Regular',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Adventure',
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
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Travellers',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontFamily: 'Ubuntu-Regular',
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    Map datar = data[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(datar['story']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
