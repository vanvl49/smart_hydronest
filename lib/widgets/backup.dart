// void PopupPenutup(BuildContext context) {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(20.0),
    //       ),
    //       child: Container(
    //         padding: const EdgeInsets.all(20),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(20),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.grey.withOpacity(0.5),
    //               spreadRadius: 5,
    //               blurRadius: 7,
    //               offset: const Offset(0, 3),
    //             ),
    //           ],
    //         ),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(
    //               coverStatus ? 'Nonaktifkan Penutup?' : 'Aktifkan Penutup?',
    //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //             ),
    //             const SizedBox(height: 20),
    //             Container(
    //               width: 100,
    //               height: 100,
    //               decoration: BoxDecoration(
    //                 shape: BoxShape.circle,
    //                 color: Colors.red.withOpacity(0.1),
    //               ),
    //               child: Center(
    //                 child: Container(
    //                   width: 80,
    //                   height: 80,
    //                   decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     color: Colors.red.withOpacity(0.2),
    //                   ),
    //                   child: const Center(
    //                     child: Icon(
    //                       Icons.warning_rounded,
    //                       size: 50,
    //                       color: Colors.red,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Text(
    //               coverStatus
    //                   ? 'Apakah Anda yakin ingin menonaktifkan penutup ruangan?'
    //                   : 'Apakah Anda yakin ingin mengaktifkan penutup ruangan?',
    //               textAlign: TextAlign.center,
    //               style: TextStyle(fontSize: 15, color: Colors.black87),
    //             ),
    //             const SizedBox(height: 25),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     showDialog(
    //                       context: context,
    //                       builder: (BuildContext context) {
    //                         return AlertDialog(
    //                           shape: RoundedRectangleBorder(
    //                             borderRadius: BorderRadius.circular(15),
    //                           ),
    //                           title: Column(
    //                             children: [
    //                               const Icon(
    //                                 Icons.check_circle_outline,
    //                                 color: Color(0xFF4CAF50),
    //                                 size: 48,
    //                               ),
    //                               const SizedBox(height: 8),
    //                               const Text(
    //                                 'Berhasil!',
    //                                 textAlign: TextAlign.center,
    //                                 style: TextStyle(
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           content: Text(
    //                             coverStatus
    //                                 ? 'Penutup berhasil diaktifkan!'
    //                                 : 'Penutup berhasil dinonaktifkan!',
    //                             textAlign: TextAlign.center,
    //                             style: TextStyle(fontSize: 16),
    //                           ),
    //                           actionsAlignment: MainAxisAlignment.center,
    //                           actions: <Widget>[
    //                             ElevatedButton(
    //                               style: ElevatedButton.styleFrom(
    //                                 backgroundColor: const Color(0xFF4CAF50),
    //                                 shape: RoundedRectangleBorder(
    //                                   borderRadius: BorderRadius.circular(8),
    //                                 ),
    //                                 padding: const EdgeInsets.symmetric(
    //                                   horizontal: 20,
    //                                   vertical: 10,
    //                                 ),
    //                               ),
    //                               child: const Text(
    //                                 'OK',
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                   fontWeight: FontWeight.w600,
    //                                 ),
    //                               ),
    //                               onPressed: () {
    //                                 Navigator.of(
    //                                   context,
    //                                 ).pop(); // Pop alert dialog
    //                                 Navigator.of(
    //                                   context,
    //                                 ).pop(); // Pop parent dialog
    //                               },
    //                             ),
    //                           ],
    //                         );
    //                       },
    //                     );
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: const Color(0xFF4CAF50),
    //                     foregroundColor: Colors.white,
    //                     elevation: 2,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     padding: const EdgeInsets.symmetric(
    //                       horizontal: 30,
    //                       vertical: 12,
    //                     ),
    //                   ),
    //                   child: const Text(
    //                     'Ya, yakin',
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(width: 15),
    //                 ElevatedButton(
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: Colors.white,
    //                     foregroundColor: const Color(0xFF4CAF50),
    //                     elevation: 2,
    //                     side: const BorderSide(
    //                       color: Color(0xFF4CAF50),
    //                       width: 2,
    //                     ),
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(20),
    //                     ),
    //                     padding: const EdgeInsets.symmetric(
    //                       horizontal: 30,
    //                       vertical: 12,
    //                     ),
    //                   ),
    //                   child: const Text(
    //                     'Batal',
    //                     style: TextStyle(
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  // }

  // void PopupPendingin(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20.0),
  //         ),
  //         child: Container(
  //           padding: const EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(20),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.5),
  //                 spreadRadius: 5,
  //                 blurRadius: 7,
  //                 offset: const Offset(0, 3),
  //               ),
  //             ],
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 coolerStatus
  //                     ? 'Nonaktifkan Pendingin?'
  //                     : 'Aktifkan Pendingin?',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(height: 20),
  //               Container(
  //                 width: 100,
  //                 height: 100,
  //                 decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   color: Colors.red.withOpacity(0.1),
  //                 ),
  //                 child: Center(
  //                   child: Container(
  //                     width: 80,
  //                     height: 80,
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.circle,
  //                       color: Colors.red.withOpacity(0.2),
  //                     ),
  //                     child: const Center(
  //                       child: Icon(
  //                         Icons.warning_rounded,
  //                         size: 50,
  //                         color: Colors.red,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               Text(
  //                 coolerStatus
  //                     ? 'Apakah Anda yakin ingin menonaktifkan pendingin ruangan?'
  //                     : 'Apakah Anda yakin ingin mengaktifkan pendingin ruangan?',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(fontSize: 15, color: Colors.black87),
  //               ),
  //               const SizedBox(height: 25),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       showDialog(
  //                         context: context,
  //                         builder: (BuildContext context) {
  //                           return AlertDialog(
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(15),
  //                             ),
  //                             title: Column(
  //                               children: [
  //                                 const Icon(
  //                                   Icons.check_circle_outline,
  //                                   color: Color(0xFF4CAF50),
  //                                   size: 48,
  //                                 ),
  //                                 const SizedBox(height: 8),
  //                                 const Text(
  //                                   'Berhasil!',
  //                                   textAlign: TextAlign.center,
  //                                   style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             content: Text(
  //                               coolerStatus
  //                                   ? 'Pendingin berhasil diaktifkan!'
  //                                   : 'Pendingin berhasil dinonaktifkan!',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(fontSize: 16),
  //                             ),
  //                             actionsAlignment: MainAxisAlignment.center,
  //                             actions: <Widget>[
  //                               ElevatedButton(
  //                                 style: ElevatedButton.styleFrom(
  //                                   backgroundColor: const Color(0xFF4CAF50),
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(8),
  //                                   ),
  //                                   padding: const EdgeInsets.symmetric(
  //                                     horizontal: 20,
  //                                     vertical: 10,
  //                                   ),
  //                                 ),
  //                                 child: const Text(
  //                                   'OK',
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontWeight: FontWeight.w600,
  //                                   ),
  //                                 ),
  //                                 onPressed: () {
  //                                   Navigator.of(
  //                                     context,
  //                                   ).pop(); // Pop alert dialog
  //                                   Navigator.of(
  //                                     context,
  //                                   ).pop(); // Pop parent dialog
  //                                 },
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: const Color(0xFF4CAF50),
  //                       foregroundColor: Colors.white,
  //                       elevation: 2,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 30,
  //                         vertical: 12,
  //                       ),
  //                     ),
  //                     child: const Text(
  //                       'Ya, yakin',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 15),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Colors.white,
  //                       foregroundColor: const Color(0xFF4CAF50),
  //                       elevation: 2,
  //                       side: const BorderSide(
  //                         color: Color(0xFF4CAF50),
  //                         width: 2,
  //                       ),
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                       padding: const EdgeInsets.symmetric(
  //                         horizontal: 30,
  //                         vertical: 12,
  //                       ),
  //                     ),
  //                     child: const Text(
  //                       'Batal',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  