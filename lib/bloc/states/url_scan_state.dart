import 'package:equatable/equatable.dart';

abstract class UrlScanState extends Equatable{
  @override
  List<Object> get props => [];
}
class InitialPushUrl extends UrlScanState{}
class SucceededPushUrl extends UrlScanState{}
class FailedPushUrl extends UrlScanState{}
class InitialScanUrl extends UrlScanState{}
class SucceedScanUrl extends UrlScanState{}
class FailedScanUrl extends UrlScanState{}