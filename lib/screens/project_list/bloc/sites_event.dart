part of 'sites_bloc.dart';

abstract class AllSitesEvent {
  const AllSitesEvent();
}

class GetAllSites extends AllSitesEvent{
  GetAllSites();
}
class CreateSiteProject extends AllSitesEvent{
  String siteName;
  String siteLocation;
  String companyName;
  dynamic image;
  // String image;

  CreateSiteProject({required this.siteName,required this.siteLocation,required this.companyName,required this.image});
}
class SiteDelete extends AllSitesEvent{
  final dynamic userId;
  SiteDelete(this.userId);
}

class SiteProjectUpdate extends AllSitesEvent{
  final dynamic userId;
  String siteName;
  String siteLocation;
  String companyName;
  dynamic image;
  SiteProjectUpdate(this.userId,this.siteName,this.siteLocation,this.companyName,this.image);
}
