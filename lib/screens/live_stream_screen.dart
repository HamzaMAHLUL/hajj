import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class CameraView {
  final String title;
  final String videoId;
  final String description;

  const CameraView({
    required this.title,
    required this.videoId,
    required this.description,
  });
}

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({super.key});

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  Timer? _timer;
  int _remainingMinutes = 0;
  String _nextPrayer = '';

  final List<CameraView> _cameraViews = const [
    CameraView(
      title: 'البث الرئيسي',
      videoId: 'muJGd53Cf-s',
      description: 'البث المباشر الرئيسي للحرم المكي',
    ),
    CameraView(
      title: 'منظر الكعبة',
      videoId: 'RbHRkxqA2Gs',
      description: 'منظر مباشر للكعبة المشرفة',
    ),
    CameraView(
      title: 'ساحات الحرم',
      videoId: '8ZoUwGRsHNE',
      description: 'بث مباشر لساحات الحرم المكي',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          },
        ),
      );

    _loadStream();
    _startPrayerTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadStream() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    _controller.loadRequest(
      Uri.parse('https://www.youtube.com/embed/muJGd53Cf-s?autoplay=1&rel=0&showinfo=0&modestbranding=1&playsinline=1'),
    );
  }

  void _startPrayerTimer() {
    // This is a simplified example. In a real app, you would:
    // 1. Fetch actual prayer times from an API
    // 2. Calculate the next prayer based on current time
    // 3. Update the countdown accordingly
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      final prayers = {
        'الفجر': DateTime(now.year, now.month, now.day, 4, 50),
        'الظهر': DateTime(now.year, now.month, now.day, 12, 15),
        'العصر': DateTime(now.year, now.month, now.day, 15, 45),
        'المغرب': DateTime(now.year, now.month, now.day, 18, 30),
        'العشاء': DateTime(now.year, now.month, now.day, 20, 0),
      };

      DateTime? nextPrayerTime;
      String nextPrayerName = '';

      for (var entry in prayers.entries) {
        if (entry.value.isAfter(now)) {
          nextPrayerTime = entry.value;
          nextPrayerName = entry.key;
          break;
        }
      }

      if (nextPrayerTime == null) {
        // If no prayer found today, get first prayer of next day
        nextPrayerTime = DateTime(now.year, now.month, now.day + 1, 4, 50);
        nextPrayerName = 'الفجر';
      }

      if (mounted) {
        setState(() {
          _remainingMinutes = nextPrayerTime!.difference(now).inMinutes;
          _nextPrayer = nextPrayerName;
        });
      }
    });
  }

  String _formatCountdown(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return '$hours:${mins.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'البث المباشر',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('مشاركة البث المباشر')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadStream,
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  if (_hasError)
                    Container(
                      color: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.white,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'حدث خطأ في تحميل البث',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: _loadStream,
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    WebViewWidget(
                      controller: _controller,
                    ),
                  if (_isLoading)
                    Container(
                      color: Colors.black,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'البث المباشر من المسجد الحرام',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'مشاهدة مباشرة للحرم المكي الشريف على مدار الساعة',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Next Prayer Card
                    Card(
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.timer, color: Colors.green.shade700),
                                const SizedBox(width: 8),
                                Text(
                                  'الوقت المتبقي لصلاة $_nextPrayer',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatCountdown(_remainingMinutes),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Stream Info Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'معلومات البث',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '• بث مباشر على مدار 24 ساعة\n'
                              '• جودة عالية الدقة (1080p)\n'
                              '• تغطية شاملة للحرم المكي\n'
                              '• صوت نقي وواضح\n'
                              '• تحديث مستمر للبث',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Prayer Times Card
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.schedule, color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  'أوقات الصلاة اليوم',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildPrayerTime('الفجر', '4:50'),
                                _buildPrayerTime('الظهر', '12:15'),
                                _buildPrayerTime('العصر', '3:45'),
                                _buildPrayerTime('المغرب', '6:30'),
                                _buildPrayerTime('العشاء', '8:00'),
                              ],
                            ),
                          ],
                        ),
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

  Widget _buildPrayerTime(String name, String time) {
    final isNext = _nextPrayer == name;
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isNext ? Colors.green : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 12,
            color: isNext ? Colors.green : Colors.grey[600],
          ),
        ),
      ],
    );
  }
} 