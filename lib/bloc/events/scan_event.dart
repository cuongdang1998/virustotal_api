import 'package:equatable/equatable.dart';

abstract class ScanEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchScanReportEvent extends ScanEvent{
}