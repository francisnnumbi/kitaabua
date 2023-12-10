class Expression {
  final String word;
  final String addedBy;
  final String addedOn;
  late String? updatedOn;
  late String? updatedBy;
  late bool? state;
  late Map<String, dynamic>? meanings;

  Expression({
    required this.word,
    required this.addedBy,
    required this.addedOn,
    this.updatedOn,
    this.updatedBy,
    this.state,
    this.meanings,
  });

  Expression.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        addedBy = json['addedBy'],
        addedOn = json['addedOn'],
        updatedOn = json['updatedOn'],
        updatedBy = json['updatedBy'],
        state = json['state'],
        meanings = json['meanings'];

  Map<String, dynamic> toJson() => {
        'word': word,
        'addedBy': addedBy,
        'addedOn': addedOn,
        'updatedOn': updatedOn,
        'updatedBy': updatedBy,
        'state': state,
        'meanings': meanings,
      };

  static List<Expression> sampleList() {
    return [
      Expression(word: "Cullotte", addedBy: "Francis", addedOn: "23/09/2022"),
      Expression(word: "Chemise", addedBy: "Francis", addedOn: "28/09/2022"),
      Expression(word: "Mangue", addedBy: "Francis", addedOn: "23/10/2022"),
    ];
  }
}
