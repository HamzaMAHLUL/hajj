import 'package:flutter/material.dart';

class RitualStep {
  final String title;
  final String description;
  final IconData icon;
  final List<String> instructions;

  const RitualStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.instructions,
  });
}

class RitualsGuideScreen extends StatelessWidget {
  RitualsGuideScreen({super.key});

  final List<RitualStep> hajjSteps = [
    RitualStep(
      title: 'الإحرام',
      description: 'بداية مناسك الحج بنية الإحرام ولبس ملابسه',
      icon: Icons.accessibility_new,
      instructions: [
        'الاغتسال والتطيب قبل الإحرام',
        'لبس ملابس الإحرام للرجال (إزار ورداء)',
        'النية والتلبية: لبيك اللهم لبيك...',
        'التوجه إلى الميقات المناسب',
      ],
    ),
    RitualStep(
      title: 'الطواف',
      description: 'الطواف حول الكعبة المشرفة سبعة أشواط',
      icon: Icons.change_history,
      instructions: [
        'البدء من الحجر الأسود',
        'الطواف سبعة أشواط كاملة',
        'الدعاء والذكر أثناء الطواف',
        'صلاة ركعتين خلف مقام إبراهيم',
      ],
    ),
    RitualStep(
      title: 'السعي',
      description: 'السعي بين الصفا والمروة سبعة أشواط',
      icon: Icons.directions_walk,
      instructions: [
        'البدء من الصفا',
        'السعي سبعة أشواط',
        'الدعاء والذكر أثناء السعي',
        'الهرولة بين العلامتين الخضراوين للرجال',
      ],
    ),
    RitualStep(
      title: 'الوقوف بعرفة',
      description: 'ركن الحج الأعظم في اليوم التاسع من ذي الحجة',
      icon: Icons.landscape,
      instructions: [
        'الوقوف في عرفة من الزوال إلى الغروب',
        'الدعاء والذكر وقراءة القرآن',
        'صلاة الظهر والعصر جمعاً وقصراً',
        'الإكثار من الدعاء والاستغفار',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'دليل المناسك',
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
                              Icon(Icons.info_outline, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                'دليل خطوات الحج',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'دليل شامل لجميع مناسك الحج خطوة بخطوة مع الشرح التفصيلي',
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
                  // Rituals Steps List
                  ...hajjSteps.map((step) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      child: ExpansionTile(
                        leading: Icon(step.icon, color: Colors.green),
                        title: Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          step.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'الخطوات التفصيلية:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...step.instructions.map((instruction) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check_circle_outline, 
                                        size: 20,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          instruction,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 