import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  RankingScreen({super.key});

  final List<String> rankGifs = [
    'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExZTkwMG5hZWJsbDJ4OGd2czUwY3NrMHQyaW56MjdwOGYzcjlvcHJvMyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/87cNrqklwyaNKVA5Fv/giphy.gif',
    'https://media.giphy.com/media/VnlCwytmrcuc5jT2GB/giphy.gif',
    'https://media.giphy.com/media/9CC21n237GiI1cgeeS/giphy.gif',
  ];

  final List<Map<String, dynamic>> rankingData = [
    {
      'name': "selvia",
      'image':
          "https://storage.googleapis.com/a1aa/image/062061c4-4e3a-4bdf-a587-db79d5548e2c.jpg",
      'score': 3331,
    },
    {
      'name': "nguyễn Minh...",
      'image':
          "https://storage.googleapis.com/a1aa/image/4136f746-4204-4177-44ba-284435b6b977.jpg",
      'score': 3027,
    },
    {
      'name': "Anastasia Go",
      'image': "https://placehold.co/32x32/7f7f7f/000000.png?text=A",
      'score': 2715,
    },
    {
      'name': "rachael",
      'image':
          "https://storage.googleapis.com/a1aa/image/b554b843-f02e-47bc-48cd-2d625ae82c4c.jpg",
      'score': 2495,
    },
    {
      'name': "Dy An",
      'image':
          "https://storage.googleapis.com/a1aa/image/e2c46cb5-10db-4934-b9e9-72b4f925e2fb.jpg",
      'score': 1796,
    },
    {
      'name': "Chris P.",
      'image': "https://placehold.co/32x32?text=C",
      'score': 1623,
    },
    {
      'name': "Luna",
      'image': "https://placehold.co/32x32?text=L",
      'score': 1511,
    },
    {
      'name': "John T.",
      'image': "https://placehold.co/32x32?text=J",
      'score': 1400,
    },
    {
      'name': "Mira",
      'image': "https://placehold.co/32x32?text=M",
      'score': 1322,
    },
    {
      'name': "Leo",
      'image': "https://placehold.co/32x32?text=L",
      'score': 1211,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Image.network(
                "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbG04OWJ5b3Y1ZHplcW8xNGlkNGpyOGJ2aG9icHNrbjVsNDllenZpNCZlcD12MV9zdGlja2Vyc19zZWFyY2gmY3Q9cw/N4l5gQnBfdcWSppezE/giphy.gif",
                width: 200,
                height: 200,
              ),
              const Text(
                'Giải đấu Bạc',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const Text(
                'Top 15 sẽ được thăng hạng lên giải đấu cao hơn',
                style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
              ),
              const Text(
                '1 ngày',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFFF59E0B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(rankingData.length, (index) {
                    final user = rankingData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          index < 3
                              ? Image.network(
                                  rankGifs[index],
                                  width: 30,
                                  height: 30,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundImage: NetworkImage(user['image']),
                            radius: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              user['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF374151),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            '${user['score']} KN',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
