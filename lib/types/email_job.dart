enum EmailJobStatus {
  working("WORKING"),
  waiting("WAITING"),
  failed("FAILED"),
  completed("COMPLETED");

  final String value;
  const EmailJobStatus(this.value);

  static EmailJobStatus fromString(String status) {
    return EmailJobStatus.values.firstWhere((e) => e.value == status,
        orElse: () => throw Exception("Invalid EmailJobStatus value"));
  }
}

enum EmailJobTask {
  generateEmail("GENERATE_EMAIL"),
  sendMail("SEND_MAIL");

  final String value;
  const EmailJobTask(this.value);

  static EmailJobTask fromString(String task) {
    return EmailJobTask.values.firstWhere((e) => e.value == task,
        orElse: () => throw Exception("Invalid EmailJobTask value"));
  }
}

class EmailJobDetails {
  final String targetCompanyName;
  final String targetJobID;
  final String targetJobLink;
  final String targetJobTitle;
  final String targetJobDescription;
  final String targetPersonName;
  final String targetPersonEmail;
  final String targetPersonPosition;
  final String? targetPersonLinkedinProfileContent;
  final String resumeURL;

  EmailJobDetails({
    required this.targetCompanyName,
    required this.targetJobID,
    required this.targetJobLink,
    required this.targetJobTitle,
    required this.targetJobDescription,
    required this.targetPersonName,
    required this.targetPersonEmail,
    required this.targetPersonPosition,
    this.targetPersonLinkedinProfileContent,
    required this.resumeURL,
  });

  factory EmailJobDetails.fromMap(Map<String, dynamic> map) {
    return EmailJobDetails(
      targetCompanyName: map['targetCompanyName'],
      targetJobID: map['targetJobID'],
      targetJobLink: map['targetJobLink'],
      targetJobTitle: map['targetJobTitle'],
      targetJobDescription: map['targetJobDescription'],
      targetPersonName: map['targetPersonName'],
      targetPersonEmail: map['targetPersonEmail'],
      targetPersonPosition: map['targetPersonPosition'],
      targetPersonLinkedinProfileContent:
          map['targetPersonLinkedinProfileContent'],
      resumeURL: map['resumeURL'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'targetCompanyName': targetCompanyName,
      'targetJobID': targetJobID,
      'targetJobLink': targetJobLink,
      'targetJobTitle': targetJobTitle,
      'targetJobDescription': targetJobDescription,
      'targetPersonName': targetPersonName,
      'targetPersonEmail': targetPersonEmail,
      'targetPersonPosition': targetPersonPosition,
      'targetPersonLinkedinProfileContent': targetPersonLinkedinProfileContent,
      'resumeURL': resumeURL,
    };
  }
}

class EmailJobResult {
  final String subject;
  final String body;

  EmailJobResult({
    required this.subject,
    required this.body,
  });

  factory EmailJobResult.fromMap(Map<String, dynamic> map) {
    return EmailJobResult(
      subject: map['subject'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'body': body,
    };
  }
}

class EmailJob {
  final String id;
  final EmailJobStatus status;
  final String userID;
  final int dateCreated;
  final int dateUpdated;
  final String? systemMessage;
  final EmailJobTask task;
  final EmailJobDetails details;
  final int? dateEmailSent;
  final EmailJobResult? result;

  EmailJob({
    required this.id,
    required this.status,
    required this.userID,
    required this.dateCreated,
    required this.dateUpdated,
    this.systemMessage,
    required this.task,
    required this.details,
    this.dateEmailSent,
    this.result,
  });

  factory EmailJob.fromMap(Map<String, dynamic> map) {
    return EmailJob(
      id: map['id'],
      status: EmailJobStatus.fromString(map['status']),
      userID: map['userID'],
      dateCreated: map['dateCreated'],
      dateUpdated: map['dateUpdated'],
      systemMessage: map['systemMessage'],
      task: EmailJobTask.fromString(map['task']),
      details: EmailJobDetails.fromMap(map['details']),
      dateEmailSent: map['dateEmailSent'],
      result:
          map['result'] != null ? EmailJobResult.fromMap(map['result']) : null,
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
      'dateEmailSent': dateEmailSent,
      'result': result?.toMap(),
    };
  }
}
