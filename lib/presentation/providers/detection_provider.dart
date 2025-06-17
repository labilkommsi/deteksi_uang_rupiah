import 'package:flutter/material.dart';
import 'dart:math'; // Untuk simulasi acak

class DetectionProvider with ChangeNotifier {
  bool _isLoading = false;
  bool? _isAuthentic; // Null = belum ada hasil, true = asli, false = palsu
  String? _errorMessage;
  String? _detectedDenomination; // Simulasi denominasi yang terdeteksi

  bool get isLoading => _isLoading;
  bool? get isAuthentic => _isAuthentic;
  String? get errorMessage => _errorMessage;
  String? get detectedDenomination => _detectedDenomination;

  Future<void> detectAuthenticity(String imagePath) async {
    _isLoading = true;
    _isAuthentic = null;
    _errorMessage = null;
    _detectedDenomination = null; // Reset setiap kali deteksi
    notifyListeners();

    try {
      // --- Simulasi Proses Deteksi ---
      await Future.delayed(const Duration(seconds: 3)); // Simulasi waktu pemrosesan

      // Logika simulasi:
      // - Jika path gambar mengandung "asli", set isAuthentic true
      // - Jika path gambar mengandung "palsu", set isAuthentic false
      // - Jika tidak keduanya, tentukan secara acak
      // - Simulasi denominasi berdasarkan nama file
      if (imagePath.contains('asli')) {
        _isAuthentic = true;
        _detectedDenomination = 'Rp 100.000 (Asli)';
      } else if (imagePath.contains('palsu')) {
        _isAuthentic = false;
        _detectedDenomination = 'Rp 50.000 (Palsu)';
      } else {
        // Simulasi acak jika tidak ada indikasi "asli" atau "palsu" di nama file
        final random = Random();
        _isAuthentic = random.nextBool(); // True atau False secara acak

        // Simulasi denominasi acak
        final denominations = ['Rp 1.000', 'Rp 2.000', 'Rp 5.000', 'Rp 10.000', 'Rp 20.000', 'Rp 50.000', 'Rp 100.000'];
        _detectedDenomination = denominations[random.nextInt(denominations.length)];
        _detectedDenomination = '$_detectedDenomination (${_isAuthentic! ? "Asli" : "Palsu"})';
      }

      // Simulasi error sesekali (misalnya 10% kemungkinan)
      if (Random().nextDouble() < 0.1) {
        _errorMessage = 'Gagal memproses gambar. Coba lagi.';
        _isAuthentic = null; // Tidak ada hasil jika ada error
        _detectedDenomination = null;
      }
      // --- Akhir Simulasi ---

    } catch (e) {
      _errorMessage = 'Terjadi kesalahan tidak terduga: $e';
      _isAuthentic = null;
      _detectedDenomination = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetDetection() {
    _isLoading = false;
    _isAuthentic = null;
    _errorMessage = null;
    _detectedDenomination = null;
    notifyListeners();
  }
}