class UserSampleEmail {
  final String subject;
  final String body;

  UserSampleEmail({
    required this.subject,
    required this.body,
  });

  factory UserSampleEmail.fromMap(Map<String, dynamic> map) {
    return UserSampleEmail(
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

class UserResume {
  final String title;
  final String url;
  final int dateCreated;

  UserResume({
    required this.title,
    required this.url,
    required this.dateCreated,
  });

  factory UserResume.fromMap(Map<String, dynamic> map) {
    return UserResume(
      title: map['title'],
      url: map['url'],
      dateCreated: map['dateCreated'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'dateCreated': dateCreated,
    };
  }
}

class UserOAuthCredentials {
  final String accessToken;
  final String refreshToken;

  UserOAuthCredentials({
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserOAuthCredentials.fromMap(Map<String, dynamic> map) {
    return UserOAuthCredentials(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}

class UserCredentials {
  final UserOAuthCredentials? googleOAuth;
  final UserOAuthCredentials? mediumOAuth;

  UserCredentials({
    this.googleOAuth,
    this.mediumOAuth,
  });

  factory UserCredentials.fromMap(Map<String, dynamic> map) {
    return UserCredentials(
      googleOAuth: map['googleOAuth'] != null
          ? UserOAuthCredentials.fromMap(map['googleOAuth'])
          : null,
      mediumOAuth: map['mediumOAuth'] != null
          ? UserOAuthCredentials.fromMap(map['mediumOAuth'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'googleOAuth': googleOAuth?.toMap(),
      'mediumOAuth': mediumOAuth?.toMap(),
    };
  }
}

class UserData {
  final String selfDescription;
  final UserSampleEmail sampleEmail;
  final List<UserResume> resumes;

  UserData({
    required this.selfDescription,
    required this.sampleEmail,
    required this.resumes,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      selfDescription: map['selfDescription'],
      sampleEmail: UserSampleEmail.fromMap(map['sampleEmail']),
      resumes: List<UserResume>.from(
        map['resumes']?.map((x) => UserResume.fromMap(x)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selfDescription': selfDescription,
      'sampleEmail': sampleEmail.toMap(),
      'resumes': resumes.map((x) => x.toMap()).toList(),
    };
  }
}

class User {
  final String id;
  final String dp;
  final String email;
  final String name;
  final UserData data;
  final UserCredentials credentials;

  User({
    required this.id,
    required this.dp,
    required this.email,
    required this.name,
    required this.data,
    required this.credentials,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      dp: map['dp'],
      email: map['email'],
      name: map['name'],
      data: UserData.fromMap(map['data']),
      credentials: UserCredentials.fromMap(map['credentials']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dp': dp,
      'email': email,
      'name': name,
      'data': data.toMap(),
      'credentials': credentials.toMap(),
    };
  }
}
