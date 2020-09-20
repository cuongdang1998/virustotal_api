import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/models/file_scan_report.dart';

abstract class FileScanState extends Equatable{
  @override
  List<Object> get props => [];
}
class InitialScanState extends FileScanState{
}
class FailedScanState extends FileScanState{
}
class SucceededScanState extends FileScanState{
  final List<Scan> scans;
  SucceededScanState({this.scans});
}