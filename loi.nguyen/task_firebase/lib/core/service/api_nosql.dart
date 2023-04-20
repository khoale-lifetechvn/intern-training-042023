import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/model/field_name.dart';

class ApiNosql {
  ApiNosql(
      {required this.parentTable,
      required this.parentID,
      required this.childTable}) {
    ref = FirebaseFirestore.instance.collection(parentTable);
  }
  late CollectionReference ref;
  final String parentTable;
  final String parentID;
  final String childTable;

  ///---parent table
  ///-------CustomID
  ///----------Child Table
  ///-------------ID(random)
  ///-----------------Data
  Future<String?> addDocument({required Map data}) async {
    try {
      Map<String, Object> newData = Map.from({
        ...data,
        ...{FieldName.createdAt: DateTime.now()},
        ...{FieldName.updatedAt: DateTime.now()}
      });
      //Read data by id and get Collection
      var childCollection = ref.doc(parentID).collection(childTable);
      await childCollection.add(newData);
      logSuccess('Thêm data thành công vào bảng $parentTable > $childTable');
      return null;
    } catch (e) {
      logError('Thêm data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }

  Stream<QuerySnapshot> streamData() {
    return ref.doc(parentID).collection(childTable).snapshots();
  }

  Future<String?> updateDocument(
      {required String id, required Map data}) async {
    try {
      Map<String, Object> newData = Map.from({
        ...data,
        ...{FieldName.updatedAt: DateTime.now()}
      });
      //Read data by id and get Collection
      var childCollection = ref.doc(parentID).collection(childTable);
      await childCollection.doc(id).update(Map.from(newData));
      logSuccess(
          'Cập nhật data thành công vào bảng $parentTable > $childTable');
      return null;
    } catch (e) {
      logError('Cập nhật data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }
}
