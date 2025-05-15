import 'package:flutter/material.dart';
import 'package:flutter_imc/calcImc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcualdora IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  void calcular() {
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    double imc = Calcimc.calcularIMC(peso, altura);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(imc: imc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora IMC')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              child: const Text('Calcular IMC'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double imc;

  const ResultScreen({super.key, required this.imc});

  String getResultado() {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc < 25) {
      return 'Peso normal';
    } else if (imc < 30) {
      return 'Sobrepeso';
    } else if (imc < 35) {
      return 'Obesidade Grau I';
    } else if (imc < 40) {
      return 'Obesidade Grau II';
    } else {
      return 'Obesidade Grau III';
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultado = getResultado();
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('IMC: ${imc.toStringAsFixed(2)}', 
                style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(resultado),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
