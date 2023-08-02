class EarthquakeJson {
  final String id;
  final String text;

  EarthquakeJson({
    required this.id,
    required this.text
  });

  factory EarthquakeJson.fromJson(Map<String, dynamic> json) {
    return EarthquakeJson(
        id: json['id'],
        text: json['text']);
  }
}