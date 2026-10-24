class President {
  final int id;
  final String image;
  final String name;
  final String lastName;
  final String startPeriodDate;
  final String endPeriodDate;
  final String politicalParty;
  final String description;
  final int cityId;

  President({
    required this.id,
    required this.image,
    required this.name,
    required this.lastName,
    required this.startPeriodDate,
    required this.endPeriodDate,
    required this.politicalParty,
    required this.description,
    required this.cityId,
  });

  factory President.fromJson(Map<String, dynamic> json) {
    return President(
      id: json['id'] ?? 0,
      image: (json['image'] == null ||
              json['image'].toString().trim().isEmpty ||
              json['image'].toString().trim().toLowerCase() == 'null')
           ? ''
           : json['image'].toString().trim(),

      name: json['name']?.toString() ?? 'Sin nombre',
      lastName: json['lastName']?.toString() ?? '',
      startPeriodDate: json['startPeriodDate']?.toString() ?? '',
      endPeriodDate: json['endPeriodDate']?.toString() ?? '',
      politicalParty: json['politicalParty']?.toString() ?? 'Sin información',
      description: json['description']?.toString() ?? 'Sin descripción',
      cityId: json['cityId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'lastName': lastName,
      'startPeriodDate': startPeriodDate,
      'endPeriodDate': endPeriodDate,
      'politicalParty': politicalParty,
      'description': description,
      'cityId': cityId,
    };
  }

  String get fullName => '$name $lastName'.trim();
}