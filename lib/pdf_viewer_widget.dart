import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerWidget extends StatefulWidget {
  const PdfViewerWidget({Key? key}) : super(key: key);

  @override
  State<PdfViewerWidget> createState() => _PdfViewerWidgetState();
}

class _PdfViewerWidgetState extends State<PdfViewerWidget> {
  late PdfControllerPinch pdfPinchController;
  late PdfController pdfController;

  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTap() {
    if (pdfPinchController.value != Matrix4.identity()) {
      pdfPinchController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      // For a 3x zoom
      pdfPinchController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }

  @override
  void initState() {
    super.initState();
    pdfPinchController = PdfControllerPinch(
      viewportFraction: 2.0,
      document: PdfDocument.openAsset('assets/sample.pdf'),
    );
    pdfController = PdfController(
      viewportFraction: 1.0,
      document: PdfDocument.openAsset('assets/sample.pdf'),
    );
  }

  @override
  void dispose() {
    pdfPinchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 800,
          height: 800,
          child: GestureDetector(
            onDoubleTapDown: (d) => _doubleTapDetails = d,
            onDoubleTap: _handleDoubleTap,
            child: PdfViewPinch(
              controller: pdfPinchController,
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Image.asset("assets/icons/zoom_minus.png", width: 24, height: 24),
              iconSize: 24,
              onPressed: () {
                pdfPinchController.goTo(destination: Matrix4.identity());
              },
            ),
            SizedBox(width: 8),
            Container(
              decoration:
                  BoxDecoration(color: Color(0xff233160), borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(
                  '150%',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Image.asset("assets/icons/zoom_plus.png", width: 24, height: 24),
              iconSize: 24,
              onPressed: () {
                pdfPinchController.goTo(destination: Matrix4.identity().scaled(3.0));
              },
            )
          ],
        ),
        // TextButton(
        //     onPressed: () {
        //       pdfPinchController.value = Matrix4.identity()..scale(3.0);
        //       // setState(() {});
        //     },
        //     child: Text("zoom in")),
        // TextButton(
        //     onPressed: () {
        //       pdfPinchController.value = Matrix4.identity();
        //       // setState(() {});
        //     },
        //     child: Text("zoom out"))
      ],
    );

    // return Row(
    //   children: [SizedBox(
    //     width: 800,
    //     height: 800,
    //     child: PdfView(
    //       controller: pdfController,
    //       scrollDirection: Axis.vertical,
    //       renderer: (PdfPage page) => page.render(
    //         width: page.width * 5,
    //         height: page.height * 5,
    //         format: PdfPageImageFormat.jpeg,
    //         backgroundColor: '#FFFFFF',
    //         quality: 100,
    //       ),
    //     ),
    //   ), TextButton(onPressed: () {
    //   }, child: Text("zoom"))],
    // );

    // return Column(
    //   children: [
    //     // TextButton(
    //     //     onPressed: () {
    //     //       //pdfPinchController.document.
    //     //     },
    //     //     child: const Text("zoom")),
    //     Expanded(
    //       child: SizedBox(
    //         width: 500,
    //         child: PdfViewPinch(
    //           controller: pdfPinchController,
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }
}
