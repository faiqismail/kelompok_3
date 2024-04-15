import 'package:flutter/material.dart';
import 'package:note_app/pages/navigasi.dart';


class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 430,
        height: 932,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF35374B)),
        child: Stack(
          children: [
            Positioned(
              left: -7,
              top: 0,
              child: Container(
                width: 437,
                height: 58,
                decoration: BoxDecoration(color: Color(0xFF344955)),
                child: Stack(
                  children: [],
                ),
              ),
            ),
            Positioned(
              left: 47,
              top: 321,
              child: Container(
                width: 335,
                height: 77,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 335,
                        height: 24,
                        child: Text(
                          'Selamat Datang',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF78A083),
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                            height: 0.01,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 26,
                      top: 53,
                      child: SizedBox(
                        width: 283,
                        height: 24,
                        child: Text(
                          'di TriNotes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF78A083),
                            fontSize: 40,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                            height: 0.01,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 71,
              top: 434,
              child: SizedBox(
                width: 287,
                height: 83,
                child: Text(
                  'Mulailah Mencatat Ide, ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF78A083),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0.05,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 71,
              top: 452,
              child: SizedBox(
                width: 287,
                height: 83,
                child: Text(
                  'pengingat, Dan Inspirasi Anda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF78A083),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0.05,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 71,
              top: 474,
              child: SizedBox(
                width: 287,
                height: 83,
                child: Text(
                  ' Tetap Teratur, Tetap ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF78A083),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0.05,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 71,
              top: 494,
              child: SizedBox(
                width: 287,
                height: 83,
                child: Text(
                  ' Terhubung. Selamat Mencatat!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF78A083),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0.05,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 148,
              top: 554,
              child: Container(
                width: 134,
                height: 38,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NextPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF50727B)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      color: Color(0xFFACDCB9),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

