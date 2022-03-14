import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/test.dart';
import 'package:wasteagram/models/post_entry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBvCpe9guLIg00XMCg7ZiXk8iQBDW0yVuA",
      appId: "1:32938884648:android:fc62f4be55c5b727b1bf1d",
      messagingSenderId: "32938884648",
      projectId: "wasteagram-9aac8",
    ),
  );

  runApp(MyApp());

  // test suite unit tests below
  test('unit test to show post attributes are valid', () {
    const testItems = 5;
    const testLatitude = 4.0;
    const testLongitude = 24.0;

    Entry testing = Entry(
      items: testItems,
      latitude: testLatitude,
      longitude: testLongitude,
    );

    expect(testing.items, testItems);
    expect(testing.latitude, testLatitude);
    expect(testing.longitude, testLongitude);
  });
}
