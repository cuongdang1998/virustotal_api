import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/models/file_scan_report.dart';

abstract class ScanState extends Equatable{
  @override
  List<Object> get props => [];
}
class InitialScanState extends ScanState{
}
class FailedScanState extends ScanState{
}
class SucceededScanState extends ScanState{
  final List<Scan> scans;
  SucceededScanState({this.scans});
}