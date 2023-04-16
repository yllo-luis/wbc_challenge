class ReserveEntity {
  int? id;
  String? name;
  bool? isPaid;
  bool? isReserved;
  String? dateReservation;
  int? price;

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
    isPaid = json['is_paid'];
    isReserved = json['is_reserved'];
    dateReservation = json['date_reservation'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_paid'] = this.isPaid;
    data['is_reserved'] = this.isReserved;
    data['date_reservation'] = this.dateReservation;
    data['price'] = this.price;
    return data;
  }
}
