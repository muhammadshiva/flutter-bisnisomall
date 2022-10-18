import 'package:marketplace/data/models/models.dart';

class WalletHistoryResponse {
  WalletHistoryResponse({
    this.message,
    this.data,
  });

  String message;
  List<WalletHistory> data;

  factory WalletHistoryResponse.fromJson(Map<String, dynamic> json) =>
      WalletHistoryResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : json["data"].length == 0
                ? []
                : List<WalletHistory>.from(
                    json["data"].map((x) => WalletHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}

class WalletHistory {
  int id;
  String type;
  String amount;
  String title;
  String date;

  WalletHistory({
    this.id,
    this.type,
    this.amount,
    this.title,
    this.date,
  });

  factory WalletHistory.fromJson(Map<String, dynamic> json) {
    return WalletHistory(
      id: json['id'],
      type: json['type'],
      amount: json['amount'],
      title: json['title'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'title': title,
      'date': date,
    };
  }
}

class WalletNonWithdrawalDetailResponse {
  WalletNonWithdrawalDetailResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  WalletHistoryDetailNonWithdrawal data;

  factory WalletNonWithdrawalDetailResponse.fromJson(Map<String, dynamic> json) =>
      WalletNonWithdrawalDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : WalletHistoryDetailNonWithdrawal.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class WalletHistoryDetailNonWithdrawal {
  WalletHistoryDetailNonWithdrawal({
    this.id,
    this.type,
    this.amount,
    this.date,
    this.productName,
    this.productPrice,
    this.productCover,
    this.orderDate,
    this.quantity,
    this.priceCommission,
    this.totalPrice,
  });

  int id;
  String type;
  String amount;
  String date;
  String productName;
  String productPrice;
  String productCover;
  String orderDate;
  String quantity;
  String priceCommission;
  String totalPrice;

  factory WalletHistoryDetailNonWithdrawal.fromJson(Map<String, dynamic> json) =>
      WalletHistoryDetailNonWithdrawal(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        date: json["date"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productCover: json["product_cover"],
        orderDate: json["order_date"],
        quantity: json["quantity"].runtimeType == int ? json["quantity"].toString() : json["quantity"] ?? null,
        priceCommission: json["product_commission"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "date": date,
        "product_name": productName,
        "product_price": productPrice,
        "product_cover": productCover,
        "order_date": orderDate,
        "quantity": quantity,
        "product_commission":priceCommission,
        "total_price": totalPrice
      };
}

class WalletWithdrawalDetailResponse {
  WalletWithdrawalDetailResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  WalletHistoryDetailWithdrawal data;

  factory WalletWithdrawalDetailResponse.fromJson(Map<String, dynamic> json) =>
      WalletWithdrawalDetailResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : WalletHistoryDetailWithdrawal.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class WalletHistoryDetailWithdrawal {
  WalletHistoryDetailWithdrawal({
    this.id,
    this.type,
    this.amount,
    this.date,
    this.accountNumber,
    this.accountName,
    this.paymentMethod,
    this.status,
  });

  int id;
  String type;
  String amount;
  String date;
  String accountNumber;
  String accountName;
  String paymentMethod;
  String status;

  factory WalletHistoryDetailWithdrawal.fromJson(Map<String, dynamic> json) =>
      WalletHistoryDetailWithdrawal(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        date: json["date"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        paymentMethod: json["payment_method"],
        status: json["status"],
    
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "date": date,
        "account_number": accountNumber,
        "account_name": accountName,
        "payment_method": paymentMethod,
        "status": status,
      };
}

class WalletWithdrawData {
  final int logId;
  final int saldo, noRek;
  final PaymentMethod paymentMethod;
  final String atasNama;

  WalletWithdrawData({this.saldo, this.noRek, this.paymentMethod, this.atasNama, this.logId});
}

class WalletWithdrawResponse {
  WalletWithdrawResponse({
    this.message,
    this.data,
  });

  String message;
  WalletWithdrawResponseData data;

  factory WalletWithdrawResponse.fromJson(Map<String, dynamic> json) =>
      WalletWithdrawResponse(
        message: json["message"],
        data: json["data"] == null
            ? null
            : WalletWithdrawResponseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data,
      };
}

class WalletWithdrawResponseData {
  WalletWithdrawResponseData({
    this.logId,
  });

  int logId;

  factory WalletWithdrawResponseData.fromJson(Map<String, dynamic> json) =>
      WalletWithdrawResponseData(logId: json['id']);

  Map<String, dynamic> toJson() => {
        "id": logId,
      };
}

class WalletWithdrawRuleResponse {
  WalletWithdrawRuleResponse({
    this.message,
    this.data,
  });

  String message;
  List<WalletWithdrawRule> data;

  factory WalletWithdrawRuleResponse.fromJson(Map<String, dynamic> json) =>
      WalletWithdrawRuleResponse(
        message: json["message"],
        data: json["data"] == null
            ? []
            : json["data"].length == 0
                ? []
                : List<WalletWithdrawRule>.from(
                    json["data"].map((x) => WalletWithdrawRule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}

class WalletWithdrawRule {
  WalletWithdrawRule({
    this.minWithdraw,
  });

  int minWithdraw;

  factory WalletWithdrawRule.fromJson(Map<String, dynamic> json) =>
      WalletWithdrawRule(minWithdraw: json['minimum_withdraw']);

  Map<String, dynamic> toJson() => {
        "minimum_withdraw": minWithdraw,
      };
}

//Model response pembayaran memakai saldo panen
class WalletPaymentResponse {
  WalletPaymentResponse({
    this.message,
    this.data,
  });

  String message;
  WalletPayment data;

  factory WalletPaymentResponse.fromJson(Map<String, dynamic> json) =>
      WalletPaymentResponse(
        message: json["message"],
        data: json["data"] == null
            ? null
            : WalletPayment.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data};
}

class WalletPayment {
  WalletPayment({
        this.id,
        this.type,
        this.amount,
        this.date,
        this.name,
        this.paymentMethod,
        this.accountNumber,
        this.accountName,
        this.confirmationCode,
        this.token,
        this.status,
  });

    int id;
    String type;
    String amount;
    String date;
    String name;
    String paymentMethod;
    String accountNumber;
    String accountName;
    String confirmationCode;
    String token;
    String status;

  factory WalletPayment.fromJson(Map<String, dynamic> json) =>
      WalletPayment(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        date: json["date"],
        name: json["name"],
        paymentMethod: json["payment_method"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        confirmationCode: json["confirmation_code"],
        token: json["token"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "date": date,
        "name": name,
        "payment_method": paymentMethod,
        "account_number": accountNumber,
        "account_name": accountName,
        "confirmation_code": confirmationCode,
        "token": token,
        "status": status,
    };
}



