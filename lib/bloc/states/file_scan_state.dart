import 'package:equatable/equatable.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/models/file_scan_report.dart';

abstract class FileScanState extends Equatable{
  @override
  List<Object> get props => [];
}
class InitialFileScanState extends FileScanState{
}
class LoadingFileScanState extends FileScanState{
}
class SucceededFileScanState extends FileScanState{
  final List<FileScan> scans;
  SucceededFileScanState({this.scans});

  @override
  List<Object> get props => [scans];
}
class FailedFileScanState extends FileScanState{
}