import 'package:flutter/material.dart';
import 'package:smart_hydronest/widgets/bottomnavbar.dart';
import 'package:smart_hydronest/widgets/popUp.dart';
import 'package:smart_hydronest/provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_hydronest/services/notifikasi_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HydronestProvider>().loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    // Watch provider for changes
    final provider = context.watch<HydronestProvider>();
    void handleError(dynamic error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }

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
                      'Selamat Datang, ${provider.currentUser?.username ?? 'User'}',
                      style: const TextStyle(
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
                                                provider.isLoading
                                                    ? '...'
                                                    : '${provider.currentSuhu?.suhu ?? '--'}°C',
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
                                                provider
                                                            .currentPendingin
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
                                                provider.isLoading
                                                    ? '...'
                                                    : '${provider.currentIntensitasCahaya?.intensitas_cahaya ?? '--'} Cd',
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
                                                provider
                                                            .currentPenutup
                                                            ?.penutup_ON ==
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
                              String description;
                              Color statusColor;

                              if (provider.currentSuhu == null ||
                                  provider.batasSuhu == null) {
                                description = 'Status Tidak Tersedia';
                                statusColor = Colors.grey;
                              } else {
                                final currentTemp =
                                    provider.currentSuhu!.suhu ?? 0;
                                final minTemp =
                                    provider.batasSuhu!.suhu_min ?? 0;
                                final maxTemp =
                                    provider.batasSuhu!.suhu_max ?? 0;

                                if (currentTemp > maxTemp) {
                                  description = 'Suhu diatas batas optimal';
                                  statusColor = Colors.red;
                                } else if (currentTemp < minTemp) {
                                  description = 'Suhu dibawah batas optimal';
                                  statusColor = Colors.red;
                                } else {
                                  description = 'Suhu Optimal';
                                  statusColor = Colors.green;
                                }
                              }

                              PopUp(
                                context: context,
                                title: 'Data Suhu Ruangan',
                                value:
                                    provider.currentSuhu?.suhu?.toString() ??
                                    '--',
                                unit: '°C',
                                description: description,
                                descriptionColor: statusColor,
                              );
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
                              String description;
                              Color statusColor;

                              if (provider.currentIntensitasCahaya == null ||
                                  provider.batasCahaya == null) {
                                description = 'Status Tidak Tersedia';
                                statusColor = Colors.grey;
                              } else {
                                final currentIntensity =
                                    provider
                                        .currentIntensitasCahaya!
                                        .intensitas_cahaya ??
                                    0;
                                final minIntensity =
                                    provider.batasCahaya!.cahaya_min ?? 0;
                                final maxIntensity =
                                    provider.batasCahaya!.cahaya_max ?? 0;

                                if (currentIntensity > maxIntensity) {
                                  description =
                                      'Intensitas cahaya diatas batas optimal';
                                  statusColor = Colors.red;
                                } else if (currentIntensity < minIntensity) {
                                  description =
                                      'Intensitas cahaya dibawah batas optimal';
                                  statusColor = Colors.red;
                                } else {
                                  description = 'Intensitas Cahaya Optimal';
                                  statusColor = Colors.green;
                                }
                              }

                              PopUp(
                                context: context,
                                title: 'Data Intensitas Cahaya',
                                value:
                                    provider
                                        .currentIntensitasCahaya
                                        ?.intensitas_cahaya
                                        ?.toString() ??
                                    '--',
                                unit: 'Cd',
                                description: description,
                                descriptionColor: statusColor,
                              );
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
                              value:
                                  provider.currentPendingin?.pendingin_ON ==
                                  true,
                              onChanged: (value) {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => ConfirmationPopUp(
                                        title:
                                            value
                                                ? 'Aktifkan Pendingin?'
                                                : 'Nonaktifkan Pendingin?',
                                        message:
                                            value
                                                ? 'Apakah Anda yakin ingin mengaktifkan pendingin ruangan?'
                                                : 'Apakah Anda yakin ingin menonaktifkan pendingin ruangan?',
                                        onConfirm: () {
                                          provider
                                              .updatePendinginStatus(value)
                                              .then((_) {
                                                NotificationService().showNotification(
                                                  title:
                                                      value
                                                          ? 'Pendingin ruangan mulai diaktifkan'
                                                          : 'Pendingin ruangan dinonaktifkan',
                                                  body:
                                                      value
                                                          ? 'Pendingin ruangan berhasil diaktifkan!'
                                                          : 'Pendingin ruangan berhasil dinonaktifkan!',
                                                );
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (
                                                        context,
                                                      ) => SuccessDialog(
                                                        message:
                                                            value
                                                                ? 'Pendingin ruangan berhasil diaktifkan!'
                                                                : 'Pendingin ruangan berhasil dinonaktifkan!',
                                                        onConfirm: () {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                      ),
                                                );
                                              })
                                              .catchError((err) {
                                                handleError(err);
                                                Navigator.pop(context);
                                              });
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
                              value:
                                  provider.currentPenutup?.penutup_ON == true,
                              onChanged: (value) {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => ConfirmationPopUp(
                                        title:
                                            value
                                                ? 'Aktifkan Penutup?'
                                                : 'Nonaktifkan Penutup?',
                                        message:
                                            value
                                                ? 'Apakah Anda yakin ingin mengaktifkan penutup ruangan?'
                                                : 'Apakah Anda yakin ingin menonaktifkan penutup ruangan?',
                                        onConfirm: () {
                                          provider
                                              .updatePenutupStatus(value)
                                              .then((_) {
                                                NotificationService().showNotification(
                                                  title:
                                                      value
                                                          ? 'Penutup ruangan mulai diaktifkan'
                                                          : 'Penutup ruangan dinonaktifkan',
                                                  body:
                                                      value
                                                          ? 'Penutup ruangan berhasil diaktifkan!'
                                                          : 'Penutup ruangan berhasil dinonaktifkan!',
                                                );
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (
                                                        context,
                                                      ) => SuccessDialog(
                                                        message:
                                                            value
                                                                ? 'Penutup berhasil diaktifkan!'
                                                                : 'Penutup berhasil dinonaktifkan!',
                                                        onConfirm: () {
                                                          Navigator.pop(
                                                            context,
                                                          ); // tutup success dialog
                                                        },
                                                      ),
                                                );
                                              })
                                              .catchError((err) {
                                                handleError(err);
                                                Navigator.pop(context);
                                              });
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

  void PopUp({
    required BuildContext context,
    required String title,
    required String value,
    required String unit,
    required String description,
    Color descriptionColor = Colors.black,
  }) {
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
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      unit,
                      style: TextStyle(
                        fontSize: unit == 'C' ? 80 : 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 18, color: descriptionColor),
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
