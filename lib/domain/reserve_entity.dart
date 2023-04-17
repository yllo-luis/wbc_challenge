class ReserveEntity {
  int? id;
  String? name;
  bool? isPaid;
  bool? isReserved;
  DateTime? dateReservation;
  double? price;

  ReserveEntity({
    this.id,
    this.name,
    this.isPaid,
    this.isReserved,
    this.dateReservation,
    this.price,
  });

  ReserveEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isPaid = json['isPaid'] == 1;
    isReserved = json['isReserved'] == 1;
    dateReservation = DateTime.tryParse(json['dateReservation']);
    price = double.tryParse(json['price']) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isPaid'] = this.isPaid == true ? 1 : 0;
    data['isReserved'] = this.isReserved == true ? 1 : 0;
    data['dateReservation'] = this.dateReservation.toString();
    data['price'] = this.price;
    return data;
  }
}
