import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Mahasiswa');

class FirebaseCrud {
//CRUD method here
  static Future<Response> addMahasiswa({
    required String nama,
    required String jurusan,
    required String fakultas,
    required String nilai,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "jurusan": jurusan,
      "fakultas" : fakultas,
      "nilai" : nilai
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
          response.code = 200;
          response.message = "Berhasil masuk ke database";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Stream<QuerySnapshot> readMahasiswa() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateMahasiswa({
    required String nama,
    required String jurusan,
    required String fakultas,
    required String nilai,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "jurusan": jurusan,
      "fakultas" : fakultas,
      "nilai" : nilai
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
           response.code = 200;
          response.message = "Update Mahasiswa Sukses";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Future<Response> deleteMahasiswa({
    required String docId,
  }) async {
     Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Data Mahasiswa Telah Dihapus";
        })
        .catchError((e) {
           response.code = 500;
            response.message = e;
        });

   return response;
  }

}