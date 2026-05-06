import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final List<Map<String, dynamic>> _stories = [
    {
      'name': 'Tenkou',
      'imageUrl':
      'https://images.unsplash.com/photo-1531384441138-2736e62e0919?w=150',
      'hasNew': true,
    },
    {
      'name': 'Vous',
      'imageUrl': null,
      'isMe': true,
      'hasNew': false,
    },
    {
      'name': 'Diallo',
      'imageUrl':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      'hasNew': true,
    },
    {
      'name': 'Fatou',
      'imageUrl':
      'https://images.unsplash.com/photo-1523824921871-d6f1a15151f1?w=150',
      'hasNew': false,
    },
  ];

  final List<Map<String, dynamic>> _posts = [
    {
      'shop': 'Tenkou_Electronique',
      'shopAvatar':
      'https://images.unsplash.com/photo-1531384441138-2736e62e0919?w=80',
      'isLive': true,
      'image':
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600&h=400&fit=crop',
      'product': 'iPhone 15 Pro Max - 256GB',
      'price': '985 000 FCFA',
      'likes': 128,
      'liked': false,
      'comments': 34,
    },
    {
      'shop': 'Rassoul_Apple',
      'shopAvatar':
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=80',
      'isLive': false,
      'image':
      'https://images.unsplash.com/photo-1603791440384-56cd371ee9a7?w=600&h=400&fit=crop',
      'product': 'Samsung Galaxy S24 Ultra',
      'price': '780 000 FCFA',
      'likes': 89,
      'liked': false,
      'comments': 21,
    },
    {
      'shop': 'Dakar_Tech',
      'shopAvatar':
      'https://images.unsplash.com/photo-1523824921871-d6f1a15151f1?w=80',
      'isLive': false,
      'image':
      'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=600&h=400&fit=crop',
      'product': 'Airpods Pro 2ème génération',
      'price': '145 000 FCFA',
      'likes': 210,
      'liked': false,
      'comments': 58,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6EE),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverToBoxAdapter(child: _buildHeader()),
              // Stories
              SliverToBoxAdapter(child: _buildStories()),
              // Divider
              const SliverToBoxAdapter(
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              // Posts Feed
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildPostCard(_posts[index], index),
                  childCount: _posts.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Galsen_Telecom',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Color(0xFFE85D26), Color(0xFFC0392B)],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 30)),
              letterSpacing: 0.5,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, size: 26),
                onPressed: () {},
                color: const Color(0xFF333333),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          final isMe = story['isMe'] == true;
          final hasNew = story['hasNew'] == true;

          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: hasNew
                            ? const LinearGradient(
                          colors: [Color(0xFFE85D26), Color(0xFFFFB347)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        color: hasNew ? null : const Color(0xFFE0E0E0),
                      ),
                      padding: const EdgeInsets.all(2.5),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: ClipOval(
                          child: isMe
                              ? Container(
                            color: const Color(0xFFE8E8F0),
                            child: const Icon(
                              Icons.person_outline,
                              color: Color(0xFFAAAAAA),
                              size: 26,
                            ),
                          )
                              : Image.network(
                            story['imageUrl'],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFFDDD0C8),
                              child: const Icon(Icons.person, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isMe)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE85D26),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  story['name'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF444444),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, int index) {
    return StatefulBuilder(
      builder: (context, setCardState) {
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shop header
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          NetworkImage(post['shopAvatar']),
                          backgroundColor: const Color(0xFFDDD0C8),
                          onBackgroundImageError: (_, __) {},
                        ),
                        if (post['isLive'] == true)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE85D26),
                                border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                post['shop'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xFF222222),
                                ),
                              ),
                              if (post['isLive'] == true) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE85D26),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'EN DIRECT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            post['product'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.more_horiz, color: Color(0xFF888888)),
                  ],
                ),
              ),

              // Product image
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  post['image'],
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: const Color(0xFFEEEEEE),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFE85D26),
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFEEEEEE),
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined,
                          color: Color(0xFFBBBBBB), size: 40),
                    ),
                  ),
                ),
              ),

              // Price tag
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE85D26).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFFE85D26).withOpacity(0.3)),
                      ),
                      child: Text(
                        post['price'],
                        style: const TextStyle(
                          color: Color(0xFFE85D26),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Actions
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 14, 12),
                child: Row(
                  children: [
                    // Like
                    IconButton(
                      onPressed: () {
                        setCardState(() {
                          post['liked'] = !post['liked'];
                          post['likes'] += post['liked'] ? 1 : -1;
                        });
                      },
                      icon: Icon(
                        post['liked']
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: post['liked']
                            ? const Color(0xFFE85D26)
                            : const Color(0xFF666666),
                        size: 24,
                      ),
                    ),
                    Text(
                      '${post['likes']}',
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF666666)),
                    ),
                    const SizedBox(width: 8),
                    // Comment
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline_rounded,
                          size: 22, color: Color(0xFF666666)),
                    ),
                    Text(
                      '${post['comments']}',
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF666666)),
                    ),
                    const Spacer(),
                    // Buy button
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                      label: const Text('Acheter'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE85D26),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Share
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined,
                          size: 22, color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}