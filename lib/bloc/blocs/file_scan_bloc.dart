import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/bloc/bloc_export.dart';
class ScanFileBloc extends Bloc<FileScanEvent,FileScanState>{

  FetchFileScanReport _scanReport=FetchFileScanReport();

  ScanFileBloc(FileScanState initialState) : super(initialState);
  @override
  Stream<FileScanState> mapEventToState(FileScanEvent event) async*{
    switch(event.runtimeType){
      case FetchFileScanReportEvent:
        yield LoadingFileScanState();
        try{
          final scans= await _scanReport.fetchFileScanList();
          yield SucceededFileScanState(scans: scans);
        }catch(_){
          yield FailedFileScanState();
        }
    }
  }
}