import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deteksi_uang_rupiah/presentation/pages/home_page.dart';
import 'package:deteksi_uang_rupiah/presentation/themes/app_theme.dart';
import 'package:deteksi_uang_rupiah/presentation/providers/camera_provider.dart';
import 'package:deteksi_uang_rupiah/presentation/providers/detection_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CameraProvider()),
        ChangeNotifierProvider(create: (_) => DetectionProvider()),
        // Tambahkan provider lain di sini jika ada
      ],
      child: MaterialApp(
        title: 'Detektor Keaslian Rupiah',
        theme: AppTheme.lightTheme, // Menggunakan tema yang sudah didefinisikan
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}