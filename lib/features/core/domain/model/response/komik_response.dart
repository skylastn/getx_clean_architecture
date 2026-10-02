// To parse this JSON data, do
//
//     final komikResponse = komikResponseFromJson(jsonString);

import 'dart:convert';

KomikResponse komikResponseFromJson(String str) =>
    KomikResponse.fromJson(json.decode(str));

String komikResponseToJson(KomikResponse data) => json.encode(data.toJson());

class KomikResponse {
  String? message;
  List<DataKomik>? datas;

  KomikResponse({
    required this.message,
    required this.datas,
  });

  factory KomikResponse.fromJson(Map<String, dynamic> json) => KomikResponse(
        message: json['message'],
        datas: List<DataKomik>.from(json['datas'].map((x) => DataKomik.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'datas': List<dynamic>.from((datas ?? []).map((x) => x.toJson())),
      };
}

class DataKomik {
  String? title;
  String? thumbnail;
  String? newestChapter;
  String? rating;
  String? endpoint;
  String? type;

  DataKomik({
    required this.title,
    required this.thumbnail,
    required this.newestChapter,
    required this.rating,
    required this.endpoint,
    required this.type,
  });

  factory DataKomik.fromJson(Map<String, dynamic> json) => DataKomik(
        title: json['title'],
        thumbnail: json['thumbnail'],
        newestChapter: json['newest_chapter'],
        rating: json['rating'],
        endpoint: json['endpoint'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'thumbnail': thumbnail,
        'newest_chapter': newestChapter,
        'rating': rating,
        'endpoint': endpoint,
        'type': type,
      };
}
