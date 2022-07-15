import 'package:flutter/material.dart';

class AddTrip extends StatefulWidget {
  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  int _activeStepIndex = 0;

  bool _isLoading = false;
  TextEditingController tocontroller = TextEditingController();
  TextEditingController fromcontroller = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userMobileController = TextEditingController();
  TextEditingController startTimecontroller = TextEditingController();
  TextEditingController endTimecontroller = TextEditingController();
  TextEditingController bookedByTypeController = TextEditingController();
  TextEditingController bookedByNameController = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Address'),
          content: Column(
            children: [
              TextField(
                controller: tocontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'To',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: fromcontroller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'From',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: userNameController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UserName',
                ),
              ),
            ],
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Step 2'),
            content: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: userMobileController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: startTimecontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Start Time',
                  ),
                ),
              ],
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Confirm'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('To: ${tocontroller.text}'),
                Text('From: ${fromcontroller.text}'),
                Text('Username: ${userNameController.text}'),
                Text('Address : ${userMobileController.text}'),
                Text('PinCode : ${startTimecontroller.text}'),
              ],
            ))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Trips"),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                    margin: const EdgeInsets.all(8.0),
                    //begin the form
                    child: Column(children: <Widget>[
                      Stepper(
                        type: StepperType.vertical,
                        currentStep: _activeStepIndex,
                        steps: stepList(),
                        onStepContinue: () {
                          if (_activeStepIndex < (stepList().length - 1)) {
                            setState(() {
                              _activeStepIndex += 1;
                            });
                          } else {
                            print('Submited');
                          }
                        },
                        onStepCancel: () {
                          if (_activeStepIndex == 0) {
                            return;
                          }

                          setState(() {
                            _activeStepIndex -= 1;
                          });
                        },
                        onStepTapped: (int index) {
                          setState(() {
                            _activeStepIndex = index;
                          });
                        },
                        controlsBuilder: (context,
                            {onStepContinue, onStepCancel}) {
                          final isLastStep =
                              _activeStepIndex == stepList().length - 1;
                          return Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: onStepContinue,
                                  child: (isLastStep)
                                      ? const Text('Submit')
                                      : const Text('Next'),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              if (_activeStepIndex > 0)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: onStepCancel,
                                    child: const Text('Back'),
                                  ),
                                )
                            ],
                          );
                        },
                      )
                    ]))));
  }
}
