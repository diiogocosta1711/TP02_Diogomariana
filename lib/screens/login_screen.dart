import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final List<Map<String, dynamic>> rankings = [
    {'name': 'Alice', 'score': 10},
    {'name': 'Bob', 'score': 8},
    {'name': 'Charlie', 'score': 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text;
                  String password = passwordController.text;
                  bool success =
                      await Provider.of<AuthService>(context, listen: false)
                          .login(username, password);
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/game');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Erro'),
                        content: Text('Nome de usuário ou senha incorretos'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Fechar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Registrar'),
              ),
              SizedBox(height: 20),
              Text(
                'Ranking',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Consumer<AuthService>(
                builder: (context, authService, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: rankings.length +
                        (authService.loggedInUser != null ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < rankings.length) {
                        return ListTile(
                          leading: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                      } else {
                        // Adiciona o usuário logado no final da lista
                        String loggedInUser = authService.loggedInUser!;
                        int? score = authService.getUserScore(loggedInUser);
                        return ListTile(
                          leading: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            loggedInUser,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: Text(
                            'Score: $score',
                            style: TextStyle(fontSize: 18),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
