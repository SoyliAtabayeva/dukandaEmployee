import 'dart:io';

import 'package:dukanda_ishgar/homePage/homePage.dart';
import 'package:dukanda_ishgar/services/clientsCard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ClienCardReader extends StatefulWidget {
  const ClienCardReader({Key? key}) : super(key: key);

  @override
  State<ClienCardReader> createState() => _ClienCardReaderState();
}

class _ClienCardReaderState extends State<ClienCardReader> {
  var result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    var isAndroid;
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }

    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen(
      (scanData) {
        if (mounted) {
          controller.dispose();
        }

        setState(() {
          result = scanData.code;
        });
        Future<bool> barcode =
            context.read<ClientCard>().getClientInfo(context, result ?? 0);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => HomePage(
                  selectedPage: 2,
                )),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
