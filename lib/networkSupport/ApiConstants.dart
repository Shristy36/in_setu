class UatCreds {
  // static String baseUrl = "http://172.16.55.3:9091/";
  // static String baseUrl = "http://103.198.9.222:11111/";

  // static String baseUrl = "http://172.16.55.186:8080/";
  // static String clientId = "VBMRDWEVFV";
  // static String clientSecret = "199204";


  //chandragiri data
  // static String baseUrl = "http://172.16.56.67:8080/";
  static String baseUrl = "http://103.198.9.222:8080/";
  // static String baseUrl = "https://103.198.9.222:8080/";
  static String clientId = "JGUPGKBN2M";
  static String clientSecret = "205249";
}


class ApiConstants {
  static const bool isProductionMode = true;
  static String grantType = "grant_type";
  static String bannerImage = "get/bannerimage";
  static String footerImage = "get/footerimages";
  static String oAuthUrl = "oauth/token";
  static String customerDetails = "api/customerdetails";
  static String category = "api/category";
  static String bankingServices = "/appServiceManagement/appServices/bank/app";
  static String accounts = "api/accounts";
  static String topUp = "api/topup";
  static String getBeneficiary = "api/getbeneficiary";
  static String addBeneficiary = "api/addcustomerbeneficiary";
  static String updatedBeneficiary = "api/editcustomerbeneficiary";
  static String deleteBeneficiary = "api/deletecustomerbeneficiary";
  static String bankBranches = "get/bankbranches";
  static String accountValidation = "api/account/validation";
  static String requestOtp = "api/otp/request";
  static String fundTransferPay = "api/fundtransfer";
  static String amountLimit = "api/limit";
  static String loadFundBankList = "api/load_from_bank";
  static String bankList = "api/ips/bank";
  static String ipsCharge = "api/ips/scheme/charge";

  static String coopContactDetail = "appcontactdetail/get/";
  static String profileImageUpload = "api/profilePicture/upload";
  static String forex = "get/forex";
  static String coopBranchDetails = "get/bankbranches";
  static String coopCalendarPdf = "mbank/calendar";
  static String getEvents = "api/offerCarousel/fetchAll";
  static String getsTransactionAnalytics = "api/transactionDetailsByType";
  static String miniStatement = "api/ministatement";
  static String fullStatement = "api/accountStatement";
  static String offerAndServices = "get/serviceapp";
  static String revenueDetails = "api/governmentpayment/revenueDetail";
  static String qrMerchantLists = "get/qPayMerchantDetails";
  static String dataPackPackage = "api/data_pack/packages"; //params: "service_identifier"
  static String dataPackPay = "api/data_pack/pay"; //params:  service_identifier account_number phone_number amount mPin
  static String feedbackSuggestion = "api/addSuggestionBox";
  static String feedbackSubmitContactUs = "submitcontactus";
  static String serviceApp = "get/serviceapp"; // header client = clientId;
  static String loadApp = "get/loanapp";
  static String productApp = "get/productapp";
  static String getPdf = "api/gettransactionreceiptpdf";
  static String cashback = "api/cashback/get";
  static String loadWallet = "api/wallet/list";
  static String transactionHistory = "api/transactionhistory";
  static String recentTransaction = "api/recentTransaction";
  static String otpRequest = "/api/otp/request";
  static String ipsTransfer = "api/ips/transfer";
  static String loadWalletValidations = "api/walletvalidate";
  static String loadWalletPayment = "api/wallet/load";
  static String qrPay = "api/qr/pay"; // e-teller qr
  static String qPayPayment = "api/qpay/payment"; // regular qr payment
  static String qPayPaymentMerchantDetails = "api/qpay/merchant_detail";

  static String getLoadFundDetails = "api/load_from_bank/details";
  static String getLoadFundUrl = "api/load_from_bank/payment";
  static String getLoadFundConnectIpsUrl = "api/load_from_connectips/payment";
  static String getLoadFundUrlConectIps = "api/load_from_connectips/payment";
  static String getServiceCharge = "api/services/charge/get";
  static String getKhanepaniBill = "api/getkhanepanibill";
  static String getKhanepaniCounter = "get/khanepanicounters";
  static String khanepaniPayment = "api/khanepanipay";
  static String brokerPayment = "api/broker/payment";
  static String getBrokerList = "api/broker/list";
  static String getBrokerCharge = "api/broker/charge";
  static String getBusSewaRoutes = "api/busSewa/getRoutes";
  static String getBusSewaTrips = "api/busSewa/getTrips";
  static String getBusSewaSeatBooking = "api/busSewa/booking";
  static String payBusSewa = "api/busSewa/payment";

  static String getDistrict = "api/districtName";

  static String customerResetSend = "/customer/reset/send"; //request otp on forgot password
  static String customerResetVerify = "/customer/reset/verify"; //verify otp on forgot password
  static String customerResetSetPin = "/customer/reset/setPin"; //set new mPin

  static String neaCounters = "get/neaofficecode";
  static String neaBill = "api/getneabill";
  static String neaPay = "api/neapay";

  static String airlinesNationality = "/api/arsnationality";
  static String airlinesLocation = "/api/arssectorcode";
  static String airlinesFlightAvailability = "/api/arsflightavailability";
  static String airlinesFlightReserve = "/api/arsflightreservation";
  static String bookFlight = "/api/arsissueticket";
  static String cableCarDetails = "/api/getCableCarDetails";

  static String airlinesImageEndpoint = "mbank/airlinesPdfUrl/";

  //GenericRemittance
  static String getRemittanceServiceProvider = "api/remittanceServiceProviders";
  static String getRemittanceReceiveDetails = "api/remit-receive/pay-txn-check";
  static String getGenericRemittanceIdDescription = "api/remit-receive/get-id-description";
  static String getGenericRemittanceOccupation = "api/remit-receive/get-occupation-list";
  static String payGenericRemittanceConfirm = "api/remit-receive/pay-confirm-transaction";
  //Ime Remittance
  static String getImeRemittanceReceiveDetails = "api/imeremittance/search-pay-transaction";
}

