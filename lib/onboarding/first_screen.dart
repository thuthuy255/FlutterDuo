import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadSound();
  }

  Future<void> _loadSound() async {
    try {
      await _audioPlayer.setSource(AssetSource('audio/click.wav'));
    } catch (e) {
      debugPrint("Lỗi tải âm thanh: $e");
    }
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer
          .resume(); // hoặc _audioPlayer.play(...) nếu cần phát từ đầu
    } catch (e) {
      debugPrint("Lỗi phát âm thanh: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 35),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset('assets/images/forest.png', width: 50, height: 50),
            //     const SizedBox(width: 10),
            //     const Text(
            //       "Elearning",
            //       style: TextStyle(fontSize: 30, color: Color(0xFF58CC02)),
            //     ),
            //   ],
            // ),
            Column(
              children: const [
                Image(
                  image: NetworkImage(
                    "https://media.giphy.com/media/Yldo4OWANKw970cVU5/giphy.gif",
                  ),
                  width: 250,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text(
                  "The free, fun, and",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
                Text(
                  "effective way to learn a",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
                Text(
                  "language!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      foregroundColor: Colors.white,
                      shadowColor: const Color(0xFF58A700),
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                          color: Color(0xFF58CC02),
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await _playSound();
                      Navigator.of(context).pushNamed('second');
                    },
                    child: const Center(
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1CB0F6),
                      shadowColor: const Color(0xFFE5E5E5),
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(
                        color: Color(0xFFE5E5E5),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      print("Đã bấm nút LOGIN");
                      await _playSound();
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed('/login');
                    },
                    child: const Center(
                      child: Text(
                        'I ALREADY HAVE AN ACCOUNT',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1CB0F6),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
