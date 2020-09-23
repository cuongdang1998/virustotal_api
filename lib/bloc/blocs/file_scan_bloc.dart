import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/events/file_scan_event.dart';
import 'package:virus_total_api/services/fetch_file_scan_report.dart';
import 'package:virus_total_api/bloc/states/file_scan_state.dart';

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

  // @override
  // void onChange(Change<FileScanState> change) {
  //   print(change);
  //   super.onChange(change);
  // }
  //
  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print("${error}+${stackTrace}");
  //   super.onError(error, stackTrace);
  // }
  //
  // @override
  // void onTransition(Transition<FileScanEvent, FileScanState> transition) {
  //   print(transition);
  //   super.onTransition(transition);
  // }
  //
  // @override
  // void onEvent(FileScanEvent event) {
  //   print(event);
  //   super.onEvent(event);
  // }
}