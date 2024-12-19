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
        padding: const EdgeInsets.only(top: 8.0),
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
                  () => controller.stopAutopilot
                      ? Column(
                          children: [
                            if (controller.userChoice.value == 0) ...[
                              ElevatedButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Settings'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Speed (10 - 1500ms)',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Obx(
                                            () => Slider(
                                              value: controller.autopilotSpeed.value.toDouble(),
                                              min: 10,
                                              // min speed
                                              max: 1500,
                                              // max speed
                                              divisions: 15,
                                              // 100 ms steps
                                              label: '${controller.autopilotSpeed.value} ms',
                                              onChanged: (value) {
                                                controller.autopilotSpeed.value = value.toInt(); // update local slider value
                                              },
                                            ),
                                          ),
                                          const Text(
                                            'Choice',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Obx(() {
                                                controller.autopilotChoice.value;
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    controller.autopilotChoice.value = true;
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<Color>(controller.autopilotChoice.value ? Colors.blue : Colors.white),
                                                    foregroundColor:
                                                        WidgetStateProperty.all<Color>(controller.autopilotChoice.value ? Colors.white : Colors.blue),
                                                  ),
                                                  child: const Text('Switch'),
                                                );
                                              }),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Obx(() {
                                                controller.autopilotChoice.value;
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    controller.autopilotChoice.value = false;
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<Color>(controller.autopilotChoice.value ? Colors.white : Colors.blue),
                                                    foregroundColor:
                                                        WidgetStateProperty.all<Color>(controller.autopilotChoice.value ? Colors.blue : Colors.white),
                                                  ),
                                                  child: const Text("Don't switch"),
                                                );
                                              }),
                                            ],
                                          )
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.startAutopilot();
                                            Get.back();
                                          },
                                          child: const Text('Accept'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Text("start autopilot"),
                              ),
                            ],
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
                            if (controller.finishedAttempt.value) ...[
                              ElevatedButton(
                                onPressed: () {
                                  controller.startNewAttempt();
                                },
                                child: const Text("Start new attempt"),
                              ),
                            ]
                          ],
                        )
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.stopAutopilot = true;
                              },
                              child: const Text("Stop autopilot"),
                            ),
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
