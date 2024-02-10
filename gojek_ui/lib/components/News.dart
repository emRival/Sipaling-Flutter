import 'package:flutter/material.dart';
import 'package:gojek_ui/datas/news.dart';
import 'package:gojek_ui/theme.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/gopaylater.png',
                width: 98,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Lebih hemat pake GoPayLater",
                style: bold16.copyWith(color: dark1),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Yuk, belanja di Tokopedia pake GoPay Later dan nikmatin cashback-nya~",
                style: regular14.copyWith(color: dark1),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        //News
        ...news.map(
          (news) => Padding(
            padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffE8E8E8),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/${news.image}'),
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          news.title,
                          style: bold16.copyWith(color: dark1),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          news.desription,
                          style: regular14.copyWith(color: dark1),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
