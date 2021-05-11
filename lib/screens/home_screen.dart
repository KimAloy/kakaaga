import 'package:flutter/material.dart';
import 'package:kakaaga/config/config.dart';
import 'package:kakaaga/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              NavigationItems(
                showSearchIcon: false,
                showGoToHomeScreenIcon: false,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Mazaawo',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: kColorTwo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Agriproducts search with ease',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MySearchTextFieldDummy(
                      onTap: () => showSearch(
                        context: context,
                        delegate: SearchDelegateWidget(),
                      ),
                      text: 'Search for Agriproduct',
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Agriproducts for Sale',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Divider(height: 1),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: Text(
                          //     'Agriproducts Wanted',
                          //     style: TextStyle(fontSize: 15),
                          //   ),
                          // ),
                          // Divider(height: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
