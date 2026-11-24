import 'package:flutter/material.dart';

void main() {
  runApp(MyAlgoApp());
}

class MyAlgoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Algo Bot',
      theme: ThemeData.dark(),
      home: AlgoHome(),
    );
  }
}

class AlgoHome extends StatefulWidget {
  @override
  _AlgoHomeState createState() => _AlgoHomeState();
}

class _AlgoHomeState extends State<AlgoHome> {
  bool isBotOn = false;
  String selectedStrategy = 'Scalping';
  double quantity = 1;
  String status = 'Bot Stopped';
  List<String> logs = ['App Started...'];

  void toggleBot() {
    setState(() {
      isBotOn = !isBotOn;
      status = isBotOn ? 'Bot Running - $selectedStrategy' : 'Bot Stopped';
      logs.insert(0, '${DateTime.now().hour}:${DateTime.now().minute} - ${isBotOn ? "Bot STARTED" : "Bot STOPPED"}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Algo Bot'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isBotOn ? Colors.green : Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(status, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('NIFTY 50 : 24,850.50  +0.45%', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Select Strategy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedStrategy,
              isExpanded: true,
              items: ['Scalping', 'Breakout', 'Option Buying', 'Intraday']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) { setState(() { selectedStrategy = v!; }); },
            ),
            SizedBox(height: 10),
            Text('Quantity (Lots): ${quantity.toInt()}'),
            Slider(value: quantity, min: 1, max: 10, divisions: 9, onChanged: (v) { setState(() { quantity = v; }); }),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: toggleBot,
                style: ElevatedButton.styleFrom(backgroundColor: isBotOn ? Colors.red : Colors.green),
                child: Text(isBotOn ? 'STOP BOT' : 'START BOT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
            Text('Live Logs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                child: ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (c, i) => Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(logs[i], style: TextStyle(color: Colors.greenAccent, fontSize: 13)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
