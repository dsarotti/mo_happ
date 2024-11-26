import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mo_happ/pages/doors/controller/doors_controller.dart';

import 'widgets/door_button.dart';

class Doors extends StatelessWidget {
  const Doors({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoorsController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monty Hall Simulation'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Choose a Door',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DoorButton(
                    doorNumber: 1,
                    onTap: () {
                      if (controller.userChoice.value == 0) {
                        controller.userSelectDoor(1);
                      }
                    },
                  ),
                  DoorButton(
                    doorNumber: 2,
                    onTap: () {
                      if (controller.userChoice.value == 0) {
                        controller.userSelectDoor(2);
                      }
                    },
                  ),
                  DoorButton(
                    doorNumber: 3,
                    onTap: () {
                      if (controller.userChoice.value == 0) {
                        controller.userSelectDoor(3);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => Column(
                    children: [
                      if (controller.userChoice.value != 0 && !controller.isRevealed.value && !controller.finishedAttempt.value) ...[
                        ElevatedButton(
                          onPressed: () {
                            controller.revealNonPrizeDoor();
                          },
                          child: const Text("Reveal a Door"),
                        ),
                      ],
                      if (controller.isRevealed.value && !controller.finishedAttempt.value) ...[
                        ElevatedButton(
                          onPressed: () {
                            controller.userChangeChoice();
                          },
                          child: const Text("Switch Door"),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            controller.finalizeChoice();
                          },
                          child: const Text("Finalize Choice"),
                        ),
                      ],
                      if (controller.finishedAttempt.value)...[
                        ElevatedButton(
                          onPressed: () {
                            controller.startNewAttempt();
                          },
                          child: const Text("Start new attempt"),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => Row(
                  children: [
                    Expanded(
                      child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current correct: ${controller.currentPrizeDoor}',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Attempts: ${controller.totalAttempts.value}',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Correct: ${controller.correctAttempts.value}',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Incorrect: ${controller.incorrectAttempts.value}',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Success Rate: ${(controller.successRate * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  'Failure Rate: ${(controller.failureRate * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
