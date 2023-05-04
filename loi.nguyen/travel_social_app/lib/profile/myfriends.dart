import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_social_app/utils/data.dart';

class MyFriends extends StatefulWidget {
  const MyFriends({super.key});

  @override
  State<MyFriends> createState() => _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        Map datar = data[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(datar['dp']),
            ),
            title: Text(
              datar['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu-Regular',
                // color: Colors.black,
              ),
            ),
            subtitle: const Text(
              'online',
              style: TextStyle(
                // color: Colors.grey[000],
                fontSize: 13,
                fontFamily: 'Ubuntu-Regular',
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: const Icon(
              Iconsax.user_tick,
              // color: Colors.black,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}
