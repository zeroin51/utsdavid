import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Transaksi');

class FirebaseCrud {
//CRUD method here
  static Future<Response> addTransaksi({
    required String kegiatan,
    required String deskripsi,
    required String tanggal,
    required String nominal,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "kegiatan": kegiatan,
      "deskripsi": deskripsi,
      "tanggal" : tanggal,
      "nominal" : nominal
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

  static Stream<QuerySnapshot> readTransaksi() {
    CollectionReference notesItemCollection =
        _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateTransaksi({
    required String kegiatan,
    required String deskripsi,
    required String tanggal,
    required String nominal,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "kegiatan": kegiatan,
      "deskripsi": deskripsi,
      "tanggal" : tanggal,
      "nominal" : nominal
    };

    await documentReferencer
        .update(data)
        .whenComplete(() {
           response.code = 200;
          response.message = "Update Transaksi Sukses";
        })
        .catchError((e) {
            response.code = 500;
            response.message = e;
        });

        return response;
  }

  static Future<Response> deleteTransaksi({
    required String docId,
  }) async {
     Response response = Response();
    DocumentReference documentReferencer =
        _Collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
          response.code = 200;
          response.message = "Data Transaksi Telah Dihapus";
        })
        .catchError((e) {
           response.code = 500;
            response.message = e;
        });

   return response;
  }

}