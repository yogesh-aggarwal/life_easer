import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_easer/core/firebase.dart';
import 'package:life_easer/types/email_job.dart';

class EmailJobsProvider with ChangeNotifier {
  List<EmailJob>? jobs;

  String? _forUserID;
  StreamSubscription? _listener;

  void _handleSnapshot(snapshot) {
    jobs = snapshot.docs
        .map((doc) => EmailJob.fromMap(doc.data()))
        .toList<EmailJob>();
    notifyListeners();
  }

  void listenForUser(String userID) {
    if (_forUserID == userID) return;
    _forUserID = userID;

    _listener?.cancel();
    _listener = emailJobsColl
        .where('userID', isEqualTo: userID)
        .snapshots()
        .listen(_handleSnapshot);
  }

  void listenForCurrentUser() {
    final uid = auth.currentUser?.uid;
    if (uid == null) return;

    listenForUser(uid);
  }
}
