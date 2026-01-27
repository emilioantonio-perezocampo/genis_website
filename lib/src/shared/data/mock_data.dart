import 'package:genis_website/src/shared/domain/models.dart';

const projects = [
  Project(
    id: "1",
    name: "Enterprise Search RAG",
    client: "Acme Corp",
    status: "In Progress",
    lastUpdate: "2024-03-10",
    nextMilestone: "2024-03-25",
    description: "Implementing a retrieval-augmented generation system for internal knowledge base.",
  ),
  Project(
    id: "2",
    name: "Customer Churn Model",
    client: "Acme Corp",
    status: "Review",
    lastUpdate: "2024-03-12",
    nextMilestone: "2024-03-20",
    description: "Predictive modeling to identify at-risk customers.",
  ),
  Project(
    id: "3",
    name: "Supply Chain Optimization",
    client: "LogistiCo",
    status: "Blocked",
    blockedReason: "Waiting on API Access",
    lastUpdate: "2024-03-08",
    nextMilestone: "2024-04-01",
    description: "Optimization algorithms for last-mile delivery.",
  ),
];

const updates = [
  Update(
    id: "101",
    projectId: "1",
    date: "2024-03-10",
    author: "Emilio (GIS)",
    summary: [
      "Completed vector database ingestion pipeline.",
      "Initial semantic search accuracy at 85%.",
      "Next: Fine-tuning the re-ranking model."
    ],
    links: [LinkItem(text: "Performance Report", url: "#")],
  ),
  Update(
    id: "102",
    projectId: "1",
    date: "2024-03-03",
    author: "Giovanna (GIS)",
    summary: [
      "Kickoff meeting completed.",
      "Access credentials received.",
      "Architecture diagram approved."
    ],
  ),
  Update(
    id: "103",
    projectId: "3",
    date: "2024-03-08",
    author: "Emilio (GIS)",
    summary: [
      "Data exploration phase complete.",
      "Identifying quality issues in Q3 logistics logs.",
      "BLOCKED: Still waiting on production API keys from IT security."
    ],
  ),
];

const docs = [
  Doc(id: "d1", projectId: "1", title: "Technical Architecture v1.0", type: "markdown"),
  Doc(id: "d2", projectId: "1", title: "API Documentation", type: "markdown"),
  Doc(id: "d3", projectId: "1", title: "Meeting Notes: Kickoff", type: "markdown"),
];

const files = [
  FileModel(id: "f1", projectId: "1", name: "architecture_diagram.pdf", version: "1.0", date: "2024-02-28"),
  FileModel(id: "f2", projectId: "1", name: "initial_model_weights.pt", version: "0.1", date: "2024-03-05"),
];

const caseStudies = [
  CaseStudy(
    id: "cs1",
    title: "Automating Legal Document Review",
    category: "Automation",
    industry: "Legal Tech",
    outcome: "70% reduction in manual review time",
    image: "https://images.unsplash.com/photo-1666718621210-e662947b5dc3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtb2Rlcm4lMjBvZmZpY2UlMjBtaW5pbWFsJTIwZ3JheXNjYWxlfGVufDF8fHx8MTc2ODUyNDc5NXww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
  ),
  CaseStudy(
    id: "cs2",
    title: "Predictive Maintenance for Manufacturing",
    category: "MLOps",
    industry: "Industrial",
    outcome: "\$2M/year saved in downtime",
    image: "https://images.unsplash.com/photo-1765046255478-55efc763637c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0ZWNobm9sb2d5JTIwYWJzdHJhY3QlMjBtaW5pbWFsJTIwZ3JheXNjYWxlfGVufDF8fHx8MTc2ODUyNDc5NXww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
  ),
  CaseStudy(
    id: "cs3",
    title: "Customer Service Agentic Workflow",
    category: "Agentic Systems",
    industry: "Fintech",
    outcome: "45% deflection rate increase",
    image: "https://images.unsplash.com/photo-1736021825690-4a86f172bc2b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwcm9mZXNzaW9uYWwlMjBwb3J0cmFpdCUyMGdyYXlzY2FsZXxlbnwxfHx8fDE3Njg0NTg0OTZ8MA&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral",
  ),
];

const clients = [
  Client(id: "1", name: "Acme Corp", email: "admin@acme.com", role: "Admin", status: "Active"),
  Client(id: "2", name: "LogistiCo", email: "cto@logistico.com", role: "Viewer", status: "Active"),
];

const notifications = [
  AppNotification(id: "n1", clientId: "1", text: "New update posted for Enterprise Search RAG", date: "2 hours ago", read: false, type: "update"),
  AppNotification(id: "n2", clientId: "1", text: "Milestone 'Architecture Validation' completed", date: "1 day ago", read: true, type: "milestone"),
  AppNotification(id: "n3", clientId: "1", text: "New document 'API Specs' published", date: "2 days ago", read: true, type: "doc"),
];

const auditLogs = [
  AuditLogEntry(id: "al1", action: "Login", user: "Acme Admin", date: "2024-03-12 09:00:00"),
  AuditLogEntry(id: "al2", action: "Download", user: "Acme User", date: "2024-03-11 14:30:00", details: "Downloaded architecture_diagram.pdf"),
  AuditLogEntry(id: "al3", action: "Status Change", user: "Giovanna (GIS)", date: "2024-03-10 16:45:00", details: "Changed Project 1 status to In Progress"),
];
