import 'dart:convert';

Rent rentFromJson(String str) => Rent.fromJson(json.decode(str));
List<Rent> listRentFromJson(String str) =>
    List<Rent>.from(json.decode(str).map((x) => Rent.fromJson(x)));

String rentToJson(Rent data) => json.encode(data.toJson());

class Rent {
  Rent({
    this.id,
    this.custId,
    this.invoiceNumber,
    this.bookDatetime,
    this.paymentDatetime,
    this.rentDatetimeStart,
    this.rentDatetimeEnd,
    this.returnDatetime,
    this.paymentStatus,
    this.paymentFile,
    this.custName,
    this.custAddress,
    this.custPhone,
    this.userId,
    this.status,
    this.items,
    this.totalPrice,
  });

  int id;
  int custId;
  String invoiceNumber;
  DateTime bookDatetime;
  dynamic paymentDatetime;
  DateTime rentDatetimeStart;
  DateTime rentDatetimeEnd;
  dynamic returnDatetime;
  String paymentStatus;
  dynamic paymentFile;
  String custName;
  String custAddress;
  String custPhone;
  int userId;
  String status;
  List<Item> items;
  int totalPrice;

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
        id: json["id"],
        custId: json["cust_id"],
        invoiceNumber: json["invoice_number"],
        bookDatetime: DateTime.parse(json["book_datetime"]),
        paymentDatetime: json["payment_datetime"],
        rentDatetimeStart: DateTime.parse(json["rent_datetime_start"]),
        rentDatetimeEnd: DateTime.parse(json["rent_datetime_end"]),
        returnDatetime: json["return_datetime"],
        paymentStatus: json["payment_status"],
        paymentFile: json["payment_file"],
        custName: json["cust_name"],
        custAddress: json["cust_address"],
        custPhone: json["cust_phone"],
        userId: json["user_id"],
        status: json["status"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalPrice: int.parse(json["total_price"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cust_id": custId,
        "invoice_number": invoiceNumber,
        "book_datetime": bookDatetime.toIso8601String(),
        "payment_datetime": paymentDatetime,
        "rent_datetime_start": rentDatetimeStart.toIso8601String(),
        "rent_datetime_end": rentDatetimeEnd.toIso8601String(),
        "return_datetime": returnDatetime,
        "payment_status": paymentStatus,
        "payment_file": paymentFile,
        "cust_name": custName,
        "cust_address": custAddress,
        "cust_phone": custPhone,
        "user_id": userId,
        "status": status,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total_price": totalPrice,
      };
}

class Item {
  Item({
    this.id,
    this.rentId,
    this.itemId,
    this.itemQty,
    this.rentItemPrice,
    this.itemName,
    this.itemImg,
  });

  int id;
  int rentId;
  int itemId;
  int itemQty;
  int rentItemPrice;
  String itemName;
  String itemImg;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        rentId: json["rent_id"],
        itemId: json["item_id"],
        itemQty: json["item_qty"],
        rentItemPrice: json["rent_item_price"],
        itemName: json["item_name"],
        itemImg: json["item_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rent_id": rentId,
        "item_id": itemId,
        "item_qty": itemQty,
        "rent_item_price": rentItemPrice,
        "item_name": itemName,
        "item_img": itemImg,
      };
}
