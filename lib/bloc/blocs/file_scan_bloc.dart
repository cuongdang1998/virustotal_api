import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/events/file_scan_event.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/bloc/states/file_scan_state.dart';

class ScanFileBloc extends Bloc<FileScanEvent,FileScanState>{

  FetchFileScanReport _scanReport=FetchFileScanReport();

  ScanFileBloc(FileScanState initialState) : super(initialState);
  @override
  Stream<FileScanState> mapEventToState(FileScanEvent event) async*{
    try{
      final scans= await _scanReport.fetchFileScanList();
      var currentState= state;
      if(event is FetchFileScanReportEvent){
        try {
          if (currentState is InitialScanState) {
            yield SucceededScanState(scans: scans);
            return;
          }
          else if(currentState is SucceededScanState) {
            yield SucceededScanState(scans: scans);
          }else{
            yield FailedScanState();
          }

        } catch(_){
          yield FailedScanState();
        }
      }else{
        yield InitialScanState();
      }
    }catch(_){
      yield FailedScanState();
    }
  }

}