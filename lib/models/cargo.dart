import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class cargo {
  String weight;
  String oil;
  String candles;
  String waxneeded;
  String oilneeded;
  cargo({
    required this.weight,
    required this.oil,
    required this.candles,
    required this.waxneeded,
    required this.oilneeded,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight,
      'oil': oil,
      'candles': candles,
      'waxneeded': waxneeded,
      'oilneeded': oilneeded,
    };
  }

  factory cargo.fromMap(Map<String, dynamic> map) {
    return cargo(
      weight: map['weight'] as String,
      oil: map['oil'] as String,
      candles: map['candles'] as String,
      waxneeded: map['waxneeded'] as String,
      oilneeded: map['oilneeded'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory cargo.fromJson(String source) => cargo.fromMap(json.decode(source) as Map<String, dynamic>);
  }
