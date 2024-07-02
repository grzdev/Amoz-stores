import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 247, 248),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // change the font family to a san serif and increase the font weight to make it visible
            Text(
              'Welcome to',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 69, 184, 238), fontFamily: 'sans-serif', fontWeight: FontWeight.bold),
            ),
            Text(
              'Amoz Stores',
              style: TextStyle(fontSize: 40, color: Color.fromARGB(255, 69, 184, 238),  fontFamily: 'sans-serif', fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 245, 247, 248),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.5, right: 5.5, bottom: 25.0),
          child: Center(
            child: SizedBox(
              width: 200, // Set the desired width
              height: 60, // Set the desired height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 69, 184, 238),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}