import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/views/material_screen.dart';
import 'package:in_setu/widgets/add_manpower_widget.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';

class ManpowerScreen extends StatefulWidget {
  @override
  _ManpowerScreenState createState() => _ManpowerScreenState();
}

class _ManpowerScreenState extends State<ManpowerScreen> {
  DateTime selectedDate = DateTime(2025, 6, 12);

  List<ProjectEntry> projects = [
    ProjectEntry(
      name: 'Defgh',
      color: Colors.amber,
      staff: [StaffEntry(name: 'kkk', count: 2)],
      manpower: [ManpowerEntry(name: 'Jkd', count: 1)],
      tasks: [TaskEntry(name: 'Cleaning')],
    ),
    ProjectEntry(
      name: 'New Agnecy',
      color: Colors.amber,
      staff: [StaffEntry(name: 'khurshid', count: 10)],
      manpower: [ManpowerEntry(name: 'khurshid', count: 10)],
      tasks: [TaskEntry(name: 'new task')],
    ),
  ];

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
            builder: (context) => const AddManpowerWidget(),
          );
        },
        tooltip: 'Add Requirements',
        child: Icon(Icons.add, color: Colors.white),
      ),

      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [_buildHeader(), Expanded(child: _buildProjectsList())],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // Top Header
                APPBarWidget(),

                // Tabs
                // SizedBox(height: 12),
                _buildDateSelector(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chevron_left, color: Colors.grey[600]),
          SizedBox(width: 16),
          Text(
            '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: 16),
          Icon(Icons.chevron_right, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(projects[index]);
      },
    );
  }

  Widget _buildProjectCard(ProjectEntry project) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildProjectHeader(project), _buildProjectContent(project)],
      ),
    );
  }

  Widget _buildProjectHeader(ProjectEntry project) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 228, 228),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: project.color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: project.color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.work_outline, color: Colors.white, size: 15),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              project.name,
              style: TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                letterSpacing: -0.5,
              ),
            ),
          ),
          Row(
            children: [
              _buildActionButton(Icons.content_copy, Colors.blue),
              SizedBox(width: 12),
              _buildActionButton(Icons.edit, Colors.purple),
              SizedBox(width: 12),
              _buildActionButton(Icons.close, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () => {
        showDialog(context: context, builder: (context) => const AddManpowerWidget())
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _buildProjectContent(ProjectEntry project) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            'Staff:-',
            project.staff.map((s) => _buildStaffItem(s)).toList(),
          ),
          SizedBox(height: 2),
          _buildSection(
            'Manpower:-',
            project.manpower.map((m) => _buildManpowerItem(m)).toList(),
          ),
          SizedBox(height: 2),
          _buildSection(
            'Task:-',
            project.tasks.map((t) => _buildTaskItem(t)).toList(),
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
        SizedBox(height: 2),
        ...items,
      ],
    );
  }

  Widget _buildStaffItem(StaffEntry staff) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.person, color: Colors.white, size: 16),
          ),
          SizedBox(width: 12),
          Text(
            '1.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              staff.name,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${staff.count}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManpowerItem(ManpowerEntry manpower) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.groups, color: Colors.white, size: 16),
          ),
          SizedBox(width: 12),
          Text(
            '1.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              manpower.name,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${manpower.count}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(TaskEntry task) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.task_alt, color: Colors.white, size: 16),
          ),
          SizedBox(width: 12),
          Text(
            '1.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              task.name,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRequirementsButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[400]!, Colors.amber[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.4),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: Colors.white, size: 24),
          SizedBox(width: 8),
          Text(
            'ADD REQUIREMENTS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectEntry {
  final String name;
  final Color color;
  final List<StaffEntry> staff;
  final List<ManpowerEntry> manpower;
  final List<TaskEntry> tasks;

  ProjectEntry({
    required this.name,
    required this.color,
    required this.staff,
    required this.manpower,
    required this.tasks,
  });
}

class StaffEntry {
  final String name;
  final int count;

  StaffEntry({required this.name, required this.count});
}

class ManpowerEntry {
  final String name;
  final int count;

  ManpowerEntry({required this.name, required this.count});
}

class TaskEntry {
  final String name;

  TaskEntry({required this.name});
}
