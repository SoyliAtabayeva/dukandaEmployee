import 'dart:ui';

class User {
  String token;
  String? role;
  String userName;
  String fullName;
  Image? image;
  bool qrClientCardShareAccess;
  bool syncAccess;
  bool productAnalyzeAccess;
  AccessibleDivisions? accessibleDivisions;
  User(
      {required this.token,
      this.role,
      required this.userName,
      required this.fullName,
      this.image,
      required this.qrClientCardShareAccess,
      required this.syncAccess,
      required this.productAnalyzeAccess,
      this.accessibleDivisions});
}

class AccessibleDivisions {
  int nr;
  String name;
  AccessibleDivisions(this.nr, this.name);
}

class Product {
  String? status;
  int? id;
  String? code;
  String? eCode;
  String? name;
  String? currency;
  String? brand;
  String? mediumImg;
  String? smallImg;
  int? countOfComplect;
  String? nameTm;
  String? nameRu;
  String? mainUnit;
  String? paretto;
  String? unit;
  String? brandImg;
  String? mainGroup;
  String? lastGroup;
  String? info;
  String? vidio;
  String? bigImg;
  int? discount;
  String? discountType;
  num? discountPrice;
  int? unitCount;
  Stocks? stocks;
  num? price;

  bool? eActive;
  bool? active;
  bool? isNew;
  String? specode;
  List<Images>? images;
  Product(
      {this.currency,
      this.status,
      this.id,
      this.code,
      this.eCode,
      this.name,
      this.nameTm,
      this.nameRu,
      this.mainUnit,
      this.paretto,
      this.eActive,
      this.active,
      this.isNew,
      this.specode,
      this.bigImg,
      this.brand,
      this.countOfComplect,
      this.discount,
      this.images,
      this.brandImg,
      this.discountPrice,
      this.discountType,
      this.info,
      this.lastGroup,
      this.mainGroup,
      this.mediumImg,
      this.smallImg,
      this.stocks,
      this.unit,
      this.unitCount,
      this.vidio,
      this.price});
}

class Images {
  int? id;
  String? normal;
  String? bigImg;
  String? mediumImg;
  String? smallImg;
  bool? mainImage;
  Images(
      {this.id,
      this.normal,
      this.bigImg,
      this.mediumImg,
      this.smallImg,
      this.mainImage});

  Images.fromJson(Map<String, dynamic> json) {
    Images(
      id: json['id'] as int,
      normal: json['normal'] as String,
      bigImg: json['bigImg'] as String,
      mediumImg: json['mediumImg'] as String,
      smallImg: json['smallImg'] as String,
      mainImage: json['mainImg'] as bool,
    );
  }
}

class Stocks {
  List<Real>? real;
  List<Real>? unreal;
  int? lastFullSyncTime;
  int? onlyChangedSyncTime;
  Stocks({
    this.real,
    this.unreal,
    this.lastFullSyncTime,
    this.onlyChangedSyncTime,
  });
  Stocks.fromJson(Map<String, dynamic> json) {
    real = json['real'];
    unreal = json['unreal'];
    lastFullSyncTime = json[41456];
    onlyChangedSyncTime = json[1277];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['real'] = real;
    data['unreal'] = unreal;

    data['lastFullSyncTime'] = lastFullSyncTime;

    data['onlyChangedSyncTime'] = onlyChangedSyncTime;

    return data;
  }
}

class Real {
  String name;
  int nr;
  num onhand;
  int reserved;
  String permissionType;         
  int priority;
  String? createdAt;
  String? updatedAt;
  Real(
      {required this.name,
      required this.nr,
      required this.onhand,
      required this.reserved,
      required this.permissionType,
      required this.priority,
      required this.createdAt,
      required this.updatedAt});
}
