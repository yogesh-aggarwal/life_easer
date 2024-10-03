class Company {
  String name;
  int jobCount;
  int lastUpdated;

  Company({
    required this.name,
    required this.jobCount,
    required this.lastUpdated,
  });
}

class JobListing {
  String id;
  int peopleCount;
  int lastUpdated;

  JobListing({
    required this.id,
    required this.peopleCount,
    required this.lastUpdated,
  });
}
