import 'package:flutter/material.dart';

class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({super.key});

  @override
  State<ExplorerScreen> createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Tous';

  final List<String> _categories = [
    'Tous',
    'iPhone',
    'Samsung',
    'Accessoires',
    'Réparation',
    'PC',
  ];

  final List<Map<String, dynamic>> _shops = [
    {
      'name': "Eum'S Télécom",
      'category': 'iPhone',
      'rating': 4.9,
      'sales': '1.2K ventes',
      'image': 'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=300&h=300&fit=crop',
      'verified': true,
      'badge': '🏆',
    },
    {
      'name': 'Tenkou Électronique',
      'category': 'Samsung',
      'rating': 4.7,
      'sales': '890 ventes',
      'image': 'https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=300&h=300&fit=crop',
      'verified': true,
      'badge': '⭐',
    },
    {
      'name': 'Rassoul Apple Store',
      'category': 'iPhone',
      'rating': 4.8,
      'sales': '2.1K ventes',
      'image': 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=300&h=300&fit=crop',
      'verified': true,
      'badge': '🏆',
    },
    {
      'name': 'Dakar Tech Pro',
      'category': 'Accessoires',
      'rating': 4.5,
      'sales': '450 ventes',
      'image': 'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=300&h=300&fit=crop',
      'verified': false,
      'badge': null,
    },
    {
      'name': 'Pikine Repair Center',
      'category': 'Réparation',
      'rating': 4.6,
      'sales': '320 ventes',
      'image': 'https://images.unsplash.com/photo-1563203369-26f2e4a5ccf7?w=300&h=300&fit=crop',
      'verified': true,
      'badge': '⭐',
    },
    {
      'name': 'Sodida PC & Mac',
      'category': 'PC',
      'rating': 4.4,
      'sales': '670 ventes',
      'image': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300&h=300&fit=crop',
      'verified': false,
      'badge': null,
    },
    {
      'name': 'Grand Yoff Mobiles',
      'category': 'Samsung',
      'rating': 4.3,
      'sales': '215 ventes',
      'image': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300&h=300&fit=crop',
      'verified': false,
      'badge': null,
    },
    {
      'name': 'Almadies Gadgets',
      'category': 'Accessoires',
      'rating': 4.7,
      'sales': '540 ventes',
      'image': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&h=300&fit=crop',
      'verified': true,
      'badge': '⭐',
    },
    {
      'name': 'Liberté Tech Hub',
      'category': 'PC',
      'rating': 4.2,
      'sales': '180 ventes',
      'image': 'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=300&h=300&fit=crop',
      'verified': false,
      'badge': null,
    },
  ];

  List<Map<String, dynamic>> get _filteredShops {
    final query = _searchController.text.toLowerCase();
    return _shops.where((shop) {
      final matchesCategory =
          _selectedCategory == 'Tous' || shop['category'] == _selectedCategory;
      final matchesSearch = query.isEmpty ||
          (shop['name'] as String).toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
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
          children: [
            _buildSearchBar(),
            _buildCategories(),
            Expanded(
              child: _buildGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF0EAE2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: "Rechercher une boutique...",
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Color(0xFF888888),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear_rounded,
                        color: Color(0xFF888888), size: 18),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE85D26),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = _selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                isSelected ? const Color(0xFFE85D26) : const Color(0xFFF0EAE2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF666666),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid() {
    final shops = _filteredShops;

    if (shops.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded,
                color: Color(0xFFCCCCCC), size: 48),
            SizedBox(height: 12),
            Text(
              'Aucune boutique trouvée',
              style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 15),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.82,
      ),
      itemCount: shops.length,
      itemBuilder: (context, index) => _buildShopCard(shops[index]),
    );
  }

  Widget _buildShopCard(Map<String, dynamic> shop) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Boutique: ${shop['name']}'),
            backgroundColor: const Color(0xFFE85D26),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop image
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      shop['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFFEEEEEE),
                        child: const Icon(Icons.store_outlined,
                            color: Color(0xFFBBBBBB)),
                      ),
                    ),
                    if (shop['badge'] != null)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            shop['badge'],
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Shop info
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 5, 7, 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          shop['name'],
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (shop['verified'] == true)
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xFFE85D26),
                          size: 12,
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Color(0xFFFFC107), size: 11),
                      const SizedBox(width: 2),
                      Text(
                        '${shop['rating']}',
                        style: const TextStyle(
                            fontSize: 9, color: Color(0xFF666666)),
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