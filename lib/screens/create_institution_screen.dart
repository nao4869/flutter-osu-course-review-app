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
  //final _contentFocusNode = FocusNode();

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
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ));
    }

    setState(() {
      _isLoading = false;
    });

    // navigate to specific course detail scInstitutionhen save Institution
    Navigator.of(context).pushNamed(ListMajorsScreen.routeName,
        arguments: _editedInstitution.name);

    // pop up message when course successfully added
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('New activity'),
        content: Text('New Review has been created'),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    _form.currentState?.reset();
  }

  @override
  void dispose() {
    // avoid momery leaks
    //_contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseList = Provider.of<Institutions>(context);
    final institutions = courseList.institutions;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          // setting global key in the form
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormField<Institution>(
                  builder: (FormFieldState<Institution> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Institution Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15.0),
                        hintText: 'Please select institution name',
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
                              child: Text(
                                value.name.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  onSaved: (value) {
                    _editedInstitution = Institution(
                      id: value.id.toString(),
                      name: _editedInstitution.name,
                      country: _editedInstitution.country,
                      state: _editedInstitution.state,
                      city: _editedInstitution.city,
                      logo: _editedInstitution.logo,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
