enum PublishingJobStatus {
  working("WORKING"),
  waiting("WAITING"),
  failed("FAILED"),
  completed("COMPLETED");

  final String value;
  const PublishingJobStatus(this.value);

  static PublishingJobStatus fromString(String status) {
    return PublishingJobStatus.values.firstWhere((e) => e.value == status,
        orElse: () => throw Exception("Invalid PublishingJobStatus value"));
  }
}

enum PublishingJobTask {
  publish("PUBLISH");

  final String value;
  const PublishingJobTask(this.value);

  static PublishingJobTask fromString(String task) {
    return PublishingJobTask.values.firstWhere((e) => e.value == task,
        orElse: () => throw Exception("Invalid PublishingJobTask value"));
  }
}

class PublishingJobDetails {
  final String title;
  final String content;
  final List<String> tags;
  final String canonicalURL;
  final String visibility;

  PublishingJobDetails({
    required this.title,
    required this.content,
    required this.tags,
    required this.canonicalURL,
    required this.visibility,
  });

  factory PublishingJobDetails.fromMap(Map<String, dynamic> map) {
    return PublishingJobDetails(
      title: map['title'],
      content: map['content'],
      tags: List<String>.from(map['tags']),
      canonicalURL: map['canonicalURL'],
      visibility: map['visibility'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      'canonicalURL': canonicalURL,
      'visibility': visibility,
    };
  }
}

class PublishingJobResult {
  final String url;

  PublishingJobResult({
    required this.url,
  });

  factory PublishingJobResult.fromMap(Map<String, dynamic> map) {
    return PublishingJobResult(
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
    };
  }
}

class PublishingJob {
  final String id;
  final PublishingJobStatus status;
  final String userID;
  final int dateCreated;
  final int dateUpdated;
  final String? systemMessage;
  final PublishingJobTask task;
  final PublishingJobDetails details;
  final PublishingJobResult? result;

  PublishingJob({
    required this.id,
    required this.status,
    required this.userID,
    required this.dateCreated,
    required this.dateUpdated,
    this.systemMessage,
    required this.task,
    required this.details,
    this.result,
  });

  factory PublishingJob.fromMap(Map<String, dynamic> map) {
    return PublishingJob(
      id: map['id'],
      status: PublishingJobStatus.fromString(map['status']),
      userID: map['userID'],
      dateCreated: map['dateCreated'],
      dateUpdated: map['dateUpdated'],
      systemMessage: map['systemMessage'],
      task: PublishingJobTask.fromString(map['task']),
      details: PublishingJobDetails.fromMap(map['details']),
      result: map['result'] != null
          ? PublishingJobResult.fromMap(map['result'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      'userID': userID,
      'dateCreated': dateCreated,
      'dateUpdated': dateUpdated,
      'systemMessage': systemMessage,
      'task': task.toString().split('.').last,
      'details': details.toMap(),
      'result': result?.toMap(),
    };
  }
}
