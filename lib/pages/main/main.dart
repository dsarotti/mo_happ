import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mo_happ/routes/routes.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Contenido principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Contenedor de texto
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'The Monty Hall Problem',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Divider(color: Colors.blueAccent, thickness: 1.5),
                        SizedBox(height: 16),
                        Text(
                          'You have three options: one contains a prize, and the other two do not.',
                          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        ),
                        SizedBox(height: 12),
                        Text(
                          '1. You select one option (success probability: 1/3).',
                          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        ),
                        Text(
                          '2. One of the remaining options, which does not contain the prize, is eliminated.',
                          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        ),
                        Text(
                          '3. You can either keep your initial choice or switch to the other option.',
                          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        ),
                        SizedBox(height: 16),
                        Divider(color: Colors.blueAccent, thickness: 1.5),
                        SizedBox(height: 16),
                        Text(
                          'Mathematically:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '- Sticking with your choice: probability = 1/3.',
                          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        ),
                        Text(
                          '- Switching: probability = 2/3.',
                          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Use this simulation to explore how probabilities change with new information.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botón para simulación
                  ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.doors),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Start Simulation',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
