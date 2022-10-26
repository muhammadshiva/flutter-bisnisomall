import 'package:marketplace/data/models/models.dart';
import 'package:meta/meta.dart';

enum PaymentType { manual, otomatis }

class PaymentMethodResponse {
  PaymentMethodResponse({
    @required this.message,
    @required this.data,
  });

  final String message;
  final List<PaymentMethod> data;

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<PaymentMethod>.from(
                json["data"].map((x) => PaymentMethod.fromJson(x))),
      );
}

class Payment {
  Payment({
    @required this.id,
    @required this.verificationMethod,
    @required this.link,
    @required this.transactionCode,
    @required this.status,
    @required this.paymentDate,
    @required this.available,
    @required this.amount,
    @required this.paymentMethod,
  });

  final int id;
  final String verificationMethod;
  final String link;
  final String transactionCode;
  final int available;
  final int status;
  final String paymentDate;
  final int amount;
  final PaymentMethod paymentMethod;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        available: json["available"],
        link: json['link'],
        paymentDate: json['payment_date'],
        status: json["status"].runtimeType == String
            ? int.parse(json["status"])
            : json['status'],
        transactionCode: json['transaction_code'],
        verificationMethod: json['verification_method'],
        amount: json["amount"].runtimeType == double
            ? json["amount"].toInt()
            : json["amount"] ?? 0,
        paymentMethod: json['payment_method'] != null
            ? PaymentMethod.fromJson(json["payment_method"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "available": available,
        "link": link,
        "payment_date": paymentDate,
        "status": status,
        "transaction_code": transactionCode,
        "verification_method": verificationMethod,
        "amount": amount,
        "payment_method": paymentMethod,
      };
}

class PaymentDetail {
  PaymentDetail({
    @required this.id,
    @required this.transactionCode,
    @required this.status,
    @required this.totalPayment,
    @required this.bankName,
    @required this.accountName,
    @required this.accountNumber,
    @required this.orderName,
    @required this.orderDate,
    @required this.deliveryDate,
    @required this.orders,
    @required this.totalOngkir,
    @required this.subtotal,
    @required this.saldoDiscount,
    @required this.recipientName,
    @required this.recipientAddress,
  });

  final int id;
  final String transactionCode;
  final String status;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String orderName;
  final String orderDate;
  final String deliveryDate;
  final List<PaymentDetailOrder> orders;
  final String totalOngkir;
  final String subtotal;
  final String saldoDiscount;
  final String totalPayment;
  final String recipientName;
  final String recipientAddress;

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
        id: json["id"],
        transactionCode: json["transaction_code"],
        status: json["status"],
        bankName: json["bank_name"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        orderName: json["order_name"] ?? '-',
        orderDate: json["order_date"] ?? '-',
        deliveryDate: json["delivery_date"] ?? '-',
        orders: List<PaymentDetailOrder>.from(
            json["orders"].map((x) => PaymentDetailOrder.fromJson(x))),
        totalOngkir: json["total_ongkir"],
        subtotal: json["subtotal"],
        totalPayment: json["total_payment"],
        saldoDiscount: json["total_saldo"] == "-" || json["total_saldo"] == null
            ? null
            : json["total_saldo"],
        recipientName: json["recipient_name"],
        recipientAddress: json["recipient_address"],
      );
}

class PaymentDetailOrder {
  PaymentDetailOrder({
    @required this.id,
    @required this.sellerName,
    @required this.sellerAddress,
    @required this.note,
    @required this.items,
    @required this.ongkir,
    @required this.subtotal,
    @required this.totalPayment,
    @required this.courier,
    @required this.airwayBill,
    @required this.recipientAddress,
    @required this.hubAddress,
  });

  final int id;
  final String sellerName;
  final String sellerAddress;
  final String note;
  final List<PaymentDetailOrderItem> items;
  final String ongkir;
  final String subtotal;
  final String totalPayment;
  final String courier;
  final String airwayBill;
  final String recipientAddress;
  final String hubAddress;

  factory PaymentDetailOrder.fromJson(Map<String, dynamic> json) =>
      PaymentDetailOrder(
        id: json["id"],
        sellerName: json["seller_name"],
        sellerAddress: json["seller_address"],
        note: json["note"] ?? "",
        items: List<PaymentDetailOrderItem>.from(
            json["items"].map((x) => PaymentDetailOrderItem.fromJson(x))),
        ongkir: json["ongkir"],
        subtotal: json["subtotal"],
        totalPayment: json["total_payment"],
        courier: json["courier"],
        airwayBill: json["airway_bill"] ?? "-",
        recipientAddress: json["recipient_address"],
        hubAddress: json["hub_address"],
      );
}

class PaymentDetailOrderItem {
  PaymentDetailOrderItem({
    @required this.id,
    @required this.productName,
    @required this.productImage,
    @required this.productPrice,
    @required this.quantity,
    @required this.weight,
    @required this.totalPrice,
    @required this.variantName,
  });

  final int id;
  final String productName;
  final String productImage;
  final String productPrice;
  final int quantity;
  final String weight;
  final String totalPrice;
  final String variantName;

  factory PaymentDetailOrderItem.fromJson(Map<String, dynamic> json) =>
      PaymentDetailOrderItem(
        id: json["id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productPrice: json["product_price"],
        quantity: json["quantity"],
        weight: json["weight"],
        totalPrice: json["total_price"],
        variantName: json["variant_name"] ?? "",
      );
}

class PaymentMethod {
  PaymentMethod(
      {@required this.id,
      @required this.name,
      @required this.verificationMethod,
      @required this.accountNumber,
      @required this.accountName,
      @required this.handlingCost,
      @required this.slug,
      @required this.image});

  final int id;
  final String name;
  final String verificationMethod;
  final String accountNumber;
  final String accountName;
  final int handlingCost;
  final String slug;
  final String image;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        verificationMethod: json['verification_method'],
        accountName: json['account_name'],
        accountNumber: json['account_number'],
        handlingCost: json['handling_cost'],
        slug: json['slug'],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "verification_method": verificationMethod,
        "account_name": accountName,
        "account_number": accountNumber,
        "handling_cost": handlingCost,
        "slug": slug,
        "image": image,
      };
}
