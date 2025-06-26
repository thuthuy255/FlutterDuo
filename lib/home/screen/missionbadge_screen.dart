import 'package:flutter/material.dart';

class MissionBadgeScreen extends StatelessWidget {
  const MissionBadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFB28AE0),
          automaticallyImplyLeading: false,
          title: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'NHIỆM VỤ'),
              Tab(text: 'HUY HIỆU'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_MissionTabContent(), _BadgeTabContent()],
        ),
      ),
    );
  }
}

class _MissionTabContent extends StatelessWidget {
  const _MissionTabContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFB28AE0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chào mừng!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Hãy hoàn thành nhiệm vụ để nhận thưởng nhé! Mỗi ngày sẽ có các nhiệm vụ mới.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Image.asset('assets/icons/duo.png', width: 100, height: 100),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nhiệm vụ hằng ngày',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('6 TIẾNG', style: TextStyle(color: Colors.orange)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flash_on, color: Colors.orange),
                          const SizedBox(width: 8),
                          const Text(
                            'Kiếm 30 KN',
                            style: TextStyle(fontSize: 16),
                          ),
                          const Spacer(),
                          Image.asset(
                            'assets/icons/ruong.png',
                            width: 32,
                            height: 32,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.75,
                        color: Colors.orange,
                        backgroundColor: Colors.orange.withOpacity(0.2),
                      ),
                      const SizedBox(height: 4),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('25 / 30'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sắp tới',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                const _LockedTask(title: 'Bật mí sau 2 ngày'),
                const SizedBox(height: 8),
                const _LockedTask(title: 'Bật mí sau 4 ngày'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LockedTask extends StatelessWidget {
  final String title;

  const _LockedTask({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: Colors.grey),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

class _BadgeTabContent extends StatelessWidget {
  const _BadgeTabContent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/badge.png', width: 300, height: 200),
            const SizedBox(height: 24),
            const Text(
              'Chinh phục huy hiệu đầu tiên!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Hoàn thành các thử thách hàng tháng để giành được huy hiệu độc đáo',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
