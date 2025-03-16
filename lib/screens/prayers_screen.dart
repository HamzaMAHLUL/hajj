import 'package:flutter/material.dart';

class Prayer {
  final String title;
  final String arabicText;
  final String translation;
  final String occasion;
  final String? audioUrl;

  const Prayer({
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.occasion,
    this.audioUrl,
  });
}

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  final List<Prayer> prayers = [
    const Prayer(
      title: 'دعاء التلبية',
      arabicText: 'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لاَ شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لاَ شَرِيكَ لَكَ',
      translation: 'Here I am, O Allah, here I am. Here I am, You have no partner, here I am. Verily all praise, grace and sovereignty belong to You. You have no partner.',
      occasion: 'يقال عند الإحرام وأثناء التنقل بين المشاعر',
    ),
    const Prayer(
      title: 'دعاء الطواف',
      arabicText: 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      translation: 'Our Lord, give us good in this world and good in the Hereafter, and protect us from the torment of the Fire.',
      occasion: 'يقال أثناء الطواف حول الكعبة',
    ),
    const Prayer(
      title: 'دعاء السعي',
      arabicText: 'رَبِّ اغْفِرْ وَارْحَمْ، إِنَّكَ أَنْتَ الأَعَزُّ الأَكْرَمُ',
      translation: 'My Lord, forgive and have mercy, for You are the Most Mighty, the Most Noble.',
      occasion: 'يقال أثناء السعي بين الصفا والمروة',
    ),
    const Prayer(
      title: 'دعاء عرفة',
      arabicText: 'لا إِلَهَ إِلاَّ اللهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      translation: 'There is no deity worthy of worship except Allah alone, Who has no partner. To Him belongs the dominion, and to Him belongs all praise, and He is Able to do all things.',
      occasion: 'يقال في يوم عرفة',
    ),
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الأدعية والأذكار',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Introduction Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.volume_up, color: Colors.orange),
                              SizedBox(width: 8),
                              Text(
                                'أدعية وأذكار الحج',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'مجموعة من الأدعية والأذكار المأثورة في الحج',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Prayers List
                  ...prayers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final prayer = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                expandedIndex == index ? Icons.expand_less : Icons.expand_more,
                                color: Colors.orange,
                              ),
                              title: Text(
                                prayer.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                prayer.occasion,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing: const Icon(Icons.volume_up, size: 20),
                              onTap: () {
                                setState(() {
                                  expandedIndex = expandedIndex == index ? null : index;
                                });
                              },
                            ),
                            if (expandedIndex == index)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.orange.shade100),
                                      ),
                                      child: Text(
                                        prayer.arabicText,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade200),
                                      ),
                                      child: Text(
                                        prayer.translation,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement search/filter prayers
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.search),
      ),
    );
  }
} 