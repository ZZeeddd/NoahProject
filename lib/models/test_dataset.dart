// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TestDataset {
  String name;
  int age;
  String company;
  TestDataset({
    this.name,
    this.age,
    this.company,
  });

  TestDataset copyWith({
    String name,
    int age,
    String company,
  }) {
    return TestDataset(
      name: name ?? this.name,
      age: age ?? this.age,
      company: company ?? this.company,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'company': company,
    };
  }

  factory TestDataset.fromMap(Map<String, dynamic> map) {
    return TestDataset(
      name: map['name'] as String,
      age: map['age'] as int,
      company: map['company'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TestDataset.fromJson(String source) => TestDataset.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TestCollection(name: $name, age: $age, company: $company)';

  @override
  bool operator ==(covariant TestDataset other) {
    if (identical(this, other)) return true;

    return other.name == name && other.age == age && other.company == company;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode ^ company.hashCode;
}
