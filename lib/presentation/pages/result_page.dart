import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deteksi_uang_rupiah/presentation/widgets/detection_result_card.dart';
import 'package:deteksi_uang_rupiah/presentation/providers/detection_provider.dart';

class ResultPage extends StatefulWidget {
  final String imagePath; // Path ke gambar mock di assets

  const ResultPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    // Memulai proses deteksi setelah halaman dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DetectionProvider>(context, listen: false)
          .detectAuthenticity(widget.imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Deteksi'),
      ),
      body: Consumer<DetectionProvider>(
        builder: (context, detectionProvider, child) {
          if (detectionProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (detectionProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 80),
                    const SizedBox(height: 20),
                    Text(
                      'Terjadi kesalahan: ${detectionProvider.errorMessage}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ),
            );
          } else if (detectionProvider.isAuthentic != null) {
            final isAuthentic = detectionProvider.isAuthentic!;
            final detectedDenomination = detectionProvider.detectedDenomination ?? 'Denominasi Tidak Dikenali';

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset( // Menggunakan Image.asset untuk gambar dari assets
                        widget.imagePath,
                        height: MediaQuery.of(context).size.height * 0.4,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  DetectionResultCard(
                    title: isAuthentic ? 'Uang Asli Ditemukan!' : 'Uang Palsu Dicurigai!',
                    message: isAuthentic
                        ? 'Berdasarkan analisis simulasi, uang ini menunjukkan karakteristik keaslian.\nDenominasi: $detectedDenomination'
                        : 'Uang ini menunjukkan ketidaksesuaian dengan ciri uang asli. Harap berhati-hati!\nDenominasi: $detectedDenomination',
                    icon: isAuthentic ? Icons.check_circle : Icons.error,
                    iconColor: isAuthentic ? Colors.green : Colors.red,
                    borderColor: isAuthentic ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman pemilihan simulasi
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Deteksi Ulang / Pilih Lain'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
          // Default state jika belum ada hasil
          return const Center(child: Text('Memulai deteksi simulasi...'));
        },
      ),
    );
  }
}