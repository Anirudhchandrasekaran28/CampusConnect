import 'package:campusconnect/frontend/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Letter spacing control
const double kLetterSpacing = 2.4;
const double jLetterSpacing = 1.4;

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanning = false; // ✅ Track if scanning is active
  String scannedData = "Tap Scan to Continue";

  // ✅ Initialize QR Scanner Controller (Back Camera)
  MobileScannerController cameraController = MobileScannerController(
    facing: CameraFacing.back, // Opens back camera by default
  );

  void startScanner() {
    setState(() {
      isScanning = true;
      scannedData = "Scanning...";
    });
  }

  void stopScanner() {
    setState(() {
      isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: const Color(0xFF363C56),
                ),
                const Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    'CampusConnect',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      letterSpacing: kLetterSpacing,
                    ),
                  ),
                ),
                Positioned(
                  top: 140,
                  left: -20,
                  child: Image.asset(
                    'assets/bluebigguy.png',
                    width: 180,
                  ),
                ),
                Positioned(
                  top: 80,
                  right: -10,
                  child: Image.asset(
                    'assets/redsmollguy.png',
                    width: 100,
                  ),
                ),
                const Positioned(
                  top: 230,
                  left: 60,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        'Scan',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 36,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: jLetterSpacing,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'To continue',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: jLetterSpacing,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Helping you',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: jLetterSpacing,
                        ),
                      ),
                      Text(
                        'smarter and',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: jLetterSpacing,
                        ),
                      ),
                      Text(
                        'lend with confidence!',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          letterSpacing: jLetterSpacing,
                        ),
                      ),
                    ],
                  ),
                ),
                // ✅ White card with camera display
                Positioned(
                  top: 395,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFFC7D90), width: 5),
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: isScanning
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: MobileScanner(
                              controller: cameraController,
                              fit: BoxFit.cover,
                              onDetect: (capture) {
                                final List<Barcode> barcodes = capture.barcodes;
                                if (barcodes.isNotEmpty) {
                                  final String scannedValue =
                                      barcodes.first.rawValue ??
                                          "No Data Found";

                                  if (mounted) {
                                    setState(() {
                                      scannedData = scannedValue;
                                      isScanning = false;
                                    });

                                    // ✅ Auto stop scanner after QR is read
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      stopScanner();
                                    });
                                  }
                                }
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              scannedData,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          // ✅ Scan Button (Triggers Scanner)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ElevatedButton(
                onPressed:
                    startScanner, // ✅ Starts the scanner in the white box
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFC7D90),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Scan To Continue',
                        style: TextStyle(color: Colors.white)),
                    SizedBox(width: 8),
                    Icon(Icons.qr_code_scanner, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
