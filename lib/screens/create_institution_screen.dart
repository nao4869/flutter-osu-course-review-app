import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../screens/list_majors_screen.dart';

import '../models/institution.dart';
import '../models/institution_provider.dart';

class CreateInstitutionScreen extends StatefulWidget {
  static const routeName = '/creaInstitution-Institution';

  @override
  _CreateInstitutionScreen createState() => _CreateInstitutionScreen();
}

class _CreateInstitutionScreen extends State<CreateInstitutionScreen> {
  final _nameFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _logoFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _logoController = TextEditingController();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.black,
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nameFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                "CLOSE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        KeyboardAction(
          focusNode: _countryFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                "CLOSE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        KeyboardAction(
          focusNode: _stateFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                "CLOSE",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        KeyboardAction(
          focusNode: _cityFocusNode,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 33.0),
              child: Text(
                "CLOSE",
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
                "CLOSE",
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
  var _editedInstitution = Institution(
    id: null,
    name: '',
    country: '',
    state: '',
    city: '',
    logo: '',
  );

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isLoading = true;
      });

      // retrieve major data from FB
      Provider.of<Institutions>(context).retrieveInstitutionData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  var _initValues = {
    'name': '',
    'country': '',
    'state': '',
    'city': '',
    'logo': '',
  };

  var _starScore = [1, 2, 3, 4, 5];
  var _currentSelectedValue;
  var _currentSelectedValue2;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final insId = ModalRoute.of(context).settings.arguments as String;
      //inal starScores = ModalRoute.of(context).settings.arguments as String;
      if (insId != null) {
        _editedInstitution =
            Provider.of<Institutions>(context, listen: false).findById(insId);
        _initValues = {
          'name': _editedInstitution.name,
          'country': _editedInstitution.country,
          'state': _editedInstitution.state,
          'city': _editedInstitution.city,
          'logo': _editedInstitution.logo,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // save form data by using grobal key
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();

    // error handling for the form value
    if (!isValid) {
      return;
    }

    // only if the form is valid, save the result
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    // if existing items edited
    // if (_editedInstitution.courseId != null) {
    // Provider.of<Institutions>(context, listen: false)
    //       .updateInstitution(_editedInstitution, _editedInstitution.courseId);
    // } else {
    try {
      await Provider.of<Institutions>(context, listen: false)
          .addInstitution(_editedInstitution);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error occured!'),
                content: Text('Some error occInstitutionhile adding products'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
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

    // navigate to specific course detail scInstitutionhen save Institution
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListMajorsScreen(),
        settings: RouteSettings(arguments: _editedInstitution.name),
      ),
    );

    // pop up message when course successfully added
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('New activity'),
        content: Text('New institution has been created'),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
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
    _nameFocusNode.dispose();
    _countryFocusNode.dispose();
    _stateFocusNode.dispose();
    _cityFocusNode.dispose();
    _logoFocusNode.dispose();

    // controller
    _nameController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  Widget _displaySubHeader(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _createFormField(TextEditingController controller, FocusNode focusNode,
      FocusNode nextFocusNode, String labelText, String formTitle) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 13,
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
          _editedInstitution = Institution(
            id: _editedInstitution.id,
            name: formTitle == 'name' ? value : _editedInstitution.name,
            country:
                formTitle == 'country' ? value : _editedInstitution.country,
            state: formTitle == 'state' ? value : _editedInstitution.state,
            city: formTitle == 'city' ? value : _editedInstitution.city,
            logo: formTitle == 'logo' ? value : _editedInstitution.logo,
          );
        },
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
    const title = 'University Institution Search';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                  _displaySubHeader('Create new institution'),
                  _createFormField(
                    _nameController,
                    _nameFocusNode,
                    _countryFocusNode,
                    'Name',
                    'name',
                  ),
                  _createFormField(
                    _countryController,
                    _countryFocusNode,
                    _stateFocusNode,
                    'State',
                    'state',
                  ),
                  _createFormField(
                    _cityController,
                    _cityFocusNode,
                    _logoFocusNode,
                    'City',
                    'city',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
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
                          child: _logoController.text.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Enter a URL'),
                                )
                              : FittedBox(
                                  child: Image.network(
                                    _logoController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Logo or image of school',
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    _logoController.clear();
                                  },
                                ),
                                contentPadding: const EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _logoController,
                              focusNode: _logoFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter an image URL.';
                                }
                                if (!value.startsWith('http') ||
                                    !value.startsWith('https')) {
                                  return 'Please enter a valid URL.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedInstitution = Institution(
                                  id: _editedInstitution.id,
                                  name: _editedInstitution.name,
                                  country: _editedInstitution.country,
                                  state: _editedInstitution.state,
                                  city: _editedInstitution.city,
                                  logo: value,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Raised Button
                  _createRaisedButton('Save Institution'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
