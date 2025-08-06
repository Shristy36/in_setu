import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:in_setu/screens/chat/model/ChatsDetailResponse.dart';
import 'package:intl/intl.dart';

class ChatDetailPage extends StatefulWidget {
  final List<Message> messageList;

  ChatDetailPage({super.key, required this.messageList});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.messageList.sort((a, b) {
      final aDate = DateTime.parse(a.createdAt!);
      final bDate = DateTime.parse(b.createdAt!);
      return aDate.compareTo(bDate); // oldest to newest
    });

    _messages = widget.messageList;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: AppColors.colorWhite),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Container(
        color: AppColors.colorWhite,
        child: Column(
          children: [
            // Chat messages
            Expanded(
              child:
                  _isLoading
                      ? _buildLoadingShimmer()
                      : _messages.isEmpty
                      ? const Center(
                        child: Text(
                          "No chat messages found.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                      : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: _buildMessageBubble(message),
                          );
                        },
                      ),
            ),

            // Message input
            SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSubmitted: (_) => /*_sendMessage()*/ {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () => {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        final isUserMessage = index % 2 == 1;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isUserMessage) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 50 + (index % 3) * 15,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isUserMessage ? 16 : 4),
                    bottomRight: Radius.circular(isUserMessage ? 4 : 16),
                  ),
                ),
              ),
              if (isUserMessage) ...[
                const SizedBox(width: 12),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(Message message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.person, size: 32, color: Colors.grey.shade600),
        ),

        const SizedBox(width: 8), // spacing between avatar and bubble
        // Message content
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message bubble
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.message!,
                    style: const TextStyle(
                      color: Colors.black,
                      // changed from white for visibility on light bubble
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),

                // Timestamp
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Text(
                    formatDateTime(message.updatedAt!),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatDateTime(String dateString) {
    final dt = DateTime.parse(dateString);
    final formatter = DateFormat('dd-MM-yyyy hh:mm a'); // or any other format
    return formatter.format(
      dt.toLocal(),
    ); // toLocal() converts from UTC to local time
  }
}
