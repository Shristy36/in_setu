class ApiConstants {
  static const bool isProductionMode = true;
  static String baseUrl = "https://builder.webinovator.com/";

  static String authUrl = "api/auth/login";
  static String registerEndPoint = "/api/auth/register";
  static String signUpEndPoint = "/api/auth/authenticate";
  static String requestResetEndPoint = "/api/auth/request-reset";

  static String getAllSites = "api/members/sites/get_all";
  static String dashBoardApi = "api/members/home/site_dashboard/";
  static String siteTeamMemberEndPoint = "api/members/sites/get_all_site_members";
  static String addSiteTeamMemberEndPoint = "api/members/sites/add_site_members";
  static String makeAdminSiteMemberEndPoint = "/api/members/sites/manage_team";

  static String createSiteEndPoint = "api/members/sites/create";
  static String siteDeleteEndPoint = "api/members/sites/";
  static String siteUpdateEndPoint = "api/members/sites/update/";
  static String userProfileEndPoint = "api/members/user/get_me";
  static String chatsConversationEndPoint = "/api/members/chats/conversations";
  static String manPowerItemEndPoint = "api/members/manpower/get_all";
  static String createManPowerItemEndPoint = "api/members/manpower/create";
  static String deleteManPowerItemEndPoint = "api/members/manpower/";
  static String updateManPowerItemEndPoint = "api/members/manpower/";
  static String materialStockDetailsEndPoint = "api/members/materials/get_all";
  static String deleteIntentEndPoint = "/api/members/materials/intents/";

  static String deleteStockEndPoint = "/api/members/materials/stocks/";
  static String createStockEndPoint = "api/members/materials/create_stock";
  static String updateStockEndPoint = "/api/members/materials/stocks_update/";
  static String searchMaterialEndPoint = "api/members/materials/search_keyword";
  static String searchUnitEndPoint = "api/members/materials/search_keyword";

  static String cashbookCreateEndPoint = "/api/members/cashbook/create";
  static String cashbookDeleteEndPoint = "/api/members/cashbook/";
  static String cashBookDetailsEndPoint = "api/members/cashbook/get_all";
  static String updateCashBookEndPoint = "/api/members/cashbook/";
  static String setDefaultValueBookEndPoint = "/api/members/cashbook/setDefault/";
  static String addTransactionEndPoint = "/api/members/cashbook/add_transactions";

}

