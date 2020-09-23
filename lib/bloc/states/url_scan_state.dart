import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/url_scan.dart';
import 'package:virus_total_api/models/url_scan_report.dart';

abstract class UrlScanState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialScanUrlState extends UrlScanState{}
class LoadingScanUrlState extends UrlScanState{}
class SucceedScanUrlState extends UrlScanState{
  final UrlScanReport urlScanReport;
  final List<UrlScan> urlScan;
  SucceedScanUrlState({this.urlScanReport, this.urlScan});
  List<Object> get props => [urlScan, urlScanReport];
}
class FailedScanUrlState extends UrlScanState{}