import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/events/scan_event.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/states/scan_state.dart';

class ScanBloc extends Bloc<ScanEvent,ScanState>{
  ScanBloc() : super(InitialScanState());

  FetchFileScanReport _scanReport=FetchFileScanReport();
  @override
  Stream<ScanState> mapEventToState(ScanEvent event) async*{
    try{
      var currentState= state;
      if(event is FetchScanReportEvent){
        final scans= await _scanReport.fetchFileScanList();
        try {
          if (currentState is InitialScanState) {
            yield SucceededScanState(scans: scans);
            return;
          }
          else if (currentState is SucceededScanState) {
            yield SucceededScanState(scans: scans);
          }
          else{
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