class EarningsModel {
  String? earningId;
  String? totalEarnings;
  String? sellerName;
  String? earningFrom;

  EarningsModel({
    this.earningId,
    this.totalEarnings,
    this.sellerName,
  });
  EarningsModel.fromMap(Map<String, dynamic> map) {
    earningId = map['earningId'];
    totalEarnings = map['totalEarnings'];
    sellerName = map['sellerName'];
    earningFrom = map['earningFrom'];
  }
  Map<String, dynamic> toMap() {
    return {
      'earningId': earningId,
      'totalEarnings': totalEarnings,
      'sellerName': sellerName,
      'earningFrom': earningFrom,
    };
  }
}
