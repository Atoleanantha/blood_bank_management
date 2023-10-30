class RegistrationModel {
  String name;
  String addharNo;
  String phoneNo;
  String bloodGroup;
  String gender;
  String dob;
  String age;
  String address;
  RegistrationModel({
    required this.name,
    required this.addharNo,
    required this.phoneNo,
    required this.bloodGroup,
    required this.gender,
    required this.dob,
    required this.age,
    required this.address,
  });
}

class RetriveDonorModel extends RegistrationModel {
  List<String> updateHistory;
  RetriveDonorModel(
      {required super.name,
      required super.addharNo,
      required super.phoneNo,
      required super.bloodGroup,
      required super.gender,
      required super.dob,
      required super.age,
      required super.address,
      required this.updateHistory});

  factory RetriveDonorModel.fromMap(Map<String, dynamic> map) {
    return RetriveDonorModel(
      addharNo: map['addharId'],
      name: map['name'],
      phoneNo: map['mobileNumber'],
      address: map['address'],
      gender: map['gender'],
      dob: map['dob'],
      age: map['age'],
      bloodGroup: map['bloodGroup'],
      updateHistory: List<String>.from(map['updateHistory']),
    );
  }
}
