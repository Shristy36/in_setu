import 'package:flutter/material.dart';
import 'package:in_setu/constants/app_colors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class LinkDeviceScreen extends StatefulWidget {
  const LinkDeviceScreen({super.key});

  @override
  State<LinkDeviceScreen> createState() => _LinkDeviceScreenState();
}

class _LinkDeviceScreenState extends State<LinkDeviceScreen> {
  MobileScannerController _controller = MobileScannerController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            height: 90,
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text("Link Device", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 100,),
                  Image.asset("assets/icons/linkdevice.png"),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ScannerScreen()));
                    },
                    child: Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(
                        child: Text("Scan Now", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),

    );
  }
}

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController _controller = MobileScannerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanning..")),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          final barcode = capture.barcodes.first;
          print("qrData :${barcode.rawValue}");
          Navigator.pop(context, barcode.rawValue);// Return scanned value

        },
      ),
    );
  }
}

