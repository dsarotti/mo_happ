import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mo_happ/pages/doors/controller/doors_controller.dart';

class DoorButton extends StatelessWidget {
  final int doorNumber;
  final VoidCallback onTap;

  const DoorButton({
    super.key,
    required this.doorNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    DoorsController controller = Get.find<DoorsController>();
    return GestureDetector(
      onTap: onTap,
      child: Obx(() => (doorNumber == controller.revealedDoor.value || (controller.finishedAttempt.value && doorNumber != controller.currentPrizeDoor))
          ? Container(
              width: 120,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.brown[300],
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.brown[400],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                child: Center(
                    child: Center(
                  child: Image.asset(
                    'assets/goat.png',
                    fit: BoxFit.contain,
                    width: 80,
                    height: 80,
                  ),
                )),
              ),
            )
          : (!controller.finishedAttempt.value || doorNumber != controller.currentPrizeDoor)
              ? Container(
                  width: 120,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            color: (controller.isRevealed.value && doorNumber == controller.revealedDoor.value) ? Colors.red : Colors.brown[400],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: controller.userChoice.value == doorNumber ? Colors.green : Colors.black.withOpacity(0.6), // green if it's selected
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Door $doorNumber',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: controller.isRevealed.value ? Colors.white : Colors.black, // wite text if the door is revealed
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              : Container(
                  width: 120,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.brown[400],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.6),
                        width: 2,
                      ),
                    ),
                    child: Center(
                        child: Center(
                      child: Image.asset(
                        'assets/car.png',
                        fit: BoxFit.contain,
                        width: 80,
                        height: 80,
                      ),
                    )),
                  ),
                )),
    );
  }
}
