import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_setu/commonWidget/no_data_found.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/networkSupport/ErrorHandler.dart';
import 'package:in_setu/networkSupport/base/GlobalApiResponseState.dart';
import 'package:in_setu/screens/chat/bloc/chats_bloc.dart';
import 'package:in_setu/screens/chat/chatdetail_screen.dart';
import 'package:in_setu/screens/chat/model/ChatsDetailResponse.dart';
import 'package:in_setu/supports/utility.dart';
import 'package:in_setu/widgets/app_drawer_widget.dart';
import 'package:intl/intl.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  /*final List<ChatItem> _allChats = [
    ChatItem(
      name: 'Khurshid',
      lastMessage: 'How is the construction progress going?',
      time: '10:30 AM',
      unreadCount: 2,
      isOnline: true,
    ),
    ChatItem(
      name: 'Shyam',
      lastMessage: 'The materials have been delivered',
      time: '9:45 AM',
      unreadCount: 0,
      isOnline: true,
    ),
    ChatItem(
      name: 'Khushi',
      lastMessage: 'Site inspection scheduled for tomorrow',
      time: 'Yesterday',
      unreadCount: 1,
      isOnline: false,
    ),
  ];*/
  // List<Conversation> listOfChat = [];
  List<Conversation> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    context.read<ChatsBloc>().add(FetchChatsDetails());
    // _filteredChats = listOfChat;
    _searchController.addListener(_filterChats);
  }

  void _filterChats() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredChats = _filteredChats;
      } else {
        _filteredChats =
            _filteredChats
                .where(
                  (chat) => chat.lastMessage!.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawerItems(context),
      backgroundColor: Color(0xFFF5F5F5),
      body:BlocBuilder<ChatsBloc, GlobalApiResponseState>(
        builder: (context, state) {
          if (state.status == GlobalApiStatus.loading && state.data == null) {
            return Utility.getLoadingView(context);
          }

          if (state is ChatsDetailsStateSuccess) {
            if (state.data.data?.data == null || state.data.data!.data!.isEmpty) {
              return NoDataFound(noDataFoundTxt: "No Chat list found");
            }
            _filteredChats = state.data.data!.data!;
            return getChattingView(state.data.data!.data!);
          }

          if (state.status == GlobalApiStatus.error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ErrorHandler.errorHandle(state.message, "Invalid", context);
            });
            return Center(child: Text('Failed to load projects'));
          }


          return Center(child: Text('Loading...'));
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget getChattingView(List<Conversation> chattingList){
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildChatList(chattingList)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.colorGray, width: 1)
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
            ),
            border: InputBorder.none,
            isDense: true, // Reduces the height for better alignment
            contentPadding: EdgeInsets.symmetric(vertical: 12), // Adjust as needed
          ),
        ),
      ),
    );
  }

  Widget _buildChatList(List<Conversation> chattingList) {
    if (_filteredChats.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 18),
      itemCount: _filteredChats.length,
      itemBuilder: (context, index) {
        return _buildChatItem(_filteredChats[index], index);
      },
    );
  }

  Widget _buildChatItem(Conversation chat, int index) {
    // final date = DateFormat('MMM dd, yyyy').format(chat.createdAt);
    // DateTime time = DateTime.parse(chat.createdAt!);

    return Container(
      margin: EdgeInsets.only(bottom: 12, right: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatDetailPage(messageList: chat.messages!)),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Image.asset("assets/icons/chat.png", width: 35,height: 35, color: Colors.blue,)
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            chat.lastMessage!.isEmpty ? "" : chat.lastMessage!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            formatDateTime(chat.createdAt!),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String formatDateTime(String dateString) {
    final dt = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy hh:mm a'); // or any other format
    return formatter.format(dt.toLocal()); // toLocal() converts from UTC to local time
  }
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Color(0xFF9CA3AF)),
          SizedBox(height: 16),
          Text(
            'No chats found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start a new conversation',
            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Handle new chat
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
          content: Text('Start new chat'),
          behavior: SnackBarBehavior.floating,
          // margin: EdgeInsets.only(
          //   bottom: MediaQuery.of(context).size.height * 1,// Adjust as needed
          // ),
        ),);
      },
      backgroundColor: AppColors.primary,
      elevation: 8,
      child: Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  List<Color> _getGradientColors(int index) {
    List<List<Color>> gradients = [
      [Color(0xFF667EEA), Color(0xFF764BA2)],
      [Color(0xFF10B981), Color(0xFF059669)],
      [Color(0xFFEF4444), Color(0xFFDC2626)],
      [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      [Color(0xFFF59E0B), Color(0xFFD97706)],
    ];
    return gradients[index % gradients.length];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

/*
class ChatItem {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  ChatItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
  });
}
*/
