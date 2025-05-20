import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:smart_hydronest/widgets/appbar.dart';
import 'package:smart_hydronest/widgets/bottomnavbar.dart';
import 'package:smart_hydronest/widgets/popUp.dart';
import 'package:smart_hydronest/models/batasSuhu_model.dart';
import 'package:smart_hydronest/models/batasIntensitasCahaya_model.dart';
import 'package:smart_hydronest/services/batasSuhu_service.dart';
import 'package:smart_hydronest/services/batasIntensitasCahaya_service.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  final BatasSuhuService _batasSuhuService = BatasSuhuService();
  final BatasIntensitasCahayaService _batasIntensitasCahayaService =
      BatasIntensitasCahayaService();
  BatasSuhuModel? batasSuhu = BatasSuhuModel();
  BatasIntensitasCahayaModel? batasCahaya = BatasIntensitasCahayaModel();

  void initState() {
    super.initState();
    fetchBatas();
  }

  Future<void> fetchBatas() async {
    batasSuhu = await _batasSuhuService.getBatasSuhu();
    batasCahaya = await _batasIntensitasCahayaService.getBatasCahaya();
    print("Cahaya min: ${batasCahaya?.cahaya_min}");
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();
  Future<void> updateBatasSuhu(String min, String max) async {
    try {
      final batassuhu = BatasSuhuModel(
        id: batasSuhu?.id ?? '1',
        suhu_min: int.parse(min),
        suhu_max: int.parse(max),
        updated_at: Timestamp.now(),
      );
      await _batasSuhuService.updateBatasSuhu(batassuhu);
      setState(() {
        fetchBatas();
      });
    } catch (e) {
      print('Error updating batas suhu: $e');
    }
  }

  Future<void> updateBatasCahaya(String min, String max) async {
    try {
      final batascahaya = BatasIntensitasCahayaModel(
        id: batasCahaya?.id ?? '1',
        cahaya_min: int.parse(min),
        cahaya_max: int.parse(max),
        updated_at: Timestamp.now(),
      );
      await _batasIntensitasCahayaService.updateBatasCahaya(batascahaya);
      setState(() {
        fetchBatas();
      });
    } catch (e) {
      print('Error updating batas suhu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: const MyAppBar(title: "Pengaturan Batas Optimal"),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Batas Optimal Suhu Ruangan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${batasSuhu?.suhu_min.toString() ?? '0'}°C',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${batasSuhu?.suhu_max.toString() ?? '0'}°C',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/slider_suhu.png',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Min',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Max',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                EditBatasSuhu(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(100, 40),
                              ),
                              child: const Text(
                                'Ubah',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Batas Optimal Intensitas Cahaya',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${batasCahaya?.cahaya_min.toString() ?? '0'}Cd',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${batasCahaya?.cahaya_max.toString() ?? '0'}Cd',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/slider_cahaya.png',
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Min',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Max',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                EditBatasCahaya(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(100, 40),
                              ),
                              child: const Text(
                                'Ubah',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        activeItem: BottomNavItem.settings,
        onHomeTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        },
      ),
    );
  }

  void EditBatasSuhu(BuildContext context) {
    final TextEditingController _minController = TextEditingController(
      text: batasSuhu?.suhu_min.toString() ?? '0',
    );
    final TextEditingController _maxController = TextEditingController(
      text: batasSuhu?.suhu_max.toString() ?? '0',
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Atur Batas Suhu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Batas Suhu Minimal',
                      prefixIcon: const Icon(
                        Icons.ac_unit,
                        color: Color.fromARGB(255, 22, 190, 224),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Data Invalid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Batas Suhu Maksimal',
                      prefixIcon: const Icon(
                        Icons.local_fire_department,
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Data Invalid';
                      }
                      if (_minController.text.isNotEmpty &&
                          double.parse(value) <=
                              double.parse(_minController.text)) {
                        return 'Batas maksimal harus lebih besar dari minimal';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await updateBatasSuhu(
                              _minController.text,
                              _maxController.text,
                            );
                            showDialog(
                              context: context,
                              builder:
                                  (context) => SuccessDialog(
                                    message:
                                        'Data batas optimal suhu berhasil diubah!',
                                    onConfirm: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Ubah',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void EditBatasCahaya(BuildContext context) {
    final TextEditingController _minController = TextEditingController(
      text: batasCahaya?.cahaya_min.toString() ?? '0',
    );
    final TextEditingController _maxController = TextEditingController(
      text: batasCahaya?.cahaya_max.toString() ?? '0',
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Atur Batas Intensitas Cahaya',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Batas Cahaya Minimal',
                      prefixIcon: const Icon(
                        Icons.cloud,
                        color: Color.fromARGB(255, 97, 102, 103),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Data Invalid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _maxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Batas Cahaya Maksimal',
                      prefixIcon: const Icon(
                        Icons.wb_sunny,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Data tidak boleh kosong';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Data Invalid';
                      }
                      if (_minController.text.isNotEmpty &&
                          double.parse(value) <=
                              double.parse(_minController.text)) {
                        return 'Batas maksimal harus lebih besar dari minimal';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await updateBatasCahaya(
                              _minController.text,
                              _maxController.text,
                            );
                            showDialog(
                              context: context,
                              builder:
                                  (context) => SuccessDialog(
                                    message:
                                        'Data batas optimal intensitas cahaya berhasil diubah!',
                                    onConfirm: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Ubah',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
