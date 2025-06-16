import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/views/chat/chatdetail_screen.dart';
import 'package:in_setu/views/material_screen.dart';
import 'package:in_setu/widgets/custom_app_bar.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<ChatItem> _allChats = [
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
  ];

  List<ChatItem> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = _allChats;
    _searchController.addListener(_filterChats);
  }

  void _filterChats() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredChats = _allChats;
      } else {
        _filteredChats =
            _allChats
                .where(
                  (chat) => chat.name.toLowerCase().contains(
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
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            // _buildSearchBar(),
            Expanded(child: _buildChatList()),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      color: Colors.white,
      child: Column(
        children: [
          // Top Header
          APPBarWidget(),
          _buildSearchBar(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF64748B), size: 20),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
                style: TextStyle(fontSize: 16, color: Color(0xFF1F2937)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    if (_filteredChats.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24),
      itemCount: _filteredChats.length,
      itemBuilder: (context, index) {
        return _buildChatItem(_filteredChats[index], index);
      },
    );
  }

  Widget _buildChatItem(ChatItem chat, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
              MaterialPageRoute(builder: (context) => ChatDetailPage("", "")),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _getGradientColors(index),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    // if (chat.isOnline)
                    //   Positioned(
                    //     right: 2,
                    //     bottom: 2,
                    //     child: Container(
                    //       width: 14,
                    //       height: 14,
                    //       decoration: BoxDecoration(
                    //         color: Color(0xFF10B981),
                    //         border: Border.all(color: Colors.white, width: 2),
                    //         borderRadius: BorderRadius.circular(7),
                    //       ),
                    //     ),
                    //   ),
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
                            chat.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            chat.time,
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.lastMessage,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                                height: 1.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (chat.unreadCount > 0) ...[
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF3B82F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${chat.unreadCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Start new chat')));
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
