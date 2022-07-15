class Organization {
  String id = '';
  String name;
  String legalName;
  String brandName;
  String tagLine;
  String smsLable;
  String smsConfig;
  String gstNumber;
  String orgType;
  String orgId;
  String accId;
  String website;
  String termOfService;
  String privacyPolicy;
  //String config;
  //String defaultAddressesId;
  // List<Address> addresses;
  // List<KeyValue> emails;
  // List<KeyValue> mobiles;
  // List<KeyValue> socialUrls;
  // List<KeyValue> tollfreeNo = [];
  // DateTime createdAt;
  // DateTime updatedAt;
  // List<KeyValue> limits;

  Organization(
      {
      required this.name,
      required this.legalName,
      required this.brandName,
      required this.tagLine,
      required this.smsLable,
      required this.smsConfig,
      required this.gstNumber,
      required this.orgType,
      required this.orgId,
      required this.accId,
      required this.website,
      required this.termOfService,
      required this.privacyPolicy,
      //required this.config,
      // required this.addresses,
      // required this.emails,
      // required this.mobiles,
      // required this.socialUrls,
      // required this.tollfreeNo,
      // required this.createdAt,
      // required this.updatedAt,
      // required this.limits,
      //required this.defaultAddressesId
      });
}
