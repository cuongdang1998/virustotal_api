class Src {
  final String original;
  final String large2x;
  final String large;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  Src({this.original, this.large2x, this.large, this.small, this.portrait,
      this.landscape, this.tiny});
  factory Src.fromJson(Map<String, dynamic> json){
    return Src(
        original: json['original'],
        large2x: json['large2x'],
        large: json['large'],
        small: json['small'],
        portrait: json['portrait'],
        landscape: json['landscape'],
        tiny: json['tiny']
    );
  }
}