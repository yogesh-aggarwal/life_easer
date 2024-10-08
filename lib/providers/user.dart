import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life_easer/core/firebase.dart';
import 'package:life_easer/types/user.dart';

class UserProvider with ChangeNotifier {
  User? user;

  StreamSubscription? _listener;
  StreamSubscription? _userListener;

  String? getUID() {
    return auth.currentUser?.uid;
  }

  void _listen(String uid) {
    if (user != null && user!.id != uid) {
      _userListener?.cancel();
    }

    _userListener = usersColl.doc(uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        user = User.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  initAuth({required Function onUserAvailable}) {
    if (_listener != null) return;

    _listener = auth.authStateChanges().listen((user) async {
      if (user == null) {
        this.user = null;
        _userListener?.cancel();
        notifyListeners();

        return;
      }

      onUserAvailable();

      _listen(user.uid);
    });
  }
}
