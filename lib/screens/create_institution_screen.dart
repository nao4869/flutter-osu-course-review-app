import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

import '../screens/list_majors_screen.dart';

import '../models/institution.dart';
import '../models/institution_provider.dart';

class CreateInstitutionScreen extends StatefulWidget {
  static const routeName = '/creaInstitution-Institution';

  @override
  _CreateInstitutionScreen createState() => _CreateInstitutionScreen();
}

class _CreateInstitutionScreen extends State<CreateInstitutionScreen> {
  final _countryFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _logoFocusNode = FocusNode();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _logoController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Course Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // setting global key in the form
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Create New Institution',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Institution name',
                    labelStyle: TextStyle(
                      fontSize: 13,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onPressed: () {
                        _nameController.clear();
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_countryFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter an institution name.';
                    } else {
                      return null; // no error
                    }
                  },
                  onSaved: (value) {
                    _editedInstitution = Institution(
                      id: _editedInstitution.id,
                      name: value,
                      country: _editedInstitution.country,
                      state: _editedInstitution.state,
                      city: _editedInstitution.city,
                      logo: _editedInstitution.logo,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Country',
                    labelStyle: TextStyle(
                      fontSize: 13,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onPressed: () {
                        _countryController.clear();
                      },
                    ),
                  ),
                  controller: _countryController,
                  textInputAction: TextInputAction.done,
                  focusNode: _countryFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_stateFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a country of institution name.';
                    } else {
                      return null; // no error
                    }
                  },
                  onSaved: (value) {
                    _editedInstitution = Institution(
                      id: _editedInstitution.id,
                      name: _editedInstitution.name,
                      country: value,
                      state: _editedInstitution.state,
                      city: _editedInstitution.city,
                      logo: _editedInstitution.logo,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'State',
                    labelStyle: TextStyle(
                      fontSize: 13,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onPressed: () {
                        _stateController.clear();
                      },
                    ),
                  ),
                  controller: _stateController,
                  textInputAction: TextInputAction.done,
                  focusNode: _stateFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_cityFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a state of institution.';
                    } else {
                      return null; // no error
                    }
                  },
                  onSaved: (value) {
                    _editedInstitution = Institution(
                      id: _editedInstitution.id,
                      name: _editedInstitution.name,
                      country: _editedInstitution.country,
                      state: value,
                      city: _editedInstitution.city,
                      logo: _editedInstitution.logo,
                    );
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'City',
                    labelStyle: TextStyle(
                      fontSize: 13,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 18,
                      ),
                      onPressed: () {
                        _cityController.clear();
                      },
                    ),
                  ),
                  controller: _cityController,
                  textInputAction: TextInputAction.done,
                  focusNode: _cityFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_logoFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a city of institution.';
                    } else {
                      return null; // no error
                    }
                  },
                  onSaved: (value) {
                    _editedInstitution = Institution(
                      id: _editedInstitution.id,
                      name: _editedInstitution.name,
                      country: _editedInstitution.country,
                      state: _editedInstitution.state,
                      city: value,
                      logo: _editedInstitution.logo,
                    );
                  },
                ),
                Row(
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
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL.';
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
                  ],
                ),
                // Raised Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonTheme(
                    minWidth: double.infinity,
                    child: RaisedButton(
                      onPressed: _saveForm,
                      child: Text(
                        "Save Institution",
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
                  // to do, add clear form button
                  // to do, add save and add another button
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
