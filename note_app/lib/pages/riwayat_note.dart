import 'package:flutter/material.dart';

class Riwayat extends StatefulWidget {
  @override
  _RiwayatState createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  int selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF35374B),
      body: Container(
        width: 430,
        height: 932,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF35374B)),
        child: Stack(
          children: [
            Positioned(
              left: -4,
              top: 0,
              child: Container(
                width: 437,
                height: 58,
                decoration: BoxDecoration(color: Color(0xFF344955)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 391.94,
                      top: 22.85,
                      child: Container(
                        width: 28.35,
                        height: 14.94,
                        child: Stack(
                          children: [
                            // Your stack children here
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 97,
              top: 99,
              child: SizedBox(
                width: 237,
                height: 28,
                child: Text(
                  'Riwayat Hapus',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF78A083),
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.02,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 35,
              top: 160,
              child: SizedBox(
                width: 170,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 0;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return selectedButtonIndex == 0 ?Color(0xF278A083) : Color(0xFF344955);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        side: BorderSide(
                          color: selectedButtonIndex == 0 ? Color(0xF278A083) : Color(0xFF344955),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Folder',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 205,
              top: 160,
              child: SizedBox(
                width: 170,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButtonIndex = 1;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return selectedButtonIndex == 1 ? Color(0xF278A083) :Color(0xFF344955);
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        side: BorderSide(
                          color: selectedButtonIndex == 1 ? Color(0xF278A083) : Color(0xFF344955),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    'Catatan',
                    style: TextStyle(color: Colors.white),
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
