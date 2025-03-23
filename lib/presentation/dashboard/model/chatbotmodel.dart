class ModelMessage {
  final bool isPrompt;
  final String message;
  final DateTime time;

  ModelMessage({
    required this.isPrompt,
    required this.message,
    required this.time,
  });

  // Convert a ModelMessage into a Map. The keys must correspond to the names of the fields.
  Map<String, dynamic> toJson() => {
        'isPrompt': isPrompt,
        'message': message,
        'time': time.toIso8601String(),
      };

  // A constructor for creating a new ModelMessage instance from a map.
  factory ModelMessage.fromJson(Map<String, dynamic> json) {
    return ModelMessage(
      isPrompt: json['isPrompt'],
      message: json['message'],
      time: DateTime.parse(json['time']),
    );
  }
}
