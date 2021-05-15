import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      print('Error caught: $e');
      return null;
    }
  }

  static Future<String?> createAdvert(Advert advert) async {
    final docAdvert = FirebaseFirestore.instance.collection('adverts').doc();
    advert.id = docAdvert.id;
    await docAdvert.set(advert.toJson());
    return docAdvert.id;
  }

  static Stream<List<Advert>> readAdverts() => FirebaseFirestore.instance
      .collection('adverts')
      .orderBy(AdvertField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Advert.fromJson)
          as StreamTransformer<QuerySnapshot, List<Advert>>);

  static Future editAdvertApi(Advert advert) async {
    final docAdvert =
        FirebaseFirestore.instance.collection('adverts').doc(advert.id);
    await docAdvert.update(advert.toJson());
  }

  static Future deleteAdvertApi(Advert advert) async {
    final docAdvert =
        FirebaseFirestore.instance.collection('adverts').doc(advert.id);
    await docAdvert.delete();
  }
}
