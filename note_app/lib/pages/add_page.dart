import 'package:flutter/material.dart';

class addnote extends StatelessWidget {
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
                  'Tambah Folder',
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
          ],
        ),
      ),
    );
  }
}
