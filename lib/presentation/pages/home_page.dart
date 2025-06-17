import 'package:flutter/material.dart';
import 'package:deteksi_uang_rupiah/presentation/widgets/custom_button.dart';
import 'package:deteksi_uang_rupiah/presentation/pages/camera_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detektor Keaslian Rupiah'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo atau ilustrasi bisa ditambahkan di sini
              // Image.asset('assets/images/rupiah_logo.png', height: 150),
              // const SizedBox(height: 40),
              Text(
                'Selamat Datang di Aplikasi Deteksi Uang Rupiah',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Gunakan kamera Anda untuk memindai uang Rupiah dan periksa keasliannya.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              CustomButton(
                text: 'Mulai Deteksi',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}