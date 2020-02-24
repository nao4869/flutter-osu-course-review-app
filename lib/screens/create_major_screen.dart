import 'package:flutter/material.dart';
import 'package:osu_course_review/models/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../screens/list_institutions_screen.dart';

import '../models/major.dart';
import '../models/major_provider.dart';
import '../models/institution.dart';
import '../models/institution_provider.dart';

class CreateMajorScreen extends StatefulWidget {
  static const routeName = '/create-major-screen';

  @override
  _CreateMajorScreen createState() => _CreateMajorScreen();
}

class _CreateMajorScreen extends State<CreateMajorScreen> {
  final _majorNameFocusNode = FocusNode();
  final _institutionNameFocusNode = FocusNode();
  final _logoFocusNode = FocusNode();

  final _majorNameController = TextEditingController();
  final _institutionNameController = TextEditingController();
  final _logoController = TextEditingController();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    const _message = 'CLOSE';
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.black,
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _majorNameFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                _message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        KeyboardAction(
          focusNode: _institutionNameFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                _message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        KeyboardAction(
          focusNode: _logoFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                _message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // global key
  final _form = GlobalKey<FormState>();

  // update this edited proInstitutionhen save form
  var _editedMajor = Major(
    id: null,
    institutionName: '',
    majorName: '',
    logo: '',
  );

  var _initValues = {
    'institutionName': '',
    'majorName': '',
    'logo': '',
  };

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      // retrieve major data from FB
      Provider.of<Majors>(context).retrieveMajorData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  var _currentSelectedValue;
  var _currentSelectedValue2;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final majorId = ModalRoute.of(context).settings.arguments as String;
      //inal starScores = ModalRoute.of(context).settings.arguments as String;
      if (majorId != null) {
        _editedMajor =
            Provider.of<Majors>(context, listen: false).findById(majorId);
        _initValues = {
          'institutionName': _editedMajor.institutionName,
          'majorName': _editedMajor.majorName,
          'logo': _editedMajor.logo,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // save form data by using grobal key
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();

    const _errorMessageHead = 'An error occured!';
    const _errorMessageSub = 'Some error occInstitutionhile adding products';

    // pop up message when course successfully added
    const _popupHead = 'New activity';
    const _popupSub = 'New major has been created';
    const _popupButton = 'Okay';

    // error handling for the form value
    if (!isValid) {
      return;
    }

    // only if the form is valid, save the result
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Majors>(context, listen: false).addMajor(_editedMajor);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(_errorMessageHead),
                content: Text(_errorMessageSub),
                actions: <Widget>[
                  FlatButton(
                    child: Text(_popupButton),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  ),
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });

    // navigate to specific course detail scInstitutionhen save Major
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListInstitutionScreen(),
      ),
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_popupHead),
        content: Text(_popupSub),
        actions: <Widget>[
          FlatButton(
            child: Text(_popupButton),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
          ),
        ],
      ),
    );
    _form.currentState?.reset();
  }

  @override
  void dispose() {
    // focus node
    _majorNameFocusNode.dispose();
    _institutionNameFocusNode.dispose();
    _logoFocusNode.dispose();

    // controller
    _majorNameController.dispose();
    _institutionNameController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  Widget _displaySubHeader(String title, ThemeProvider theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: theme.getThemeData == lightTheme
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _createFormField(
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode nextFocusNode,
      String labelText,
      String formTitle,
      ThemeProvider theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 13,
            color:
                theme.getThemeData == lightTheme ? Colors.black : Colors.white,
          ),
          suffixIcon: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.clear,
                size: 20,
              ),
            ),
            onPressed: () {
              controller.clear();
            },
          ),
          contentPadding: const EdgeInsets.all(8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter a course name.';
          } else {
            return null; // no error
          }
        },
        onSaved: (value) {
          _editedMajor = Major(
            id: _editedMajor.id,
            institutionName: formTitle == 'institutionName'
                ? value
                : _editedMajor.institutionName,
            majorName:
                formTitle == 'majorName' ? value : _editedMajor.majorName,
            logo: formTitle == 'logo' ? value : _editedMajor.logo,
          );
        },
      ),
    );
  }

  Widget _displayImagePreview(TextEditingController controller) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.only(
        top: 8,
        right: 10,
      ),
      decoration: BoxDecoration(
          border: Border.all(
        width: 1,
        color: Colors.grey,
      )),
      child: controller.text.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Enter a URL'),
            )
          : FittedBox(
              child: Image.network(
                controller.text,
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  Widget _createRaisedButton(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonTheme(
        minWidth: double.infinity,
        child: RaisedButton(
          onPressed: _saveForm,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final institutionList = Provider.of<Institutions>(context);
    final institutions = institutionList.institutions;
    final theme = Provider.of<ThemeProvider>(context);

    const _title = 'University Course Search';
    const _subHeader = 'Create new major';
    const _buttonText = 'Save Major';

    const _formLabel1 = 'Major name';
    const _formLabel2 = 'Logo or image of school';

    const _formTitle1 = 'majorName';
    const _formTitle2 = 'logo';

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            // setting global key in the form
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _displaySubHeader(_subHeader, theme),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormField<Institution>(
                      builder: (FormFieldState<Institution> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Institution name',
                            labelStyle: TextStyle(
                              fontSize: 18,
                            ),
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 15.0),
                            hintText: 'Please select institution of course',
                            contentPadding: const EdgeInsets.all(8.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<Institution>(
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (Institution newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: institutions.map((Institution value) {
                                return DropdownMenuItem<Institution>(
                                  value: value,
                                  child: Text(value.name.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      onSaved: (value) {
                        _editedMajor = Major(
                          id: _editedMajor.id,
                          institutionName: value.name.toString(),
                          majorName: _editedMajor.majorName,
                          logo: _editedMajor.logo,
                        );
                      },
                    ),
                  ),
                  _createFormField(
                    _majorNameController,
                    _majorNameFocusNode,
                    _logoFocusNode,
                    _formLabel1,
                    _formTitle1,
                    theme,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        _displayImagePreview(_logoController),
                        Expanded(
                          child: _createFormField(
                            _logoController,
                            _logoFocusNode,
                            _logoFocusNode,
                            _formLabel2,
                            _formTitle2,
                            theme,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _createRaisedButton(_buttonText),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
