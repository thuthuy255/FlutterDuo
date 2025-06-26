import 'package:flutter/material.dart';
import 'package:duolingo/components/conversation/answer_widget.dart';
import 'package:duolingo/components/conversation/question_widget.dart';
import 'package:duolingo/components/header/header_topic.dart';

class ConversationLesson extends StatelessWidget {
  const ConversationLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderTopic(
                iconXml: '',
                uriImg:
                    "https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExdno2YzBwcWRkNmF1eXJ2enVhZmY2ZGpkNmJ4bDAzcmtnbWR5cTJweCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/ELrhLxEdwWUXuyYPQW/giphy.gif",
                itemNumberTopic: "PHẦN 1, CỬA 1",
                nameTopic: "Gọi đồ uống",
                title: "CỤM TỪ CHÍNH",
              ),
              SizedBox(height: 16),

              // Câu hỏi & Trả lời
              QuestionWidget(
                prototypeQuestion: "Hello, Ben!",
                translateQuestion: "Xin chào, Ben!",
              ),
              AnswerWidget(
                prototypeAnswer: "Hello, coffee, please!",
                translateAnswer: "Xin chào, Vui lòng cho tôi cafe!",
              ),
              QuestionWidget(
                prototypeQuestion: "Hello, Ben!",
                translateQuestion: "Xin chào, Ben!",
              ),
              AnswerWidget(
                prototypeAnswer: "Hello, coffee, please!",
                translateAnswer: "Xin chào, Vui lòng cho tôi cafe!",
              ),
              QuestionWidget(
                prototypeQuestion: "Hello, Ben!",
                translateQuestion: "Xin chào, Ben!",
              ),
              AnswerWidget(
                prototypeAnswer: "Hello, coffee, please!",
                translateAnswer: "Xin chào, Vui lòng cho tôi cafe!",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
