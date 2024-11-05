class Presence {
  final int profileId;
  final String uniqueId;
  final int setup;
  final int docType;
  final String doc;
  final String contactName;
  final String phoneNumber;

  Presence({
    required this.profileId,
    required this.uniqueId,
    required this.setup,
    required this.docType,
    required this.doc,
    required this.contactName,
    required this.phoneNumber,
  });

  // Método para criar um Presence a partir de um Map (JSON)
  factory Presence.fromJson(Map<String, dynamic> json) {
    return Presence(
      profileId: json['profile_id'] as int,
      uniqueId: json['unique_id'] as String,
      setup: json['setup'] as int,
      docType: json['doc_type'] as int,
      doc: json['doc'] as String,
      contactName: json['contact_name'] as String,
      phoneNumber: json['phone_number'] as String,
    );
  }

  // Método para criar uma lista de Presence a partir de uma lista de Map (JSON)
  static List<Presence> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Presence.fromJson(json)).toList();
  }
}
