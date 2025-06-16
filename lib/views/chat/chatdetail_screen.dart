import 'package:flutter/material.dart';

// Mock data models
class ChatMessage {
  final String id;
  final String message;
  final String senderId;
  final String senderName;
  final String senderPhoto;
  final DateTime createdAt;
  final bool isFromUser;

  ChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.senderPhoto,
    required this.createdAt,
    required this.isFromUser,
  });
}

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage(this.vendorId, this.vendorName, {Key? key})
    : super(key: key);

  final String? vendorId;
  final String? vendorName;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Mock chat messages
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMockMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockMessages() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages = [
          ChatMessage(
            id: '1',
            message: 'Hello!',
            senderId: widget.vendorId ?? '',
            senderName: widget.vendorName ?? '',
            senderPhoto: '',
            createdAt: DateTime.now().subtract(const Duration(hours: 2)),
            isFromUser: false,
          ),
          ChatMessage(
            id: '2',
            message: 'Hi! ',
            senderId: 'user_123',
            senderName: 'You',
            senderPhoto: '',
            createdAt: DateTime.now().subtract(
              const Duration(hours: 1, minutes: 45),
            ),
            isFromUser: true,
          ),
          ChatMessage(
            id: '3',
            message: 'How are you',
            senderId: widget.vendorId ?? '',
            senderName: widget.vendorName ?? '',
            senderPhoto: '',
            createdAt: DateTime.now().subtract(
              const Duration(hours: 1, minutes: 30),
            ),
            isFromUser: false,
          ),
        ];
        _isLoading = false;
      });
      _scrollToBottom();
    });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            message: text,
            senderId: 'user_123',
            senderName: 'You',
            senderPhoto: '',
            createdAt: DateTime.now(),
            isFromUser: true,
          ),
        );
      });
      _messageController.clear();
      _scrollToBottom();

      // Simulate vendor response after a delay
      _simulateVendorResponse();
    }
  }

  void _simulateVendorResponse() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              message: 'Thanks for your message! I\'ll get back to you soon.',
              senderId: widget.vendorId ?? '',
              senderName: widget.vendorName ?? '',
              senderPhoto:
                  'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
              createdAt: DateTime.now(),
              isFromUser: false,
            ),
          );
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.vendorName ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Column(
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
                      onSubmitted: (_) => _sendMessage(),
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
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildMessageBubble(ChatMessage message) {
    return Row(
      mainAxisAlignment:
          message.isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sender avatar (left side for vendor)
        if (!message.isFromUser) ...[
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(message.senderPhoto),
            backgroundColor: Colors.grey.shade300,
            onBackgroundImageError: (_, __) {},
            child:
                message.senderPhoto.isEmpty
                    ? Icon(Icons.person, size: 16, color: Colors.grey.shade600)
                    : null,
          ),
          const SizedBox(width: 12),
        ],

        // Message bubble
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Column(
              crossAxisAlignment:
                  message.isFromUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                // Message bubble
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color:
                        message.isFromUser
                            ? Colors.blue.shade500
                            : Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(message.isFromUser ? 16 : 4),
                      bottomRight: Radius.circular(message.isFromUser ? 4 : 16),
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
                    message.message,
                    style: TextStyle(
                      color: message.isFromUser ? Colors.white : Colors.black87,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),

                // Timestamp
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _formatTime(message.createdAt),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
          ),
        ),

        // User avatar (right side for user messages)
        if (message.isFromUser) ...[
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(message.senderPhoto),
            backgroundColor: Colors.grey.shade300,
            onBackgroundImageError: (_, __) {},
            child:
                message.senderPhoto.isEmpty
                    ? Icon(Icons.person, size: 16, color: Colors.grey.shade600)
                    : null,
          ),
        ],
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
