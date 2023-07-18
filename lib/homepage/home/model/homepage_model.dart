//Root
class Homepagemodel {
  bool status;
  List<dynamic> data;

  Homepagemodel({required this.status, required this.data});

  factory Homepagemodel.fromJson(Map<String, dynamic> json) {
    return Homepagemodel(
      status: json["status"],
      data: List<dynamic>.from(json["data"]),
    );
  }
}

//detail

class Userdetails {
  String type;
  UserDetailsData data;

  Userdetails({required this.type, required this.data});

  factory Userdetails.fromJson(Map<String, dynamic> json) {
    return Userdetails(
        type: json["type"], data: UserDetailsData.fromJson(json["data"]));
  }
}

class UserDetailsData {
  String firstname;
  String avatar;
  int notification;
  int kycverified;
  String greeting;
  String placeholder;
  String residencetype;
  String statusofresidence;
  int profiletype;
  bool ismpinset;
  bool mpinexpired;

  UserDetailsData({
    required this.firstname,
    required this.avatar,
    required this.notification,
    required this.kycverified,
    required this.greeting,
    required this.placeholder,
    required this.residencetype,
    required this.statusofresidence,
    required this.profiletype,
    required this.ismpinset,
    required this.mpinexpired,
  });

  factory UserDetailsData.fromJson(Map<String, dynamic> json) {
    return UserDetailsData(
        firstname: json["first_name"],
        avatar: json["avator"],
        notification: json["notification"],
        kycverified: json["is_kyc_verified"],
        greeting: json["greeting"],
        placeholder: json["place_holder"],
        residencetype: json["residence_type"],
        statusofresidence: json["status_of_residence"],
        profiletype: json["profile_type"],
        ismpinset: json["is_mpin_set"],
        mpinexpired: json["mpin_expired"]);
  }
  Map<String, dynamic> toJson() => {
        "first_name": firstname,
        "avator": avatar,
        "notification": notification,
        "is_kyc_verified": kycverified,
        "greeting": greeting,
        "place_holder": placeholder,
        "residence_type": residencetype,
        "status_of_residence": statusofresidence,
        "profile_type": profiletype,
        "is_mpin_set": ismpinset,
        "mpin_expired": mpinexpired,
      };
}

//services
class Services {
  String type;
  List<ServicesList> data;
  Services({required this.type, required this.data});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
        type: json["type"],
        data: List<ServicesList>.from(
            json["data"].map((element) => ServicesList.fromJson(element))));
  }
  Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data.map((element) => element.toJson())),
      };
}

class ServicesList {
  String name;
  String namejp;
  String image;
  String slug;

  ServicesList(
      {required this.name,
      required this.namejp,
      required this.image,
      required this.slug});

  factory ServicesList.fromJson(Map<String, dynamic> json) {
    return ServicesList(
        name: json["name"],
        namejp: json["name_jp"],
        image: json["image"],
        slug: json["slug"]);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "name_jp": namejp,
        "image": image,
        "slug": slug,
      };
}

//Quicksend
class Quicksend {
  String type;
  List<Quicksendlist> data;

  Quicksend({required this.type, required this.data});

  factory Quicksend.fromJson(Map<String, dynamic> json) {
    return Quicksend(
      type: json["type"],
      data: List<Quicksendlist>.from(
          json["data"].map((element) => Quicksendlist.fromJson(element))),
    );
  }
}

//Quicksendlist
class Quicksendlist {
  String name;
  String namejp;
  String image;
  String slug;
  String? placeholder;
  String nationality;
  ReceivingMethods recevingmethods;

  Quicksendlist({
    required this.name,
    required this.namejp,
    required this.image,
    required this.slug,
    this.placeholder,
    required this.nationality,
    required this.recevingmethods,
  });
  factory Quicksendlist.fromJson(Map<String, dynamic> json) {
    return Quicksendlist(
        name: json["name"],
        namejp: json["name_jp"],
        image: json["image"],
        slug: json["slug"],
        placeholder: json["place_holder"],
        nationality: json["nationality"],
        recevingmethods: ReceivingMethods.fromJson(json["receiving_methods"]));
  }
}

//receviving method
class ReceivingMethods {
  List<Bank> bank;
  List<Wallet> wallet;

  ReceivingMethods({required this.bank, required this.wallet});

  factory ReceivingMethods.fromJson(Map<String, dynamic> json) {
    return ReceivingMethods(
        bank: json["banks"] != null
            ? List<Bank>.from(
                json["banks"].map((element) => Bank.fromJson(element)))
            : [],
        wallet: json["wallet"] != null
            ? List<Wallet>.from(
                json["wallet"].map((element) => Wallet.fromJson(element)))
            : []);
  }
}

class Bank {
  String image;
  String name;
  String accountnumber;
  String type;

  Bank(
      {required this.image,
      required this.name,
      required this.accountnumber,
      required this.type});
  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        image: json["image"],
        name: json["name"],
        accountnumber: json["account_number"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "account_number": accountnumber,
        "type": type,
      };
}

class Wallet {
  String image;
  String name;
  String walletId;
  String type;
  Wallet(
      {required this.image,
      required this.name,
      required this.walletId,
      required this.type});

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        image: json["image"],
        name: json["name"],
        walletId: json["wallet_id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "wallet_id": walletId,
        "type": type,
      };
}

//transaction

class Transaction {
  String type;
  List<TransactionList> data;

  Transaction({
    required this.type,
    required this.data,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        type: json["type"],
        data: List<TransactionList>.from(
            json["data"].map((element) => TransactionList.fromJson(element))));
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TransactionList {
  int id;
  String userEmail;
  String userFirstName;
  String userLastName;
  String amount;
  String? currency;
  String? referenceId;
  String? transactionId;
  int status;
  int typeStatus;
  String transactionStatus;
  String? transactionFor;
  String remarks;
  DateTime createdAt;
  DateTime updatedAt;
  String? userAgent;
  String? requestIp;
  String placeholder;
  String name;
  String nationality;
  String? image;
  String type;

  TransactionList({
    required this.id,
    required this.userEmail,
    required this.userFirstName,
    required this.userLastName,
    required this.amount,
    this.currency,
    this.referenceId,
    this.transactionId,
    required this.status,
    required this.typeStatus,
    required this.transactionStatus,
    this.transactionFor,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
    this.userAgent,
    this.requestIp,
    required this.placeholder,
    required this.name,
    required this.nationality,
    this.image,
    required this.type,
  });

  factory TransactionList.fromJson(Map<String, dynamic> json) {
    return TransactionList(
      id: json["id"],
      userEmail: json["user_email"],
      userFirstName: json["user_first_name"],
      userLastName: json["user_last_name"],
      amount: json["amount"],
      currency: json["currency"],
      referenceId: json["reference_id"],
      transactionId: json["transaction_id"],
      status: json["status"],
      typeStatus: json["type_status"],
      transactionStatus: json["transaction_status"],
      transactionFor: json["transaction_for"],
      remarks: json["remarks"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      userAgent: json["user_agent"],
      requestIp: json["request_ip"],
      placeholder: json["placeholder"],
      name: json["name"],
      nationality: json["nationality"],
      image: json["image"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_email": userEmail,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "amount": amount,
        "currency": currency,
        "reference_id": referenceId,
        "transaction_id": transactionId,
        "status": status,
        "type_status": typeStatus,
        "transaction_status": transactionStatus,
        "transaction_for": transactionFor,
        "remarks": remarks,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_agent": userAgent,
        "request_ip": requestIp,
        "placeholder": placeholder,
        "name": name,
        "nationality": nationality,
        "image": image,
        "type": type,
      };
}
