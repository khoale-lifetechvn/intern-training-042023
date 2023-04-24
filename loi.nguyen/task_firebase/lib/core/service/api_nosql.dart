import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/model/field_name.dart';

///---parent table
///-------CustomID
///----------Child Table
///-------------ID(random)
///-----------------Data
///[Data] is source data
///[Collection] such as table name
///[Document] such as id (N N)
class ApiNosql {
  ApiNosql(
      {required this.parentTable,
      required this.parentID,
      required this.childTable}) {
    ref = FirebaseFirestore.instance
        .collection(parentTable)
        .doc(parentID)
        .collection(childTable);
  }
  late CollectionReference ref;
  final String parentTable;
  final String parentID;
  final String childTable;

  Future<String?> addData({required Map data}) async {
    try {
      Map<String, Object> newData = Map.from({
        ...data,
        ...{FieldName.createdAt: DateTime.now()},
        ...{FieldName.updatedAt: DateTime.now()}
      });
      //Read data by id and get Collection
      await ref.add(newData);
      logSuccess('Thêm data thành công vào bảng $parentTable > $childTable');
      return null;
    } catch (e) {
      logError('Thêm data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }

  Stream<QuerySnapshot> streamData() {
    return ref.snapshots();
  }

  Future<String?> removeData(String id) async {
    try {
      await ref.doc(id).delete();
      logSuccess('Xóa data thành công:  $parentTable > $childTable');
      return null;
    } catch (e) {
      logSuccess('Xóa dữ liệu thất bại:  $parentTable > $childTable');
      return 'Xóa dữ liệu thất bại';
    }
  }

  Future<String?> updateData({required String id, required Map data}) async {
    try {
      Map<String, Object> newData = Map.from({
        ...data,
        ...{FieldName.updatedAt: DateTime.now()}
      });
      //Read data by id and get Collection
      await ref.doc(id).update(Map.from(newData));
      logSuccess(
          'Cập nhật data thành công vào bảng $parentTable > $childTable');
      return null;
    } catch (e) {
      logError('Cập nhật data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }

  ///Add or remove if document show
  Future<String?> addDocumentNN({required String id}) async {
    try {
      if (await isExists(id)) {
        await ref.doc(id).delete();
        logInfo('Remove documentID thành công ');
      } else {
        Map<String, Object> newData = Map.from({
          FieldName.createdAt: DateTime.now(),
          FieldName.updatedAt: DateTime.now()
        });
        await ref.doc(id).set(newData);
        logInfo('Add documentID thành công ');
      }
      return null;
    } catch (e) {
      logError('Thêm data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }

  Future<bool> isExists(String id) async {
    return await ref.doc(id).get().then((doc) {
      if (doc.exists) {
        return true;
      } else {
        return false;
      }
    }).catchError((error) {
      logError('Error getting document: $error');
      return false;
    });
  }
}