import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/mainpower_screen/bloc/man_power_bloc.dart';
import 'package:in_setu/screens/mainpower_screen/delete_dialog/delete_dailogview.dart';
import 'package:in_setu/screens/mainpower_screen/manpower_loading_screen.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:in_setu/widgets/add_manpower_widget.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';

import '../project_list/model/AllSitesResponse.dart';

class ManpowerScreen extends StatefulWidget {
  final Data siteObject;

  const ManpowerScreen({super.key, required this.siteObject});

  @override
  _ManpowerScreenState createState() => _ManpowerScreenState();
}

class _ManpowerScreenState extends State<ManpowerScreen> {
  bool _isLoading = true;
  List<MainPowerData> manPowerDataList = [];
  List<AllDates> dateList = [];
  int currentPage = 0;
  late final PageController _pageController;
  String selectedDate = '';
  bool _isDateListLoaded = false;
  bool _initialDataHandled = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currentPage,
      viewportFraction: 1.0,
    );
    _fetchInitialData();
  }

  void _fetchInitialData() {
    setState(() {
      _isDateListLoaded = false;
      _isLoading = true;
    });
    context.read<ManPowerBloc>().add(
      ManPowerItemFetch(siteId: widget.siteObject.id!, currentDate: selectedDate),
    );
    if (selectedDate.isNotEmpty) {
      context.read<ManPowerBloc>().add(
        ManPowerFetchByDate(siteId: widget.siteObject.id!, selectedDate: selectedDate),
      );
    }
  }

  void _goToPreviousDate() {
    if (currentPage > 0) {
      currentPage--;
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _fetchDataForCurrentPage();
    }
  }

  void _goToNextDate() {
    if (currentPage < dateList.length - 1) {
      currentPage++;
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _fetchDataForCurrentPage();
    }
  }

  void _fetchDataForCurrentPage() {
    if (dateList.isNotEmpty) {
      selectedDate = dateList[currentPage].date ?? '';
      context.read<ManPowerBloc>().add(
        ManPowerFetchByDate(siteId: widget.siteObject.id, selectedDate: selectedDate),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawerItems(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AddManpowerWidget(
              siteObject: widget.siteObject,
              manPowerAdded:()=> _fetchInitialData(),
            ),
          );
        },
        tooltip: 'Add Requirements',
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child:BlocListener<ManPowerBloc, GlobalApiResponseState>(
          listener: (context, state) {
            switch (state.status) {
              case GlobalApiStatus.loading:
                setState(() => _isLoading = true);
                break;
              case GlobalApiStatus.completed:
                // setState(() => _isLoading = false);
                if (state is ManPowerStateSuccess && !_isDateListLoaded) {
                  setState(() {
                    _isLoading = false;
                  });
                  _isDateListLoaded = true;
                  dateList = state.data.allDates ?? [];
                  if (dateList.isNotEmpty && selectedDate.isEmpty) {
                    selectedDate = dateList[currentPage].date ?? '';
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _fetchDataForCurrentPage();
                    });
                  }
                } else if(state is ManPowerDateStateSuccess){
                    manPowerDataList = state.data.data ?? [];
                    setState(() {
                      _isLoading = false;
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
                setState(() {
                  _isLoading = false;
                });
            }
          },
          child: getManPowerView(),
        )
      ),
    );
  }


  Widget getManPowerView(){
    return Column(
      children: [
        if (dateList.isNotEmpty) _buildDateSelector(dateList),
        const SizedBox(height: 12),
        _isLoading ? ManpowerLoadingScreen() : Expanded(
          child: manPowerDataList.isEmpty
              ? const NoDataFound(noDataFoundTxt: "Man Power is not found")
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: manPowerDataList.length,
            itemBuilder: (context, index) {
              return _buildProjectCard(manPowerDataList[index]);
            },
          ),
        ),
      ],
    );
  }
  Widget _buildDateSelector(List<AllDates> dateList) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.colorLightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.colorGray),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _goToPreviousDate,
            child: Icon(Icons.chevron_left, color: Colors.grey[600]),
          ),
          Expanded(
            child: SizedBox(
              height: 30,
              child: PageView.builder(
                controller: _pageController,
                itemCount: dateList.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                  _fetchDataForCurrentPage();
                },
                itemBuilder: (context, index) {
                  final date = dateList[index];
                  return Center(
                    child: Text(
                      date.date ?? '',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        letterSpacing: 0.5,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: _goToNextDate,
            child: Icon(Icons.chevron_right, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(MainPowerData project) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildProjectHeader(project), _buildProjectContent(project)],
      ),
    );
  }

  Widget _buildProjectHeader(MainPowerData project) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 228, 228),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              *//*color: Colors.amber,*//*
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.work_outline, color: Colors.white, size: 15),
          ),
          const SizedBox(width: 16),*/
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Expanded(
              child: Text(
                project.agencyName ?? '',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[800],
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),
          Row(
            children: [
              _buildActionButton(Icons.content_copy, Colors.blue, 100, project),
              const SizedBox(width: 12),
              _buildActionButton(Icons.edit, Colors.purple, 200, project),
              const SizedBox(width: 12),
              _buildActionButton(Icons.delete_forever, Colors.red, 300, project),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, int id, MainPowerData project) {
    return GestureDetector(
      onTap: () async {
        if (id == 200) {
          showDialog(
            context: context,
            builder: (context) => AddManpowerWidget(
              siteObject: widget.siteObject,
              manPowerAdded:()=> _fetchInitialData(),
              existingManPower: project,
            ),
          );
        } else if (id == 300) {
          final delete = await DeleteDialog.showDeleteManPowerDialog(
            context,
            "Delete Manpower?",
            "Are you sure you want to delete this manpower entry?",
            project.id,
          );
          if (delete) {
            _fetchInitialData();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _buildProjectContent(MainPowerData project) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Staff:-',
            project.staffs!
                .asMap()
                .entries
                .map((s) => _buildStaffItem(s.value, s.key))
                .toList(),
          ),
          const SizedBox(height: 2),
          _buildSection(
            'Manpower:-',
            project.manpowers!
                .asMap()
                .entries
                .map((m) => _buildManpowerItem(m.value, m.key))
                .toList(),
          ),
          const SizedBox(height: 2),
          _buildSection(
            'Task:-',
            project.tasks!
                .asMap()
                .entries
                .map((t) => _buildTaskItem(t.value, t.key))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 2),
        ...items,
      ],
    );
  }

  Widget _buildStaffItem(Staffs staff, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        /*color: Colors.blue[50],*/
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          /*Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),*/
          Text(
            "${index + 1}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              staff.memberName ?? '',
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${staff.memberCount}',
              style: const TextStyle(
                color: AppColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManpowerItem(Manpowers manpower, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
       /* color: Colors.orange[50],*/
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
         /* Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.groups, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),*/
          Text(
            "${index + 1}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              manpower.memberName ?? '',
              style:  TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${manpower.memberCount}',
              style: const TextStyle(
                color: AppColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Tasks task, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        /*color: Colors.green[50],*/
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
           /* Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.task_alt, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),*/
            Text(
              "${index + 1}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                task.taskName ?? '',
                style:  TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}