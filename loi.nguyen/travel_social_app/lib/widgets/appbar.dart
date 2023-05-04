import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_social_app/screens/profile.dart';

AppBar header(context) {
  return AppBar(
    elevation: 0.0,
    leading: Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const Profile(),
            ),
          );
        },
        child: const CircleAvatar(
          radius: 23,
          backgroundColor: Colors.red,
          backgroundImage: AssetImage('assets/images/story/cm1.jpeg'),
        ),
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: const [
                    SizedBox(width: 3),
                    Icon(
                      Iconsax.search_normal,
                      color: Colors.black,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search...',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
