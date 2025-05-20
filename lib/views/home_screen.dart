import 'package:flutter/material.dart';
import 'package:smart_hydronest/widgets/bottomnavbar.dart';
import 'package:smart_hydronest/widgets/popUp.dart';
import 'package:smart_hydronest/models/intensitasCahaya_model.dart';
import 'package:smart_hydronest/models/batasIntensitasCahaya_model.dart';
import 'package:smart_hydronest/models/suhu_model.dart';
import 'package:smart_hydronest/models/batasSuhu_model.dart';
import 'package:smart_hydronest/models/pendingin_model.dart';
import 'package:smart_hydronest/models/penutup_model.dart';
import 'package:smart_hydronest/services/suhu_service.dart';
import 'package:smart_hydronest/services/intensitasCahaya_service.dart';
import 'package:smart_hydronest/services/batasIntensitasCahaya_service.dart';
import 'package:smart_hydronest/services/batasSuhu_service.dart';
import 'package:smart_hydronest/services/pendingin_service.dart';
import 'package:smart_hydronest/services/penutup_service.dart';

class HomeScreen extends StatefulWidget {
  final String? username;
  const HomeScreen({Key? key, this.username}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool coolerStatus = false;
  bool coverStatus = true;
  final SuhuService _suhuService = SuhuService();
  final IntensitasCahayaService _intensitasCahayaService =
      IntensitasCahayaService();
  SuhuModel? _currentSuhu;
  IntensitasCahayaModel? _currentIntensitasCahaya;
  final PendinginService _pendinginService = PendinginService();
  PendinginModel? _currentPendingin;
  final PenutupService _penutupService = PenutupService();
  PenutupModel? _currentPenutup;
  bool _isLoading = true;
  String _displayUsername = 'User';

  @override
  void initState() {
    super.initState();
    _loadData();
    if (widget.username != null && widget.username!.isNotEmpty) {
      _displayUsername = widget.username!;
    }
  }

  Future<void> _loadData() async {
    try {
      final suhu = await _suhuService.getSuhu();
      final intensitasCahaya =
          await _intensitasCahayaService.getIntensitasCahaya();
      final pendingin = await _pendinginService.getPendingin();
      final penutup = await _penutupService.getPenutup();

      setState(() {
        _currentSuhu = suhu;
        _currentIntensitasCahaya = intensitasCahaya;
        _currentPendingin = pendingin;
        _currentPenutup = penutup;
        coolerStatus = pendingin?.pendingin_ON ?? false;
        coverStatus = penutup?.penutup_ON ?? false;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePendinginStatus(bool value) async {
    try {
      if (_currentPendingin != null) {
        _currentPendingin!.pendingin_ON = value;
        await _pendinginService.updatePendingin(_currentPendingin!);
        setState(() {
          coolerStatus = value;
        });
      }
    } catch (e) {
      print('Error updating pendingin status: $e');
      setState(() {
        coolerStatus = !value;
      });
    }
  }

  Future<void> _updatePenutupStatus(bool value) async {
    try {
      if (_currentPenutup != null) {
        _currentPenutup!.penutup_ON = value;
        await _penutupService.updatePenutup(_currentPenutup!);
        setState(() {
          coverStatus = value;
        });
      }
    } catch (e) {
      print('Error updating penutup status: $e');
      setState(() {
        coverStatus = !value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(21, 145, 72, 1), Color(0xFF4CAF50)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang, $_displayUsername!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Monitoring Lingkungan Hidroponik',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.thermostat_outlined,
                                            size: 30,
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _isLoading
                                                    ? '...'
                                                    : '${_currentSuhu?.suhu ?? '--'}°C',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                'Suhu',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.show_chart,
                                            size: 30,
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pendingin',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                _currentPendingin
                                                            ?.pendingin_ON ==
                                                        true
                                                    ? 'Aktif'
                                                    : 'Nonaktif',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),

                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.sunny, size: 30),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _isLoading
                                                    ? '...'
                                                    : '${_currentIntensitasCahaya?.intensitas_cahaya ?? '--'} Cd',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                'Cahaya',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(Icons.settings, size: 30),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Penutup',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                _currentPenutup?.penutup_ON ==
                                                        true
                                                    ? 'Aktif'
                                                    : 'Nonaktif',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Text(
                      'Status Data Monitoring',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFA4C639),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.45),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Icon(
                              Icons.thermostat_outlined,
                              color: Colors.red[400],
                            ),
                          ),
                          const SizedBox(width: 15, height: 100),
                          const Expanded(
                            child: Text(
                              'Cek Status Suhu Ruangan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, size: 30),
                            onPressed: () {
                              PopupSuhu(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.40),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Icon(Icons.sunny, color: Colors.amber[700]),
                          ),
                          const SizedBox(width: 15, height: 100),
                          const Expanded(
                            child: Text(
                              'Cek Status Intensitas Cahaya',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right, size: 30),
                            onPressed: () {
                              PopUpCahaya(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: Text(
                      'Kontrol Manual',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFA4C639),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.45),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(
                                Icons.ac_unit,
                                color: Colors.blue[300],
                              ),
                            ),
                            const SizedBox(width: 15, height: 65),
                            const Expanded(
                              child: Text(
                                'Pendingin Ruangan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Switch(
                              value: coolerStatus,
                              onChanged: (value) {
                                _updatePendinginStatus(value);
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => ConfirmationPopUp(
                                        title:
                                            coolerStatus
                                                ? 'Nonaktifkan Pendingin?'
                                                : 'Aktifkan Pendingin?',
                                        message:
                                            coolerStatus
                                                ? 'Apakah Anda yakin ingin menonaktifkan pendingin ruangan?'
                                                : 'Apakah Anda yakin ingin mengaktifkan pendingin ruangan?',
                                        onConfirm: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => SuccessDialog(
                                                  message:
                                                      coolerStatus
                                                          ? 'Pendingin berhasil diaktifkan!'
                                                          : 'Pendingin berhasil dinonaktifkan!',
                                                  onConfirm: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                          );
                                        },
                                      ),
                                );
                              },
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF4CAF50),
                            ),

                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.40),
                            spreadRadius: 0,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const SizedBox(width: 15),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Icon(
                                Icons.blinds,
                                color: Colors.blue[300],
                              ),
                            ),
                            const SizedBox(width: 15, height: 65),
                            const Expanded(
                              child: Text(
                                'Penutup Ruangan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Switch(
                              value: coverStatus,
                              onChanged: (value) {
                                _updatePenutupStatus(value);
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => ConfirmationPopUp(
                                        title:
                                            coverStatus
                                                ? 'Nonaktifkan Penutup?'
                                                : 'Aktifkan Penutup?',
                                        message:
                                            coverStatus
                                                ? 'Apakah Anda yakin ingin menonaktifkan penutup ruangan?'
                                                : 'Apakah Anda yakin ingin mengaktifkan penutup ruangan?',
                                        onConfirm: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) => SuccessDialog(
                                                  message:
                                                      coverStatus
                                                          ? 'Penutup berhasil dinonaktifkan!'
                                                          : 'Penutup berhasil diaktifkan!',
                                                  onConfirm: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                          );
                                        },
                                      ),
                                );
                              },
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF4CAF50),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        activeItem: BottomNavItem.home,
        onHomeTap: () {},
      ),
    );
  }

  void PopupSuhu(BuildContext context) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Data Suhu Ruangan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentSuhu?.suhu?.toString() ?? '--',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '°',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'C',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text('Suhu Optimal', style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Tutup', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void PopUpCahaya(BuildContext context) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Data Intensitas Cahaya',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentIntensitasCahaya?.intensitas_cahaya?.toString() ??
                          '--',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cd',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Intensitas Cahaya Optimal',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Tutup', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
