import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/service/singleton.dart';
import 'package:task_firebase/locator.dart';
import 'package:task_firebase/ui/base/base_controller.dart';

class FindUserController extends BaseController {
  String myID = locator<Singleton>().userModel.id;

  // Future for fetching all users
  Future<List<DocumentSnapshot>> getUsers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs;
  }

// Stream for getting the list of users that the current user is following
  Stream<List<String>> getFollowing(String userID) {
    return FirebaseFirestore.instance
        .collection('following')
        .doc(userID)
        .collection('userFollowing')
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((doc) => doc.id).toList());
  }
}
