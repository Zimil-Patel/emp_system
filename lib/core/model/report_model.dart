import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String type;
  final String title;
  final String description;
  final String reportedBy;
  final DateTime reportedDate;
  final String status;
  final String? resolutionDetails;

  ReportModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.reportedBy,
    required this.reportedDate,
    required this.status,
    this.resolutionDetails,
  });

  factory ReportModel.fromFirebase(Map<String, dynamic> map, String id) {
    return ReportModel(
      id: id,
      type: map['type'],
      title: map['title'],
      description: map['description'],
      reportedBy: map['reportedBy'],
      reportedDate: (map['reportedDate'] as Timestamp).toDate(),
      status: map['status'],
      resolutionDetails: map['resolutionDetails'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'description': description,
      'reportedBy': reportedBy,
      'reportedDate': reportedDate,
      'status': status,
      if (resolutionDetails != null) 'resolutionDetails': resolutionDetails,
    };
  }
}
