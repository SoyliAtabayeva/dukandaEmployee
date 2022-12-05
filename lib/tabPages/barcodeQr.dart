import 'dart:io';

import 'package:dukanda_ishgar/services/clientsCard.dart';
import 'package:dukanda_ishgar/services/itemBarcodeRequest.dart';
import 'package:dukanda_ishgar/services/negatives.dart';
import 'package:dukanda_ishgar/tabPages/bottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeQrRaeder extends StatefulWidget {
  const BarcodeQrRaeder({Key? key}) : super(key: key);

  @override
  State<BarcodeQrRaeder> createState() => _BarcodeQrRaederState();
}

class _BarcodeQrRaederState extends State<BarcodeQrRaeder> {
  int? result;
  QRViewController? controller;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
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

    controller.scannedDataStream.listen((scanData) {
      if (mounted) {
        controller.dispose();
      }

      setState(() {
        result = int.parse(scanData.code.toString());
      });
      Future<bool> barcode = context.read<ItemId>().getObjectByBarcode(
          context: context,
          barcode: result ?? 0,
          user: context.read<ClientCard>().users,
          clientId: context.read<ClientCard>().user?.id ?? 0,
          cardNo: context.read<ClientCard>().user?.cardNo);

      settingModalBottomSheet(context, false);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
