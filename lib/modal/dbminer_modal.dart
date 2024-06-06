class QuoteData {
  String category;
  List<Datum> data;

  QuoteData({
    required this.category,
    required this.data,
  });

  factory QuoteData.fromSQL(Map<String, dynamic> json) => QuoteData(
        category: json["category"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromSQL(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String quote;
  String author;

  Datum({
    required this.quote,
    required this.author,
  });

  factory Datum.fromSQL(Map<String, dynamic> json) => Datum(
        quote: json["quote"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "quote": quote,
        "author": author,
      };
}
