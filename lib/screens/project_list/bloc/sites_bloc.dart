import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:in_setu/networkSupport/base/ApiResult.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/supports/AppException.dart';
import 'package:in_setu/screens/project_list/model/CreateSiteResponse.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart';
import 'package:in_setu/screens/project_list/model/SiteDeleteResponse.dart';
import 'package:in_setu/screens/project_list/model/SiteUpdateResponse.dart';
import 'package:in_setu/screens/project_list/repository/all_sites_repository.dart';
import 'package:meta/meta.dart';

part 'sites_event.dart';

part 'sites_state.dart';

class SitesBloc extends Bloc<AllSitesEvent, GlobalApiResponseState> {
  AllSitesRepository sitesRepository;

  SitesBloc({required this.sitesRepository}) : super(const InitialState()) {
    on<GetAllSites>(getAllSite);
    on<CreateSiteProject>(createSiteProject);
    on<SiteDelete>(siteDeleteItem);
    on<SiteProjectUpdate>(siteProjectUpdateItem);
  }

  getAllSite(
    AllSitesEvent event,
    Emitter<GlobalApiResponseState> emitter,
  ) async {
    if (event is GetAllSites) {
      emitter(const ApiLoadingState());
      try {
        ApiResult<AllSitesResponse> sitesResponse =
            await sitesRepository.getAllSites();
        sitesResponse.when(
          success:
              (AllSitesResponse allSitesResponse) =>
                  emitter(AllSiteStateSuccess(data: allSitesResponse)),
          failure: (AppException ex) => emitter(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  createSiteProject(
    AllSitesEvent event,
    Emitter<GlobalApiResponseState> emitter,
  ) async {
    if (event is CreateSiteProject) {
      emitter(const ApiLoadingState());
      final bodyParams = {
        "form_data": {
          "site_name": event.siteName,
          "site_location": event.siteLocation,
          "company_name": event.companyName,
          "site_image": event.image,
        },
      };
      try {
        ApiResult<CreateSiteResponse> sitesResponse = await sitesRepository.createSiteProject(bodyParams);
        sitesResponse.when(
          success: (CreateSiteResponse createSiteResponse) => emitter(SitesCreateStateSuccess(data: createSiteResponse)),
          failure: (AppException ex) => emitter(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }

  siteDeleteItem(
    AllSitesEvent event,
    Emitter<GlobalApiResponseState> emitter,
  ) async {
    if (event is SiteDelete) {
      emitter(const ApiLoadingState());
      try {
        ApiResult<SiteDeleteResponse> sitesResponse = await sitesRepository
            .deleteSiteItemResponse(event.userId);
        sitesResponse.when(
          success:
              (SiteDeleteResponse siteDeleteResponse) =>
                  emitter(SiteDeleteStateSuccess(data: siteDeleteResponse)),
          failure: (AppException ex) => emitter(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
  siteProjectUpdateItem(AllSitesEvent event, Emitter<GlobalApiResponseState> emitter) async {
    if (event is SiteProjectUpdate) {
      emitter(const ApiLoadingState());
      final bodyParams = {
        "form_data": {
          "site_name": event.siteName,
          "site_location": event.siteLocation,
          "company_name": event.companyName,
          "site_image": event.image,
        },
      };
      try {
        ApiResult<SiteUpdateResponse> siteUpdateResponse = await sitesRepository.siteProjectUpdateItem(event.userId, bodyParams);
        siteUpdateResponse.when(
          success:(SiteUpdateResponse updateResponse) => emitter(SiteUpdateStateSuccess(data: updateResponse)),
          failure: (AppException ex) => emitter(ApiErrorState(exception: ex)),
        );
      } on AppException catch (e) {
        emitter(ApiErrorState(exception: e));
      }
    }
  }
}
