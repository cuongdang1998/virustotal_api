import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/url_scan.dart';

class UrlScanReport extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
  UrlScanReport({
    this.scanId,
    this.resource,
    this.url,
    this.responseCode,
    this.scanDate,
    this.permalink,
    this.verboseMsg,
    this.filescanId,
    this.positives,
    this.total,
    this.scans,
  });

  final String scanId;
  final String resource;
  final String url;
  final int responseCode;
  final DateTime scanDate;
  final String permalink;
  final String verboseMsg;
  final dynamic filescanId;
  final int positives;
  final int total;
  final Map<String, dynamic> scans;
  factory UrlScanReport.fromJson(Map<String, dynamic> json) => UrlScanReport(
    scanId: json["scan_id"],
    resource: json["resource"],
    url: json["url"],
    responseCode: json["response_code"],
    scanDate: DateTime.parse(json["scan_date"]),
    permalink: json["permalink"],
    verboseMsg: json["verbose_msg"],
    filescanId: json["filescan_id"],
    positives: json["positives"],
    total: json["total"],
    scans: Map.from(json["scans"]).map((key, value) => MapEntry<String,dynamic>(key, UrlScan.fromJson(key, value)))
  );
}