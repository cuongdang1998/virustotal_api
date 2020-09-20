import 'package:equatable/equatable.dart';

abstract class FileScanEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchFileScanReportEvent extends FileScanEvent{
}