import 'package:flutter/material.dart';

class Surah {
  final int number;
  final String name;
  final String arabicName;
  final int versesCount;
  final String type; // مكية أو مدنية

  const Surah({
    required this.number,
    required this.name,
    required this.arabicName,
    required this.versesCount,
    required this.type,
  });
}

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Surah> surahs = [
    const Surah(
      number: 1,
      name: "Al-Fatiha",
      arabicName: "الفاتحة",
      versesCount: 7,
      type: "مكية",
    ),
    const Surah(
      number: 2,
      name: "Al-Baqarah",
      arabicName: "البقرة",
      versesCount: 286,
      type: "مدنية",
    ),
    const Surah(
      number: 3,
      name: "Al-Imran",
      arabicName: "آل عمران",
      versesCount: 200,
      type: "مدنية",
    ),
    // Add more surahs as needed
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Surah> get filteredSurahs {
    if (_searchQuery.isEmpty) {
      return surahs;
    }
    return surahs.where((surah) {
      return surah.arabicName.contains(_searchQuery) ||
          surah.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'القرآن الكريم',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'قائمة السور'),
            Tab(text: 'المصحف'),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'البحث عن سورة...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Surah List Tab
                  ListView.builder(
                    itemCount: filteredSurahs.length,
                    itemBuilder: (context, index) {
                      final surah = filteredSurahs[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Center(
                              child: Text(
                                '${surah.number}',
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            surah.arabicName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${surah.name} - ${surah.type} - ${surah.versesCount} آية',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.play_circle_outline),
                            color: Colors.green,
                            onPressed: () {
                              // TODO: Implement audio playback
                            },
                          ),
                          onTap: () {
                            // TODO: Navigate to Surah detail view
                          },
                        ),
                      );
                    },
                  ),
                  // Mushaf View Tab
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'عرض المصحف قيد التطوير',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement last read position
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.bookmark),
      ),
    );
  }
} 