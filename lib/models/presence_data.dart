class Presence {
  String _contact;
  String _phone;
  String _setup;
  String _docType;
  String _doc;
  String _uniqueId;
  DateTime _createdAt;

  Presence({
    required String contact,
    required String phone,
    required String setup,
    required String docType,
    required String doc,
    required String uniqueId,
    required DateTime createdAt,
  })  : _contact = contact,
        _phone = phone,
        _setup = setup,
        _docType = docType,
        _doc = doc,
        _uniqueId = uniqueId,
        _createdAt = createdAt;

  /// Getter and Setter for `contact`
  String get contact => _contact;
  set contact(String value) {
    if (value.isEmpty) throw ArgumentError("Contact cannot be empty.");
    _contact = value;
  }

  /// Getter and Setter for `phone`
  String get phone => _phone;
  set phone(String value) {
    if (value.isEmpty) throw ArgumentError("Phone cannot be empty.");
    _phone = value;
  }

  /// Getter and Setter for `setup`
  String get setup => _setup;
  set setup(String value) {
    if (value.isEmpty) throw ArgumentError("Setup cannot be empty.");
    _setup = value;
  }

  /// Getter and Setter for `docType`
  String get docType => _docType;
  set docType(String value) {
    if (value.isEmpty) throw ArgumentError("DocType cannot be empty.");
    _docType = value;
  }

  /// Getter and Setter for `doc`
  String get doc => _doc;
  set doc(String value) {
    if (value.isEmpty) throw ArgumentError("Doc cannot be empty.");
    _doc = value;
  }

  /// Getter and Setter for `uniqueId`
  String get uniqueId => _uniqueId;
  set uniqueId(String value) {
    if (value.isEmpty) throw ArgumentError("UniqueId cannot be empty.");
    _uniqueId = value;
  }

  /// Getter and Setter for `createdAt`
  DateTime get createdAt => _createdAt;
  set createdAt(DateTime value) {
    if (value.isAfter(DateTime.now())) {
      throw ArgumentError("CreatedAt cannot be in the future.");
    }
    _createdAt = value;
  }

  @override
  String toString() {
    return 'Presence(contact: $contact, phone: $phone, setup: $setup, docType: $docType, doc: $doc, uniqueId: $uniqueId, createdAt: $createdAt)';
  }

  /// Factory constructor to create a Presence instance from a JSON map
  factory Presence.fromJson(Map<String, dynamic> json) {
    return Presence(
      contact: json['contact'],
      phone: json['phone'],
      setup: json['setup'],
      docType: json['doc_type'],
      doc: json['doc'],
      uniqueId: json['uniqueId'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Converts a Presence instance back to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'contact': contact,
      'phone': phone,
      'setup': setup,
      'doc_type': docType,
      'doc': doc,
      'uniqueId': uniqueId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
