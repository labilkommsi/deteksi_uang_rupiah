import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class CameraProvider with ChangeNotifier {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitializing = false;
  String? _errorMessage;

  CameraController? get cameraController => _cameraController;
  bool get isInitializing => _isInitializing;
  String? get errorMessage => _errorMessage;

  Future<void> initializeCamera() async {
    if (_isInitializing || (_cameraController != null && _cameraController!.value.isInitialized)) {
      return; // Already initializing or initialized
    }

    _isInitializing = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _cameras = await availableCameras();
      if (_cameras!.isEmpty) {
        throw Exception('Tidak ada kamera tersedia.');
      }
      _cameraController = CameraController(
        _cameras![0], // Gunakan kamera depan pertama secara default
        ResolutionPreset.medium, // Resolusi kamera
        enableAudio: false, // Tidak perlu audio untuk deteksi uang
      );

      await _cameraController!.initialize();
      _isInitializing = false;
    } catch (e) {
      _errorMessage = 'Gagal menginisialisasi kamera: $e';
      _isInitializing = false;
      _cameraController = null; // Pastikan controller null jika gagal
      debugPrint('Camera init error: $_errorMessage');
    } finally {
      notifyListeners();
    }
  }

  Future<XFile?> takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      _errorMessage = 'Kamera belum diinisialisasi.';
      notifyListeners();
      return null;
    }

    try {
      final XFile image = await _cameraController!.takePicture();
      _errorMessage = null; // Reset error message on success
      notifyListeners();
      return image;
    } on CameraException catch (e) {
      _errorMessage = 'Gagal mengambil gambar: ${e.description}';
      notifyListeners();
      return null;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan saat mengambil gambar: $e';
      notifyListeners();
      return null;
    }
  }

  void disposeCamera() {
    _cameraController?.dispose();
    _cameraController = null;
    _isInitializing = false;
    _errorMessage = null;
    notifyListeners(); // Notify listeners that controller is disposed
  }
}