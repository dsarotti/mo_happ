import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';

class DoorsController extends GetxController {
  var totalAttempts = 0.obs;
  var correctAttempts = 0.obs;
  var incorrectAttempts = 0.obs;

  var userChoice = 0.obs; // 0 means no choice, 1, 2, or 3 means a door
  var revealedDoor = 0.obs; // Door that gets revealed
  var isRevealed = false.obs; // Whether a door has been revealed or not
  var currentPrizeDoor = 0; // the door that contains the prize in the current try
  var finishedAttempt = false.obs;

  //Autopilot related
  var stopAutopilot = true;
  var autopilotSwitchDoors = false; //Whether or not the autopilot will choose to switch doors after a goat door is revealed

  void startNewAttempt() {
    finishedAttempt.value = false;
    userChoice.value = 0;
    revealedDoor.value = 0;
    isRevealed.value = false;
    currentPrizeDoor = Random().nextInt(3) + 1;
  }

  void userSelectDoor(int doorSelected) {
    userChoice.value = doorSelected;
  }

  void revealNonPrizeDoor() {
    List<int> possibleDoors = [1, 2, 3];
    possibleDoors.remove(userChoice.value);
    possibleDoors.remove(currentPrizeDoor);

    if (possibleDoors.length > 1) {
      revealedDoor.value = possibleDoors[Random().nextInt(possibleDoors.length - 1)];
    } else {
      revealedDoor.value = possibleDoors.first;
    }
    isRevealed.value = true;
  }

  void userChangeChoice() {
    userChoice.value = 6 - userChoice.value - revealedDoor.value; // Since the doors add up to 6 (1 + 2 + 3)
  }

  void finalizeChoice() {
    if (userChoice.value == currentPrizeDoor) {
      correctAttempts++;
    } else {
      incorrectAttempts++;
    }
    totalAttempts++;
    finishedAttempt.value = true;
  }

  double get successRate => totalAttempts.value > 0 ? (correctAttempts.value / totalAttempts.value) : 0.0;

  double get failureRate => totalAttempts.value > 0 ? (incorrectAttempts.value / totalAttempts.value) : 0.0;

  Future<void> autopilot() async {
    while (!stopAutopilot) {
      //Start new attempt to clear the status
      startNewAttempt();
      await Future.delayed(Duration(seconds: 1));

      userSelectDoor(Random().nextInt(3) + 1);
      await Future.delayed(Duration(seconds: 1));

      revealNonPrizeDoor();
      await Future.delayed(Duration(seconds: 1));

      if (autopilotSwitchDoors) {
        userChangeChoice();
        await Future.delayed(Duration(seconds: 1));
      }

      finalizeChoice();
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  void onInit() {
    startNewAttempt();
    super.onInit();
  }
}
