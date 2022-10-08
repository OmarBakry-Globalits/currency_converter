class CurrencyConverterEntity {
  CurrencyConverterEntity({
    this.date,
    this.info,
    this.query,
    this.result,
    this.success,
  });

  DateTime? date;
  Info? info;
  Query? query;
  num? result;
  bool? success;
}


class Info {
    Info({
        this.rate,
        this.timestamp,
    });

    num? rate;
    num? timestamp;

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        rate: json["rate"].toDouble(),
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "timestamp": timestamp,
    };
}

class Query {
    Query({
        this.amount,
        this.from,
        this.to,
    });

    num? amount;
    String? from;
    String? to;

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        amount: json["amount"],
        from: json["from"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "from": from,
        "to": to,
    };
}
