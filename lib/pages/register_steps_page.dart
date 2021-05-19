import 'package:bank_jago_assesment/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegisterSteps extends StatefulWidget {
  @override
  _RegisterStepsState createState() => _RegisterStepsState();
}

class _RegisterStepsState extends State<RegisterSteps> {
  int _currentStep = 0;
  CustomStepperType stepperType = CustomStepperType.vertical;
  Color bgColor = Colors.white;

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1000),
        content: Text('Fill the field correctly'),
      ),
    );
  }

  tapped(int step) {
    setState(() {
      _currentStep = step;
      changeBgColor(step);
    });
    print(_currentStep);
  }

  changeBgColor(int step) {
    setState(() {
      if (step == 0) {
        bgColor = Colors.white;
      } else {
        bgColor = Colors.lightBlue;
      }
    });
  }

  continued() {
    _currentStep < 3
        ? setState(() {
            _currentStep += 1;
          })
        : _showToast(context);
    changeBgColor(_currentStep);
  }

  cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
        changeBgColor(_currentStep);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Visibility(
          visible: _currentStep != 0,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => cancel(),
          ),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
        title: Visibility(
            visible: _currentStep != 0, child: Text('Create Account')),
      ),
      body: Theme(
        data: ThemeData(primaryColor: Colors.green),
        child: Container(
          color: bgColor,
          child: Column(
            children: [
              Expanded(
                child: CustomStepper(
                  type: CustomStepperType.horizontal,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  controlsBuilder: (BuildContext context,
                      {onStepContinue, onStepCancel}) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: WidgetButtonNext(
                        onPressed: onStepContinue,
                      ),
                    );
                  },
                  steps: <CustomStep>[
                    CustomStep(
                      content: Container(
                        child: Text("1"),
                      ),
                      isActive: _currentStep >= 1,
                    ),
                    CustomStep(
                      content: Container(
                        child: Text("2"),
                      ),
                      isActive: _currentStep >= 2,
                    ),
                    CustomStep(
                      content: Container(
                        child: Text("3"),
                      ),
                      isActive: _currentStep >= 3,
                    ),
                    CustomStep(
                      content: Container(
                        child: Text("4"),
                      ),
                      isActive: _currentStep >= 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
