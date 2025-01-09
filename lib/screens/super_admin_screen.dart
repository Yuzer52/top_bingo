import 'dart:convert';
import 'package:bingocaller/screens/main_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bingocaller/assets/Utils/app_styles.dart';
import 'package:bingocaller/widgets/custom_button.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {
  String setAdminUsername = "";
  String setAdminPassword = "";
  String adminUserName = "";
  String adminpassWord = "";

  final String safetyUsername = "superTopBadmin";
  final String safetyPassword = "super@rgfbn\$3454Btsxw";

  bool _isLoggedIn = false;
  List<dynamic> gameRecords = [];

  @override
  void initState() {
    super.initState();
    loadGameRecords();
    loadCredentials();
  }

  Future<void> loadGameRecords() async {
  final prefs = await SharedPreferences.getInstance();
  final String? encodedRecords = prefs.getString('superGameRecords');
  if (encodedRecords != null) {
    setState(() {
      gameRecords = json.decode(encodedRecords);
    });
  }
}

  Future<void> loadCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    setAdminUsername = prefs.getString('superAdminUsername') ?? "superadmin";
    setAdminPassword = prefs.getString('superAdminPassword') ?? "superpassword";
  });
}

  Future<void> saveCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('superAdminUsername', setAdminUsername);
  await prefs.setString('superAdminPassword', setAdminPassword);
}


  
Future<void> saveGameRecords() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('superGameRecords', json.encode(gameRecords));
}

  Future<void> clearAllRecords() async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear All Records'),
          content: const Text(
              'Are you sure you want to clear all game records? This action cannot be undone.'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(false),
            ),
            TextButton(
              child: const Text('Clear'),
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() {
        gameRecords.clear();
      });
      await saveGameRecords();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All game records have been cleared.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 152, 213, 1),
         title: const Text("Super Admin Screen"),
        actions: [
          if (_isLoggedIn)
            IconButton(
              icon: const Icon(Icons.security),
              onPressed: _showChangeCredentialsDialog,
            ),
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const MainLayoutScreen())),
          ),
        ],
      ),
      body: _isLoggedIn ? _buildMainContent() : _buildLoginForm(),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) => setState(() => adminUserName = value),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              obscureText: true,
              onChanged: (value) => setState(() => adminpassWord = value),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: "Login",
              onPressed: _login,
              foregroundColor: AppTheme.light,
              backgroundColor: AppTheme.dark,
              isEnabled: true,
              buttonFontSize: 30,
              buttonHeight: 20,
              buttonWidth: 20,
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _showForgotPasswordDialog,
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildMainContent() {
    double totalProfit = gameRecords.fold(0.0, (sum, record) {
      double price = record['pay'];
      int numberOfPlayers = record['playerCount'];
      double winnings = record['winnings'];
      double profit = (numberOfPlayers * price) - winnings;
      
      if (record['wonWithLuckyNumber'] == true) {
        profit -= record['bonusAmount'] ?? 0;
      }
      
      return sum + profit;
    });
  SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('totalProfitAmount', totalProfit);
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Profit: \$${totalProfit.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        Expanded(
          child: gameRecords.isEmpty
              ? const Center(child: Text('No game records found.'))
              : ListView.builder(
                  itemCount: gameRecords.length,
                  itemBuilder: (context, index) {
                    final record = gameRecords[index];
                    double price = record['pay'];
                    int numberOfPlayers = record['playerCount'];
                    double winnings = record['winnings'];
                    double profit = (numberOfPlayers * price) - winnings;
                    
                    if (record['wonWithLuckyNumber'] == true) {
                      profit -= record['bonusAmount'] ?? 0;
                    }

                    return ListTile(
                      minLeadingWidth: 20,
                      minTileHeight: 200,
                      title: Text(
                        'Game ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DATE: ${record['date']}, \nNumber of Players: ${record['playerCount']}',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          if (record['wonWithLuckyNumber'] == true)
                            Text(
                              'Won with Lucky Number! Bonus: \$${record['bonusAmount']}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'PRICE: \$${record['pay']}  ',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Winnings: \$${record['winnings']}  ',
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          Text(
                            'Profit: \$${profit.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => _showDeleteDialog(index),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomElevatedButton(
            text: "Clear All Records",
            onPressed: clearAllRecords,
            foregroundColor: AppTheme.light,
            backgroundColor: Colors.green,
            isEnabled: true,
            buttonFontSize: 30,
            buttonHeight: 20,
            buttonWidth: 20,
          ),
        ),
      ],
    );
}


  void _login() {
    if (adminUserName == setAdminUsername &&
        adminpassWord == setAdminPassword) {
      setState(() {
        _isLoggedIn = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Game'),
          content: const Text('Are you sure you want to delete this game?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteRecord(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteRecord(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Game record ${index + 1} was deleted.')),
    );
    setState(() {
      gameRecords.removeAt(index);
    });
    saveGameRecords();
  }

  void _showChangeCredentialsDialog() {
    String oldUsername = "";
    String oldPassword = "";
    String newUsername = "";
    String newPassword = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Admin Credentials'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Current Username'),
                  onChanged: (value) => oldUsername = value,
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Current Password'),
                  obscureText: true,
                  onChanged: (value) => oldPassword = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'New Username'),
                  onChanged: (value) => newUsername = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: true,
                  onChanged: (value) => newPassword = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Change'),
              onPressed: () {
                if (oldUsername == setAdminUsername &&
                    oldPassword == setAdminPassword) {
                  setState(() {
                    setAdminUsername = newUsername;
                    setAdminPassword = newPassword;
                  });
                  saveCredentials();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Credentials updated successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Current credentials are incorrect')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showForgotPasswordDialog() {
    String enteredUsername = "";
    String enteredPassword = "";
    String newUsername = "";
    String newPassword = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Credentials'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Safety Username'),
                onChanged: (value) => enteredUsername = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Safety Password'),
                obscureText: true,
                onChanged: (value) => enteredPassword = value,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: 'New Username'),
                onChanged: (value) => newUsername = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
                onChanged: (value) => newPassword = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                if (enteredUsername == safetyUsername &&
                    enteredPassword == safetyPassword) {
                  if (newUsername.isNotEmpty && newPassword.isNotEmpty) {
                    setState(() {
                      setAdminUsername = newUsername;
                      setAdminPassword = newPassword;
                    });
                    saveCredentials();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Credentials updated successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'New username and password cannot be empty')),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Incorrect safety credentials')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
