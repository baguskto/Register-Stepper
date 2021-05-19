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
  TextEditingController emailController = TextEditingController();


  bool isValidEmail(input) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
  }

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


  Widget emailPage() {
    return Container(
      color: Colors.lightBlue,
      height: MediaQuery.of(context).size.height / 1.5,
      child: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / 3.5,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  (MediaQuery.of(context).size.width * 0.74875).toDouble()),
              painter: WidgetBgEmailPath(),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 20,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                    Row(
                      children: [
                        Text(
                          "GIN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Finans",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 36,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome to The Bank of The Future.\nManage and track your accounts on\nthe go.",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 48,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => emailController.text = input,
                        validator: (input) =>
                        !isValidEmail(input) ? "Email tidak valid" : null,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          labelText: "Email",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'example@email.com',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.mail_outline_rounded,
                              color: Colors.grey),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
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
                      content: emailPage(),
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
