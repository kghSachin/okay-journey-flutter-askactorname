import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task3/constants/constants.dart';
import 'package:task3/screens/show_image_screen.dart';
import 'package:task3/widgets/text_field.dart';
import 'package:task3/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // List<File> _images = [];
  File? _image;
  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final tempImage = File(image.path);
      // _images.add(tempImage);

      setState(
        () {
          _image = tempImage;
        },
      );
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Main Page',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: Constants.askName,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       getImage();
            //     },
            // child: const Text("getImages")),
            // ElevatedButton(
            //   onPressed: () {
            //     String valuee = _controller.text;
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => ShowImage(
            //                   showImage: _image,
            //                   text: valuee,
            //                 )));
            //     _controller.clear();
            //   },
            //   child: const Text("data"),
            // ),
            // ShowImage(showImage: _image),
            const SizedBox(
              height: 10,
            ),
            TextFieldWid(controller: _controller),
            const SizedBox(
              height: 50,
            ),
            const TextWidget(
              text: Constants.pickPhoto,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 10,
            ),

            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Colors.deepPurpleAccent),
              ),
              onPressed: () async {
                try {
                  await getImage();
                  if (_image != null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(5),
                          ),
                        ),
                        backgroundColor: Colors.green,
                        content: Text(Constants.snackbarText),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(Constants.snackbarText2),
                    ),
                  );
                }
              },
              child: const Text("Pick Image"),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  String valuee = _controller.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowImage(
                        showImage: _image,
                        text: valuee,
                      ),
                    ),
                  );
                  _controller.clear();
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
