import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swipe_deck/swipe_deck.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/constants.dart';
import 'chat_screen.dart';

class ChooseAvatar extends StatefulWidget {
  const ChooseAvatar({Key? key}) : super(key: key);

  static const id = "about_us_screen";

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  var userDp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF000000), Color(0xFF281640)],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xFF000000),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  'Choose Your Avatar',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ],
            ),
            actions: [
              Opacity(
                opacity: 0,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Icon(Icons.ac_unit_rounded)),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: SwipeDeck(
                    aspectRatio: 1,
                    startIndex: 0,
                    onChange: (index) {
                      setState(() {
                        userDp = userArtLinks[index];
                      });
                    },
                    emptyIndicator: const Center(
                      child: SpinKitFoldingCube(
                        color: Color(0xFF8603F1),
                        size: 50.0,
                      ),
                    ),
                    widgets: userArtLinks
                        .map((e) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "images/$e.png",
                                fit: BoxFit.cover,
                              ),
                            ))
                        .toList()),
              ),
              //add button here

              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('userAvatar', userDp);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChatScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle:
                      const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                child: const Text('Next'),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
