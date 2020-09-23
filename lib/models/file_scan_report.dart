import 'package:virus_total_api/models/file_scan.dart';

class FileScanReport {
  FileScanReport({
    this.filescans,
    this.scanId,
    this.sha1,
    this.resource,
    this.responseCode,
    this.scanDate,
    this.permalink,
    this.verboseMsg,
    this.total,
    this.positives,
    this.sha256,
    this.md5,
  });

  final Map<String, FileScan> filescans;
  final String scanId;
  final String sha1;
  final String resource;
  final int responseCode;
  final DateTime scanDate;
  final String permalink;
  final String verboseMsg;
  final int total;
  final int positives;
  final String sha256;
  final String md5;

  factory FileScanReport.fromJson(Map<String, dynamic> json) => FileScanReport(
    filescans: Map.from(json["scans"]).map((k, v) =>
      MapEntry<String, FileScan>(k, FileScan.fromJson(k,v))),
    scanId: json["scan_id"],
    sha1: json["sha1"],
    resource: json["resource"],
    responseCode: json["response_code"],
    scanDate: DateTime.parse(json["scan_date"]),
    permalink: json["permalink"],
    verboseMsg: json["verbose_msg"],
    total: json["total"],
    positives: json["positives"],
    sha256: json["sha256"],
    md5: json["md5"],
  );

  // Map<String, dynamic> toJson() => {
  //   "scans": Map.from(filescans).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  //   "scan_id": scanId,
  //   "sha1": sha1,
  //   "resource": resource,
  //   "response_code": responseCode,
  //   "scan_date": scanDate.toIso8601String(),
  //   "permalink": permalink,
  //   "verbose_msg": verboseMsg,
  //   "total": total,
  //   "positives": positives,
  //   "sha256": sha256,
  //   "md5": md5,
  // };
}