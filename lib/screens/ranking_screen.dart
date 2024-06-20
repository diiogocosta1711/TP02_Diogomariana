import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rankings = [
    {'name': 'Joao', 'score': 10},
    {'name': 'Tiago', 'score': 8},
    {'name': 'Raquel', 'score': 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking'),
      ),
      body: ListView.builder(
        itemCount: rankings.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            title: Text(
              rankings[index]['name'],
              style: TextStyle(fontSize: 18),
            ),
            trailing: Text(
              'Score: ${rankings[index]['score']}',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}
