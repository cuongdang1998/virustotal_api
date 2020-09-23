import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/bloc/events/url_scan_event.dart';
import 'package:virus_total_api/bloc/states/url_scan_state.dart';
import 'package:virus_total_api/services/fetch_url_scan_report.dart';

class UrlScanBloc extends Bloc<UrlScanEvent,UrlScanState>{
  UrlScanBloc() : super(InitialScanUrlState());
  FetchUrlScanReport urlScanReport=FetchUrlScanReport();
  @override
  Stream<UrlScanState> mapEventToState(UrlScanEvent event)async* {
    switch(event.runtimeType){
      case FetchUrlScanReportEvent:
        yield LoadingScanUrlState();
        try{
          var scanReport= await urlScanReport.fetchUrlScanReport();
          var scans = await urlScanReport.fetchUrlScanList();
          yield SucceedScanUrlState(urlScan: scans, urlScanReport: scanReport);
        }catch(_){
          yield FailedScanUrlState();
        }
    }
  }
  // @override
  // void onChange(Change<UrlScanState> change) {
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
  // void onTransition(Transition<UrlScanEvent, UrlScanState> transition) {
  //   print(transition);
  //   super.onTransition(transition);
  // }
  //
  // @override
  // void onEvent(UrlScanEvent event) {
  //   print(event);
  //   super.onEvent(event);
  // }

}