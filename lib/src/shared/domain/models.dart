class Project {
  final String id;
  final String name;
  final String client;
  final String status;
  final String? blockedReason;
  final String lastUpdate;
  final String nextMilestone;
  final String description;

  const Project({
    required this.id,
    required this.name,
    required this.client,
    required this.status,
    this.blockedReason,
    required this.lastUpdate,
    required this.nextMilestone,
    required this.description,
  });
}

class Client {
  final String id;
  final String name;
  final String? email;
  final String? role;
  final String? status;

  const Client({
    required this.id,
    required this.name,
    this.email,
    this.role,
    this.status,
  });
}

class Update {
  final String id;
  final String projectId;
  final String date;
  final String author;
  final List<String> summary;
  final List<LinkItem>? links;

  const Update({
    required this.id,
    required this.projectId,
    required this.date,
    required this.author,
    required this.summary,
    this.links,
  });
}

class LinkItem {
  final String text;
  final String url;

  const LinkItem({required this.text, required this.url});
}

class Doc {
  final String id;
  final String projectId;
  final String title;
  final String type;

  const Doc({
    required this.id,
    required this.projectId,
    required this.title,
    required this.type,
  });
}

class FileModel {
  final String id;
  final String projectId;
  final String name;
  final String version;
  final String date;

  const FileModel({
    required this.id,
    required this.projectId,
    required this.name,
    required this.version,
    required this.date,
  });
}

class CaseStudy {
  final String id;
  final String title;
  final String category;
  final String industry;
  final String outcome;
  final String image;

  const CaseStudy({
    required this.id,
    required this.title,
    required this.category,
    required this.industry,
    required this.outcome,
    required this.image,
  });
}

class AppNotification {
  final String id;
  final String clientId;
  final String text;
  final String date;
  final bool read;
  final String type;

  const AppNotification({
    required this.id,
    required this.clientId,
    required this.text,
    required this.date,
    required this.read,
    required this.type,
  });
}