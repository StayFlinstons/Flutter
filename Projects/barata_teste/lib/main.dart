import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() {
  runApp(const CockroachCrusherApp());
}

class CockroachCrusherApp extends StatelessWidget {
  const CockroachCrusherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cockroach Crusher',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  double roaches = 0; // Contador de baratas esmagadas
  double roachesPerClick = 1; // Baratas por clique
  double roachesPerSecond = 0; // Baratas por segundo
  int slapUpgrade = 0; // Nível do upgrade Tapa
  int slipperUpgrade = 0; // Nível do upgrade Chinelo
  int gunUpgrade = 0; // Nível do upgrade Arma
  int missileUpgrade = 0; // Nível do upgrade Míssil
  late AnimationController _controller;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _loadProgress();
    _startAutoRoaches();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Carrega o progresso salvo
  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      roaches = prefs.getDouble('roaches') ?? 0;
      roachesPerClick = prefs.getDouble('roachesPerClick') ?? 1;
      roachesPerSecond = prefs.getDouble('roachesPerSecond') ?? 0;
      slapUpgrade = prefs.getInt('slapUpgrade') ?? 0;
      slipperUpgrade = prefs.getInt('slipperUpgrade') ?? 0;
      gunUpgrade = prefs.getInt('gunUpgrade') ?? 0;
      missileUpgrade = prefs.getInt('missileUpgrade') ?? 0;
    });
  }

  // Salva o progresso
  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('roaches', roaches);
    await prefs.setDouble('roachesPerClick', roachesPerClick);
    await prefs.setDouble('roachesPerSecond', roachesPerSecond);
    await prefs.setInt('slapUpgrade', slapUpgrade);
    await prefs.setInt('slipperUpgrade', slipperUpgrade);
    await prefs.setInt('gunUpgrade', gunUpgrade);
    await prefs.setInt('missileUpgrade', missileUpgrade);
  }

  // Adiciona baratas por segundo
  void _startAutoRoaches() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        roaches += roachesPerSecond;
        _saveProgress();
      });
    });
  }

  // Lógica de clique na barata
  void _smashRoach() {
    setState(() {
      roaches += roachesPerClick;
      isClicked = true;
      _controller.forward().then((_) {
        _controller.reverse().then((_) {
          setState(() {
            isClicked = false;
          });
        });
      });
      _saveProgress();
    });
  }

  // Lógica de compra de upgrades
  void _buyUpgrade(String type) {
    setState(() {
      switch (type) {
        case 'slap':
          double cost = 10 * (slapUpgrade + 1);
          if (roaches >= cost) {
            roaches -= cost;
            slapUpgrade++;
            roachesPerClick += 1;
          }
          break;
        case 'slipper':
          double cost = 50 * (slipperUpgrade + 1);
          if (roaches >= cost) {
            roaches -= cost;
            slipperUpgrade++;
            roachesPerClick += 5;
          }
          break;
        case 'gun':
          double cost = 100 * (gunUpgrade + 1);
          if (roaches >= cost) {
            roaches -= cost;
            gunUpgrade++;
            roachesPerSecond += 10;
          }
          break;
        case 'missile':
          double cost = 500 * (missileUpgrade + 1);
          if (roaches >= cost) {
            roaches -= cost;
            missileUpgrade++;
            roachesPerSecond += 50;
          }
          break;
      }
      _saveProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kitchen_floor.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // AppBar com fundo transparente
            AppBar(
              title: const Text('Cockroach Crusher'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            // Contador de baratas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Baratas Esmagadas: ${roaches.toInt()}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            // Barata clicável
            Expanded(
              child: GestureDetector(
                onTap: _smashRoach,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: isClicked ? 0.9 : 1.0,
                        child: Image.asset(
                          'assets/images/roach.png',
                          width: 200,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.bug_report,
                            size: 200,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Upgrades
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Baratas por clique: ${roachesPerClick.toInt()}',
                      style: const TextStyle(color: Colors.white)),
                  Text('Baratas por segundo: ${roachesPerSecond.toInt()}',
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: roaches >= 10 * (slapUpgrade + 1)
                              ? () => _buyUpgrade('slap')
                              : null,
                          icon: Image.asset(
                            'assets/images/slap.png',
                            width: 24,
                            height: 24,
                          ),
                          label: Text('Tapa (Custo: ${10 * (slapUpgrade + 1)})'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: roaches >= 50 * (slipperUpgrade + 1)
                              ? () => _buyUpgrade('slipper')
                              : null,
                          icon: Image.asset(
                            'assets/images/slipper.png',
                            width: 24,
                            height: 24,
                          ),
                          label: Text('Chinelo (Custo: ${50 * (slipperUpgrade + 1)})'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: roaches >= 100 * (gunUpgrade + 1)
                              ? () => _buyUpgrade('gun')
                              : null,
                          icon: Image.asset(
                            'assets/images/gun.png',
                            width: 24,
                            height: 24,
                          ),
                          label: Text('Arma (Custo: ${100 * (gunUpgrade + 1)})'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: roaches >= 500 * (missileUpgrade + 1)
                              ? () => _buyUpgrade('missile')
                              : null,
                          icon: Image.asset(
                            'assets/images/missile.png',
                            width: 24,
                            height: 24,
                          ),
                          label: Text('Míssil (Custo: ${500 * (missileUpgrade + 1)})'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}