import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';
import 'package:task_firebase/core/extension/extension.dart';
import 'package:task_firebase/core/extension/log.dart';
import 'package:task_firebase/core/extension/methods.dart';
import 'package:task_firebase/core/model/field_name.dart';

class Api {
  Api(this.pathCollection) {
    ref = FirebaseFirestore.instance.collection(pathCollection);
  }
  final String pathCollection;
  late CollectionReference ref;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<String?> removeDocument(String id) async {
    try {
      await ref.doc(id).delete();
      logSuccess('Xóa data thành công: $pathCollection');
      return null;
    } catch (e) {
      logSuccess('Xóa dữ liệu thất bại: $pathCollection');
      return 'Xóa dữ liệu thất bại';
    }
  }

  Future<String?> addDocument(Map data, {File? file, String? customID}) async {
    if (file != null) {
      String pathFile =
          '$pathCollection/${DateTime.now()}_${basename(file.path)}';

      try {
        String url = await _uploadFile(file, pathFile: pathFile);
        data['img'] = url;
        logSuccess('Upload file thành công: $url');
      } catch (e) {
        logError('Upload file không thành công: $e');
      }
    }

    try {
      Map<String, Object> newData = Map.from({
        ...data,
        ...{FieldName.createdAt: DateTime.now()},
        ...{FieldName.updatedAt: DateTime.now()}
      });
      if (customID == null) {
        ref.add(newData);
      } else {
        ref.doc(customID).set(newData);
      }

      logSuccess('Thêm data thành công vào bảng $pathCollection');
      return null;
    } catch (e) {
      logError('Thêm data thất bại: $e');
      return 'Đã có lỗi xãy ra';
    }
  }

  Future<String?> updateDocument(Map data, String id, {File? file}) async {
    //Conditon file is not null => replace new image
    try {
      if (file != null) {
        try {
          //Remove file
          String img = Methods.getString(data, FieldName.img);
          if (img.isNotEmpty) {
            String currentDirectory =
                '$pathCollection/${FirebaseStorage.instance.refFromURL(data['img'] as String).name}';
            await storage.ref().child(currentDirectory).delete();
          }

          //upload new file

          String pathFile =
              '$pathCollection/${DateTime.now()}_${basename(file.path)}';
          String url = await _uploadFile(file, pathFile: pathFile);
          data['img'] = url;

          logSuccess('Cập nhật ảnh mới thành công');
        } catch (e) {
          logError(
              'Cập nhât ảnh mới thất bại: Có thể do đường dẫn ảnh (img) không có trong data $e');
        }
      }

      data[FieldName.updatedAt] = DateTime.now();
      await ref.doc(id).update(Map.from(data));
      return null;
    } catch (e) {
      logError('Có lỗi xãy ra khi cập nhật thông tin: $e');
      return 'Có lỗi xãy ra khi cập nhật thông tin';
    }
  }

  Future<bool> checkDocumentExists(String documentId) async {
    bool exists = false;
    try {
      var documentSnapshot = await ref.doc(documentId).get();
      exists = documentSnapshot.exists;
    } catch (e) {
      logError('Error: ${e.toString()}');
    }
    return exists;
  }

  Future<String> _uploadFile(File file, {required String pathFile}) async {
    UploadTask uploadTask = storage.ref(pathFile).putFile(file);
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }

  //
  Future<List<Map<String, dynamic>>> getDataCollection1N(
      {required String bTable, String? bChildTable}) async {
    QuerySnapshot listMain = await ref.get();
    CollectionReference bTableCollection =
        FirebaseFirestore.instance.collection(bTable);

    List<Map<String, dynamic>> data = [];
    for (var eMain in listMain.toListMap()) {
      String idMainTable = Methods.getString(eMain, FieldName.id);
      late QuerySnapshot bSnapshot;
      if (bChildTable != null) {
        bSnapshot = await bTableCollection
            .doc(idMainTable)
            .collection(bChildTable)
            .get();
      } else {
        bSnapshot = await bTableCollection.get();
      }
      bChildTable == null
          ? eMain[bTable] = bSnapshot.toListMap()
          : eMain[bChildTable] = bSnapshot.toListMap();
      //Add to data
      data.add(eMain);
    }

    return data;
  }

  StreamController<List<Map<String, dynamic>>> controller =
      StreamController<List<Map<String, dynamic>>>();

  Stream<List<Map<String, dynamic>>> streamDataCollection1N(
      {required String bTable, String? bChildTable}) {
    late CollectionReference<Map<String, dynamic>> bTableCollection =
        FirebaseFirestore.instance.collection(bTable);
    FirebaseFirestore.instance
        .collectionGroup(bChildTable ?? bTable)
        .snapshots()
        .listen((e) async {
      List<Map<String, dynamic>> data = [];
      QuerySnapshot listMain = await ref.get();
      for (var eMain in listMain.toListMap()) {
        String idMainTable = Methods.getString(eMain, FieldName.id);
        late QuerySnapshot bSnapshot;
        if (bChildTable != null) {
          bSnapshot = await bTableCollection
              .doc(idMainTable)
              .collection(bChildTable)
              .get();
        } else {
          bSnapshot = await bTableCollection.get();
        }
        bChildTable == null
            ? eMain[bTable] = bSnapshot.toListMap()
            : eMain[bChildTable] = bSnapshot.toListMap();
        //Add to data
        data.add(eMain);
      }
      controller.add(data);
    });
    return controller.stream;
  }
}
