import 'package:flutter/material.dart';
import 'package:kakaaga/api/auth_service.dart';
import 'package:kakaaga/brews/brew_model.dart';
import 'package:kakaaga/brews/database_service_brew.dart';
import 'package:kakaaga/brews/user_data.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/models/models.dart';
import 'package:kakaaga/widgets/widgets.dart';
import 'package:provider/provider.dart';

class BrewListScreen extends StatefulWidget {
  @override
  _BrewListScreenState createState() => _BrewListScreenState();
}

class _BrewListScreenState extends State<BrewListScreen> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseServiceBrew().brews,
      initialData: [],
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => _authService.signOut())
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _showSettingsPanel,
                ),
              ],
            ),
            BrewList(),
          ],
        )),
      ),
    );
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: SettingsForm(),
          );
        });
  }
}

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    // brews.forEach((brew) {
    //   print(brew.name);
    //   print(brew.sugars);
    //   print(brew.strength);
    // });
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text('Brew List Class'),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: brews.length,
              itemBuilder: (context, index) {
                return BrewTile(brew: brews[index]);
              }),
        ],
      ),
    );
  }
}

class BrewTile extends StatefulWidget {
  final Brew brew;

  const BrewTile({Key? key, required this.brew}) : super(key: key);

  @override
  _BrewTileState createState() => _BrewTileState();
}

class _BrewTileState extends State<BrewTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${widget.brew.name!}'),
            Text('Strength: ${widget.brew.strength!.toString()}'),
            Text('Sugars: ${widget.brew.sugars!}'),
          ],
        ),
      ),
    );
  }
}

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;
  final List<String> sugars = ['0', '1', '2', '3', '4'];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseServiceBrew(uid: user!.uid).userData,
        builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something went wrong');
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          // return Text("Loading");
          // return Center(
          //   child: CircularProgressIndicator(
          //     valueColor: AlwaysStoppedAnimation<Color>(kColorOne),
          //   ),
          // );
          // }
          /// This helps when the data is still being fetched, otherwise the
          /// screen will error "Null check operator used on a null value"
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kColorOne),
              ),
            );
          }
          UserData? userData = snapshot.data!;
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Update your brew settings'),
                        SizedBox(height: 20),
                        Text('Name'),
                        TextFormField(
                          initialValue: userData.name,
                          decoration: kTextFormFieldDecoration,
                          validator: (val) =>
                              val!.isEmpty ? 'Please enter a name' : null,
                          onChanged: (val) =>
                              setState(() => _currentName = val),
                        ),
                        SizedBox(height: 20),
                        Text('Sugars'),
                        DropdownButtonFormField(
                          decoration: kTextFormFieldDecoration,

                          /// This is the default value of the dropdownformfield
                          value: _currentSugars ?? userData.sugars,
                          items: sugars.map((sugar) {
                            return DropdownMenuItem(
                              /// this is the current selected value of the dropdownformfield
                              value: sugar,
                              child: Text('$sugar sugars'),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _currentSugars = val.toString()),
                        ),
                        SizedBox(height: 20),
                        Text('Strength'),
                        Slider(
                          value: (_currentStrength ??
                                  int.parse(userData.strength!))
                              .toDouble(),
                          // value: (_currentStrength ?? 100).toDouble(),
                          activeColor: Colors.teal[_currentStrength ?? 100],
                          inactiveColor:
                              Colors.tealAccent[_currentStrength ?? 100],
                          min: 100,
                          max: 900,
                          divisions: 8,
                          onChanged: (val) =>
                              setState(() => _currentStrength = val.round()),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: MyOutlineButton(
                            /// this is async because we will be using it in firebase
                            onPressed: () async {
                              print('Print: update brew list button pressed');

                              if (_formKey.currentState!.validate()) {
                                await DatabaseServiceBrew(uid: user.uid)
                                    .updateUserData(
                                  (_currentSugars ?? userData.sugars)!,
                                  (_currentName ?? userData.name)!,
                                  _currentStrength ??
                                      int.parse(userData.strength!),
                                );
                                Navigator.pop(context);
                                print(_currentName);
                                print(_currentSugars);
                                print(_currentStrength);
                              }
                            },
                            text: 'Update',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
