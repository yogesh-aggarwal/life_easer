import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_easer/core/firebase.dart';
import 'package:life_easer/types/publishing_job.dart';

class PublishingJobsProvider with ChangeNotifier {
  List<PublishingJob>? jobs;

  String? _forUserID;
  StreamSubscription? _listener;

  void _handleSnapshot(QuerySnapshot snapshot) {
    jobs = snapshot.docs
        .map((doc) => PublishingJob.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  void _listenForUser(String userID) {
    if (_forUserID == userID) return;
    _forUserID = userID;

    _listener?.cancel();
    _listener = publishingJobsColl
        .where('userID', isEqualTo: userID)
        .snapshots()
        .listen(_handleSnapshot);
  }

  void listenForCurrentUser() {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    _listenForUser(uid);
  }
}
