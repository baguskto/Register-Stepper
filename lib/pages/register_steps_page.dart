import 'package:bank_jago_assesment/constant.dart';
import 'package:bank_jago_assesment/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
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

  bool hidePassword = true;
  TextEditingController passwordController = TextEditingController();
  bool hasLowercase, hasUppercase, hasDigits, hasMoreThan9Characters = false;

  String goalSelected, incomeSelected, expenseSelected;

  DateTime selectedDate = DateTime.now();
  DateTime selectedTimeIos;
  TimeOfDay selectedTime = TimeOfDay.now();

  String selectedDateFormatted;
  var selectedTimeFormatted;

  Text complexity = Text(
    "Very weak",
    style: TextStyle(color: Colors.amberAccent),
  );

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

  bool passwordFilled() {
    if (hasLowercase == true &&
        hasUppercase == true &&
        hasDigits == true &&
        hasMoreThan9Characters == true) {
      return true;
    } else {
      return false;
    }
  }

  continued() {
    _currentStep < 3
        ? setState(() {
            _currentStep == 0 && isValidEmail(emailController.text)
                ? _currentStep += 1
                : _currentStep == 1 && passwordFilled()
                    ? _currentStep += 1
                    : _currentStep == 2 &&
                            goalSelected.isNotEmpty &&
                            incomeSelected.isNotEmpty &&
                            expenseSelected.isNotEmpty
                        ? _currentStep += 1
                        : _currentStep == 3 &&
                                selectedDateFormatted != null &&
                                selectedTimeFormatted != null
                            ? _currentStep += 1
                            : _showToast(context);
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

  DateTime getDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, 0);
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                    selectedDateFormatted =
                        Constant.dateFormatter(selectedDate);
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        selectedDateFormatted = Constant.dateFormatter(selectedDate);
      });
  }

  /// This builds cupertion time picker in iOS
  buildCupertinoTimePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                minuteInterval: 30,
                use24hFormat: true,
                onDateTimeChanged: (picked) {
                  if (picked != null && picked != selectedTimeIos)
                    setState(() {
                      selectedTimeIos = picked;
                      selectedTimeFormatted =
                          Constant.timeFormatter(selectedTimeIos);
                    });
                },
                initialDateTime: DateTime(
                    selectedDate.minute,
                    selectedDate.month,
                    selectedDate.day,
                    selectedDate.hour,
                    (selectedDate.minute / 5 * 5).toInt())
                // selectedTimeIos,
                ),
          );
        });
  }

  /// This builds material date picker in Android
  buildMaterialTimePicker(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
        selectedTimeFormatted = "${selectedTime.hour}:${selectedTime.minute}";
      });
  }

  void passStatusStrength() {
    if (hasLowercase == true && hasUppercase == true ||
        hasDigits == true ||
        hasMoreThan9Characters == true) {
      complexity = Text("Weak", style: TextStyle(color: Colors.amber));
    }
    if (hasLowercase == true && hasUppercase == true && hasDigits == true ||
        hasMoreThan9Characters == true) {
      complexity = Text("Medium", style: TextStyle(color: Colors.limeAccent));
    }
    if (hasLowercase == true &&
        hasUppercase == true &&
        hasDigits == true &&
        hasMoreThan9Characters == true) {
      complexity = Text("Strong", style: TextStyle(color: Colors.lightGreen));
    }
  }

  passValidator() {
    if (passwordController.text.isNotEmpty) {
      if (passwordController.text.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }
      if (passwordController.text.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }
      if (passwordController.text.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      }
      if (passwordController.text.length > 9) {
        hasMoreThan9Characters = true;
      }

      passStatusStrength();
    } else {
      hasLowercase = false;
      hasUppercase = false;
      hasDigits = false;
      hasMoreThan9Characters = false;
    }
  }

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      setState(() {
        passValidator();
        // return passwordFilled();
      });
    });
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

  Widget passwordPage() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Create Password",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Password will be used to login to account",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: hidePassword,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              hintText: 'Create Password',
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Theme.of(context).focusColor,
                icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
              disabledBorder: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Complexity : ",
                style: TextStyle(color: Colors.white),
              ),
              complexity,
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetPasswordValidationItem(
                title: "a",
                isValid: hasLowercase == true,
                label: "Lowercase",
              ),
              WidgetPasswordValidationItem(
                title: "A",
                isValid: hasUppercase == true,
                label: "Uppercase",
              ),
              WidgetPasswordValidationItem(
                title: "123",
                isValid: hasDigits == true,
                label: "Number",
              ),
              WidgetPasswordValidationItem(
                title: "+9",
                isValid: hasMoreThan9Characters == true,
                label: "Caracters",
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget personalInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Personal Information",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Please fill in the information below and your goal for digital saving.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          WidgetPersonalInfoField(
            label: "Goal of Activation",
            chosenValue: goalSelected,
            options: Constant.personalGoalOption,
            onChange: (String value) {
              setState(() {
                goalSelected = value;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          WidgetPersonalInfoField(
            label: "Monthly Income",
            chosenValue: incomeSelected,
            options: Constant.personalIncomeOption,
            onChange: (String value) {
              setState(() {
                incomeSelected = value;
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          WidgetPersonalInfoField(
            label: "Monthly Expenpense",
            chosenValue: expenseSelected,
            options: Constant.personalExpensesOption,
            onChange: (String value) {
              setState(() {
                expenseSelected = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget videoCallSchedule() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetCalenderAnimation(),
          SizedBox(
            height: 25,
          ),
          Text(
            "Schedule Video Call",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Choose the date and time that you preferred, we will send a link via email to make a video call on the schedule date and time.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          WidgetScheduleField(
            label: "Date",
            onTap: () {
              Theme.of(context).platform == TargetPlatform.iOS
                  ? buildCupertinoDatePicker(context)
                  : buildMaterialDatePicker(context);
            },
            hint: selectedDateFormatted ?? "- Choose date -",
          ),
          SizedBox(
            height: 20,
          ),
          WidgetScheduleField(
            label: "Time",
            onTap: () {
              Theme.of(context).platform == TargetPlatform.iOS
                  ? buildCupertinoTimePicker(context)
                  : buildMaterialTimePicker(context);
            },
            hint: selectedTimeFormatted != null
                ? selectedTimeFormatted.toString()
                : "- Choose time -",
          ),
          SizedBox(
            height: 20,
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
                      content: passwordPage(),
                      isActive: _currentStep >= 2,
                    ),
                    CustomStep(
                      content: personalInfo(),
                      isActive: _currentStep >= 3,
                    ),
                    CustomStep(
                      content: videoCallSchedule(),
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
