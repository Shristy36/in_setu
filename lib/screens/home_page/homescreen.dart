import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/constants/app_colors.dart';

import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/home_page/bloc/home_bloc.dart';
import 'package:in_setu/screens/home_page/dashboard_screen.dart';
import 'package:in_setu/screens/home_page/loading_screen/dashboard_loading_screen.dart';
import 'package:in_setu/screens/home_page/model/DashBoardResponse.dart';
import 'package:in_setu/screens/home_page/time_line_screen.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/project_list/model/AllSitesResponse.dart'
    hide UserData;
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final Data siteObject;
  final User user;
  final Function(bool)? onScrollDirectionChanged;
  final VoidCallback? openDrawer;

  const HomeScreen({
    super.key,
    required this.siteObject,
    required this.user,
    this.onScrollDirectionChanged,
    this.openDrawer,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<Feed> feeds = [];
  UserData? userData;
  DashboardResponse? dashboardResponse;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (widget.onScrollDirectionChanged != null) {
        if (direction == ScrollDirection.reverse) {
          widget.onScrollDirectionChanged!(false); // hide bottom nav
        } else if (direction == ScrollDirection.forward) {
          widget.onScrollDirectionChanged!(true); // show bottom nav
        }
      }
    });
    context.read<HomeBloc>().add(GetDashBoardApi(widget.siteObject.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawerItems(context),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocListener<HomeBloc, GlobalApiResponseState>(
          listener: (context, state) {
            switch (state.status) {
              case GlobalApiStatus.loading:
                setState(() => _isLoading = true);
                break;
              case GlobalApiStatus.completed:
                if (state is HomeStateSuccess) {
                  dashboardResponse = state.data as DashboardResponse;
                  setState(() {
                    _isLoading = false;
                    feeds = dashboardResponse!.feeds;
                    userData = dashboardResponse!.userData;
                  });
                }
                break;
              case GlobalApiStatus.error:
                setState(() => _isLoading = false);
                ErrorHandler.errorHandle(
                  state.message,
                  "Something wrong",
                  context,
                );
                break;
              default:
                setState(() => _isLoading = false);
            }
          },
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (context, innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: APPBarWidget(
                        isSiteNameVisible: true,
                        user: widget.user,
                        siteName: widget.siteObject.siteName!,
                        siteId: widget.siteObject.id!,
                        openDrawer: widget.openDrawer,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    SliverToBoxAdapter(child: _buildTabBar()),
                  ],
              body:
                  _isLoading
                      ? const DashboardLoadingScreen()
                      : TabBarView(
                        controller: _tabController,
                        children: [
                          DashboardScreen(
                            dashboardResponse: dashboardResponse!,
                            scrollController: _scrollController,
                            siteObject: widget.siteObject,
                            user: widget.user,
                          ),
                          TimeLineScreen(feeds: feeds, userData: userData),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        dividerColor: Colors.white,
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.tabBarColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.colorBlack,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        isScrollable: false,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [Tab(text: 'Dashboard'), Tab(text: 'Timeline')],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
