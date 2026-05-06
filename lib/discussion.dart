import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Bachir_esp',
      'lastMessage': 'Grand li faw niou changer écran bi',
      'time': '9:32',
      'unread': 2,
      'online': true,
      'avatar': 'https://images.unsplash.com/photo-1531384441138-2736e62e0919?w=80',
    },
    {
      'name': 'Rassoul_Apple',
      'lastMessage': 'Non 380K la meun yam nak',
      'time': '8:15',
      'unread': 0,
      'online': false,
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80',
    },
    {
      'name': 'Babacar Diop',
      'lastMessage': 'Boy mangui mothie dé pour 15 bi',
      'time': 'Hier',
      'unread': 5,
      'online': true,
      'avatar': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=80',
    },
    {
      'name': 'Christian',
      'lastMessage': "Mon frère l'entretien clim c à 10K",
      'time': 'Lun.',
      'unread': 0,
      'online': false,
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=80',
    },
    {
      'name': 'Mareme_AK47',
      'lastMessage': 'G fan la meun amé sa adaptateur bi',
      'time': 'Dim.',
      'unread': 1,
      'online': true,
      'avatar': 'https://images.unsplash.com/photo-1523824921871-d6f1a15151f1?w=80',
    },
    {
      'name': 'Tenkou Électronique',
      'lastMessage': 'Waw, Samsung S24 dafa nekk, 780K',
      'time': 'Sam.',
      'unread': 0,
      'online': false,
      'avatar': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=80',
    },
    {
      'name': 'Awa_DakarTech',
      'lastMessage': 'Prix bi dinañu ko xamal demain',
      'time': 'Ven.',
      'unread': 0,
      'online': false,
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80',
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    final q = _searchController.text.toLowerCase();
    if (q.isEmpty) return _conversations;
    return _conversations
        .where((c) => (c['name'] as String).toLowerCase().contains(q) ||
        (c['lastMessage'] as String).toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE85D26),
        child: const Icon(Icons.edit_outlined, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          const Text(
            'Discussions',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFE85D26).withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.filter_list_rounded,
                color: Color(0xFFE85D26), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0EAE2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Rechercher une conversation...',
            hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
            prefixIcon:
            Icon(Icons.search_rounded, color: Color(0xFF888888), size: 20),
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    final conversations = _filtered;

    if (conversations.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline_rounded,
                color: Color(0xFFDDDDDD), size: 48),
            SizedBox(height: 12),
            Text(
              'Aucune conversation',
              style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: conversations.length,
      separatorBuilder: (_, __) => const Divider(
        indent: 82,
        endIndent: 20,
        height: 1,
        color: Color(0xFFF0E8DF),
      ),
      itemBuilder: (context, index) =>
          _buildConversationTile(conversations[index]),
    );
  }

  Widget _buildConversationTile(Map<String, dynamic> conv) {
    final hasUnread = (conv['unread'] as int) > 0;

    return InkWell(
      onTap: () {
        // Navigation vers la conversation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Conversation avec ${conv['name']}'),
            backgroundColor: const Color(0xFFE85D26),
            behavior: SnackBarBehavior.floating,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar + online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(conv['avatar']),
                  backgroundColor: const Color(0xFFDDD0C8),
                  onBackgroundImageError: (_, __) {},
                ),
                if (conv['online'] == true)
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv['name'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: hasUnread
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      Text(
                        conv['time'],
                        style: TextStyle(
                          fontSize: 12,
                          color: hasUnread
                              ? const Color(0xFFE85D26)
                              : const Color(0xFFAAAAAA),
                          fontWeight: hasUnread
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conv['lastMessage'],
                          style: TextStyle(
                            fontSize: 13,
                            color: hasUnread
                                ? const Color(0xFFE85D26)
                                : const Color(0xFF888888),
                            fontWeight: hasUnread
                                ? FontWeight.w500
                                : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE85D26),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${conv['unread']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}