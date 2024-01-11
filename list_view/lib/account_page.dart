import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
   AccountPage({super.key});

  var faker = new Faker();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return cardWidget(
          image: "https://picsum.photos/id/$index/200/300",
          title: faker.person.name(),
          subtitle: faker.lorem.sentence(),
        );
      },
    );
  }
}

// ignore: camel_case_types
class cardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  cardWidget({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Text("10:00"),
          ),
          Container(
            height: 200,
            color: Colors.amber,
            child: Image.network(
              image,
              fit: BoxFit.fill,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
