import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deteksi_uang_rupiah/presentation/providers/detection_provider.dart'; // Pastikan importnya sudah benar
import 'package:deteksi_uang_rupiah/presentation/pages/result_page.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  // Daftar gambar mock untuk simulasi
  final List<String> mockImagePaths = const [
    'assets/images/rupiah_100k_asli.jpg', // Pastikan file ini ada
    'assets/images/rupiah_50k_palsu.jpg',  // Pastikan file ini ada
    'assets/images/rupiah_20k_random.jpg', // Pastikan file ini ada
    'assets/images/rupiah_5k_random.jpg',  // Pastikan file ini ada
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Deteksi Uang'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mode Simulasi:',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Tombol untuk memicu deteksi dengan gambar mock
              ...mockImagePaths.map((path) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Langsung navigasi ke halaman hasil dengan path gambar mock
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(imagePath: path),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Lebar penuh
                  ),
                  child: Text('Simulasi Deteksi (${path.split('/').last})'),
                ),
              )).toList(),
              const SizedBox(height: 30),
              Text(
                'Di mode nyata, Anda akan mengambil gambar uang dengan kamera.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}