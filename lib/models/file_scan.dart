import 'package:equatable/equatable.dart';

class Scan extends Equatable{
  Scan({
    this.detected,
    this.version,
    this.result,
    this.update,
    this.keyscan
  });

  final bool detected;
  final String version;
  final String result;
  final String update;
  final String keyscan;

  factory Scan.fromJson(String keyScan,Map<String, dynamic> json) => Scan(
    keyscan: keyScan,
    detected: json["detected"],
    version: json["version"] == null ? null : json["version"],
    result: json["result"] == null ? null : json["result"],
    update: json["update"],
  );

  Map<String, dynamic> toJson() => {
    "detected": detected,
    "version": version == null ? null : version,
    "result": result == null ? null : result,
    "update": update,
  };
  @override
  String toString() {
    return "Name: ${this.keyscan} result: ${this.result} detected: ${this.detected} version ${this.version}";
  }
  @override
  // TODO: implement props
  List<Object> get props => [];
}
