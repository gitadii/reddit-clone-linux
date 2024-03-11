import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redditclone_linux/core/failure.dart';
import 'package:redditclone_linux/core/provider/firebase_provider.dart';
import 'package:redditclone_linux/core/typedef.dart';

// Provider for StorageRepo
final storageRepositoryProvider = Provider(
  (ref) => StorageRopository(
    firebaseStorage: ref.watch(storageProvider),
  ),
);

class StorageRopository {
  final FirebaseStorage _firebaseStorage;

  StorageRopository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required File? file,
  }) async {
    try {
      // Creating a reference to a location in Firebase Storage based on the provided path and id
      final ref = _firebaseStorage.ref().child(path).child(id);
      /* FOR MY UNDERSTANDING :
      .ref(): This method is used to obtain a reference to the root directory
              of the Firebase Storage bucket. It's like getting a handle to the root 
              folder where you can start navigating to other folders or files within
              the bucket.
      */

      // Uploading the "file" to the specified Firebase Storage loccation
      UploadTask uploadTask = ref.putFile(file!);

      // Waiting for the upload to complete and obtains a snapshot of it
      final snapshot = await uploadTask;

      // Returning the download URL if gets successfull( which is String) as in userModel the "banner" and "profilepic" are String and not File
      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
