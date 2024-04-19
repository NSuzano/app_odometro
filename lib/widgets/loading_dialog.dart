import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 16,
                        offset: Offset(0, 10),
                      )
                    ]),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Carregando')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
