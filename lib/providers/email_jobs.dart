import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_easer/core/firebase.dart';
import 'package:life_easer/types/email_job.dart';
import 'package:life_easer/types/ui/mailing.dart';

class EmailJobsProvider with ChangeNotifier {
  List<EmailJob>? jobs;
  // company -> job listing -> jobs
  Map<String, Map<String, List<EmailJob>>>? _groupedJobs;

  String? _forUserID;
  StreamSubscription? _listener;

  List<Company>? getCompanies() {
    if (_groupedJobs == null) return null;

    List<Company> companies = [];
    for (var company in _groupedJobs!.keys) {
      int jobCount = 0;
      int lastUpdated = 0;

      for (var jobListing in _groupedJobs![company]!.values) {
        jobCount += jobListing.length;
        for (var job in jobListing) {
          lastUpdated =
              lastUpdated > job.dateUpdated ? lastUpdated : job.dateUpdated;
        }
      }

      companies.add(Company(
        name: company,
        jobCount: jobCount,
        lastUpdated: lastUpdated,
      ));
    }

    return companies;
  }

  List<JobListing>? getJobListings(String company) {
    if (_groupedJobs == null || !_groupedJobs!.containsKey(company)) {
      return null;
    }

    List<JobListing> jobListings = [];
    for (var jobListing in _groupedJobs![company]!.keys) {
      int lastUpdated = 0;
      for (var job in _groupedJobs![company]![jobListing]!) {
        lastUpdated = max(lastUpdated, job.dateUpdated);
      }

      final int peopleCount = _groupedJobs![company]![jobListing]!.length;
      jobListings.add(JobListing(
        id: jobListing,
        peopleCount: peopleCount,
        lastUpdated: lastUpdated,
      ));
    }

    return jobListings;
  }

  List<EmailJob>? getJobs(String company, String jobListing) {
    if (_groupedJobs == null ||
        !_groupedJobs!.containsKey(company) ||
        !_groupedJobs![company]!.containsKey(jobListing)) {
      return null;
    }

    return _groupedJobs![company]![jobListing]!;
  }

  void _handleSnapshot(QuerySnapshot snapshot) {
    jobs = snapshot.docs
        .map((doc) => EmailJob.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    _groupedJobs = {};
    for (var job in jobs!) {
      // Group by company
      if (!_groupedJobs!.containsKey(job.details.targetCompanyName)) {
        _groupedJobs![job.details.targetCompanyName] = {};
      }

      // Group by job listing
      if (!_groupedJobs![job.details.targetCompanyName]!
          .containsKey(job.details.targetJobID)) {
        _groupedJobs![job.details.targetCompanyName]![job.details.targetJobID] =
            [];
      }

      _groupedJobs![job.details.targetCompanyName]![job.details.targetJobID]!
          .add(job);
    }

    print(_groupedJobs);

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
