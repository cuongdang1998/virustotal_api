class Scan {
  Scan({
    this.detected,
    this.version,
    this.result,
    this.update,
    this.keyscan
  });

  bool detected;
  String version;
  String result;
  String update;
  String keyscan;

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
}
