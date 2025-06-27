import 'package:flutter/material.dart';

final List<Map<String, dynamic>> dataLesson = [
  {
    "idTopic": 1,
    "nameTopic": "Greetings",
    "gradientColors": [Color(0xFFFFFFFF), Color.fromARGB(255, 88, 204, 2)],
    "listLessons": [
      {"id": 1, "title": "Hello", "status": "unlocked"},
      {"id": 2, "title": "How are you?", "status": "locked"},
      {"id": 3, "title": "Good Morning", "status": "locked"},
    ],
  },
  {
    "idTopic": 2,
    "nameTopic": "Family",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFFFFC371), // cam nhạt
    ],
    "listLessons": [
      {"id": 4, "title": "Father", "status": "locked"},
      {"id": 5, "title": "Mother", "status": "locked"},
      {"id": 6, "title": "Brother", "status": "locked"},
      {"id": 7, "title": "Sister", "status": "locked"},
    ],
  },
  {
    "idTopic": 3,
    "nameTopic": "Food",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFFF7797D), // đỏ hồng
    ],
    "listLessons": [
      {"id": 8, "title": "Apple", "status": "locked"},
      {"id": 9, "title": "Bread", "status": "locked"},
      {"id": 10, "title": "Rice", "status": "locked"},
      {"id": 11, "title": "Water", "status": "locked"},
    ],
  },
  {
    "idTopic": 4,
    "nameTopic": "Colors",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFF8E2DE2), // tím xanh
    ],
    "listLessons": [
      {"id": 12, "title": "Red", "status": "locked"},
      {"id": 13, "title": "Blue", "status": "locked"},
      {"id": 14, "title": "Green", "status": "locked"},
    ],
  },
  {
    "idTopic": 5,
    "nameTopic": "Animals",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFF56ab2f), // xanh lá đậm
    ],
    "listLessons": [
      {"id": 15, "title": "Dog", "status": "locked"},
      {"id": 16, "title": "Cat", "status": "locked"},
      {"id": 17, "title": "Bird", "status": "locked"},
      {"id": 18, "title": "Fish", "status": "locked"},
      {"id": 19, "title": "Cow", "status": "locked"},
    ],
  },
  {
    "idTopic": 6,
    "nameTopic": "Weather",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFF2980B9), // xanh biển
    ],
    "listLessons": [
      {"id": 20, "title": "Rain", "status": "locked"},
      {"id": 21, "title": "Sun", "status": "locked"},
      {"id": 22, "title": "Snow", "status": "locked"},
    ],
  },
  {
    "idTopic": 7,
    "nameTopic": "Time",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFFe96443), // đỏ cam
    ],
    "listLessons": [
      {"id": 23, "title": "Morning", "status": "locked"},
      {"id": 24, "title": "Evening", "status": "locked"},
      {"id": 25, "title": "Night", "status": "locked"},
      {"id": 26, "title": "Today", "status": "locked"},
    ],
  },
  {
    "idTopic": 8,
    "nameTopic": "Travel",
    "gradientColors": [
      Color(0xFFFFFFFF),
      Color(0xFFB06AB3), // tím pastel
    ],
    "listLessons": [
      {"id": 27, "title": "Airport", "status": "locked"},
      {"id": 28, "title": "Train", "status": "locked"},
      {"id": 29, "title": "Taxi", "status": "locked"},
      {"id": 30, "title": "Map", "status": "locked"},
    ],
  },
];
