import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virus_total_api/viewmodel/bloc_export.dart';
import 'package:virus_total_api/services/url_scan_service.dart';

class UrlScanBloc extends Bloc<UrlScanEvent,UrlScanState>{
  UrlScanBloc() : super(InitialScanUrlState());
  UrlScanService _urlScanService=UrlScanService();
  @override
  Stream<UrlScanState> mapEventToState(UrlScanEvent event)async* {
    switch(event.runtimeType){
      case FetchUrlScanReportEvent:
        yield LoadingScanUrlState();
        try{
          // var result= await _urlScanService.pushUrlScan();
          // print(result);
          var scanReport = await _urlScanService.fetchUrlScanReport();
          var scans = await _urlScanService.fetchUrlScanList();
          yield SucceedScanUrlState(urlScan: scans, urlScanReport: scanReport);
        }catch(_){
          yield FailedScanUrlState();
        }
    }
  }
}