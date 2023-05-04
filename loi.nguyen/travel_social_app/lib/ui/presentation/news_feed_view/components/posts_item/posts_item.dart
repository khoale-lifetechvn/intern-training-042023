import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_social_app/ui/utils/data.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        Map datar = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: AssetImage(datar['story']),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
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
                          fontFamily: 'Ubuntu-Regular'),
                    ),
                    const Spacer(),
                    Text(
                      Random().nextInt(2000).toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Ubuntu-Regular'),
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
                    const Icon(Iconsax.heart, size: 15, color: Colors.white),
                    const SizedBox(width: 5),
                    const Icon(Icons.share, size: 15, color: Colors.white)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
