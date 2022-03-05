// PEoT = Person Entity or Thing

class PEoT {
  String peotAtsign;
  String peotUuid;
  bool shareBPM;
  bool shareHrO2;

  PEoT(
      {required this.peotAtsign,
      required this.peotUuid,
      this.shareBPM = false,
      this.shareHrO2 = false});

  PEoT.fromJson(Map<String, dynamic> json)
      : peotAtsign = json['peotAtsign'],
        peotUuid = json['peotUuid'],
        shareBPM = json['shareBPM'],
        shareHrO2 = json['shareHrO2'];

  Map<String, dynamic> toJson() => {
    'peotAtsign': peotAtsign,
    'peotUuid' : peotUuid,
    'shareBPM' : shareBPM,
    'shareHrO2' : shareHrO2
  };
}
