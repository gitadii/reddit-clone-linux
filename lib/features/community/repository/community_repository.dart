import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redditclone_linux/core/constants/firebase_constants.dart';
import 'package:redditclone_linux/core/failure.dart';
import 'package:redditclone_linux/core/provider/firebase_provider.dart';
import 'package:redditclone_linux/core/typedef.dart';
import 'package:redditclone_linux/model/community_model.dart';

final communityRepositoryProvider = Provider(
    (ref) => CommunityRepository(firebase: ref.watch(firestoreProvider)));

class CommunityRepository {
  final FirebaseFirestore _firestore;

  CommunityRepository({required FirebaseFirestore firebase})
      : _firestore = firebase;

  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw 'Sorry, ${community.name} is taken. Try another.';
      }
      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw (e.message!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _communities =>
      _firestore.collection(FirebaseConstants.communitiesCollection);

  Stream<List<Community>> getUserCommunity(String uid) {
    return _communities
        .where('members', arrayContains: uid)
        .snapshots()
        .map((event) {
      List<Community> communities = [];
      for (var doc in event.docs) {
        communities.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }

      return communities;
    });
  }
}
