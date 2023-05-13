// To parse this JSON data, do
//
//     final documentModel = documentModelFromJson(jsonString);

import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(ToDocumentModel data) => json.encode(data.toJson());

class ToDocumentModel {
  ToDocumentModel({
    required this.studentId,
  });
  int studentId;
  Map<String, dynamic> toJson() => {
    "student_id": studentId,
  };
}

class DocumentModel {
  DocumentModel({
    required this.error,
    required this.status,
    required this.data,
  });

  int error;
  String status;
  Map<String, dynamic> data;

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
    error: json["error"],
    status: json["status"],
    data: json["data"],
  );
}

class Data {
  Data({
    required this.folders,
  });

  Folders folders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    folders: Folders.fromJson(json["folders"]),
  );

  Map<String, dynamic> toJson() => {
    "folders": folders.toJson(),
  };
}

class Folders {
  Folders({
    required this.yearFolder,
    required this.monthFolder,
  });

  String yearFolder;
  List<MonthFolder> monthFolder;

  factory Folders.fromJson(Map<String, dynamic> json) => Folders(
    yearFolder: json["year_folder"],
    monthFolder: List<MonthFolder>.from(json["month_folder"].map((x) => MonthFolder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "year_folder": yearFolder,
    "month_folder": List<dynamic>.from(monthFolder.map((x) => x.toJson())),
  };
}

class MonthFolder {
  MonthFolder({
    required this.folderName,
    required this.documents,
  });

  String folderName;
  List<Document>? documents;

  factory MonthFolder.fromJson(Map<String, dynamic> json) => MonthFolder(
    folderName: json["folder_name"],
    documents: json["documents"] == null ? null : List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "folder_name": folderName,
    "documents": documents == null ? null : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class Document {
  Document({
    required this.document,
  });

  String document;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    document: json["document"],
  );

  Map<String, dynamic> toJson() => {
    "document": document,
  };
}
