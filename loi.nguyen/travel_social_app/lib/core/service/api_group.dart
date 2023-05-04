import 'package:cloud_firestore/cloud_firestore.dart';

class ApiGroup {
  ApiGroup(this.table) {
    ref = FirebaseFirestore.instance.collectionGroup(table);
  }
  final String table;
  late Query<Map<String, dynamic>> ref;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamData() {
    return ref.snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> loadData() {
    return ref.get();
  }
}
