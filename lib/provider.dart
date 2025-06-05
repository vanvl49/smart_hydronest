import 'package:flutter/material.dart';
import 'package:smart_hydronest/models/suhu_model.dart';
import 'package:smart_hydronest/models/intensitasCahaya_model.dart';
import 'package:smart_hydronest/models/pendingin_model.dart';
import 'package:smart_hydronest/models/penutup_model.dart';
import 'package:smart_hydronest/models/batasSuhu_model.dart';
import 'package:smart_hydronest/models/batasIntensitasCahaya_model.dart';
import 'package:smart_hydronest/models/users_model.dart';
import 'package:smart_hydronest/services/suhu_service.dart';
import 'package:smart_hydronest/services/intensitasCahaya_service.dart';
import 'package:smart_hydronest/services/pendingin_service.dart';
import 'package:smart_hydronest/services/penutup_service.dart';
import 'package:smart_hydronest/services/batasSuhu_service.dart';
import 'package:smart_hydronest/services/batasIntensitasCahaya_service.dart';
import 'package:smart_hydronest/services/users_service.dart';
import 'package:smart_hydronest/services/connectivity_service.dart';
import 'package:smart_hydronest/services/mqtt_service.dart';

class HydronestProvider with ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();
  final _suhuService = SuhuService();
  final _intensitasCahayaService = IntensitasCahayaService();
  final _pendinginService = PendinginService();
  final _penutupService = PenutupService();
  final _batasSuhuService = BatasSuhuService();
  final _batasCahayaService = BatasIntensitasCahayaService();
  final _usersService = UsersService();
  final _mqttService = MqttService();

  SuhuModel? _currentSuhu;
  IntensitasCahayaModel? _currentIntensitasCahaya;
  PendinginModel? _currentPendingin;
  PenutupModel? _currentPenutup;
  BatasSuhuModel? _batasSuhu;
  BatasIntensitasCahayaModel? _batasCahaya;
  UsersModel? _currentUser;
  bool _isLoading = true;

  SuhuModel? get currentSuhu => _currentSuhu;
  IntensitasCahayaModel? get currentIntensitasCahaya =>
      _currentIntensitasCahaya;
  PendinginModel? get currentPendingin => _currentPendingin;
  PenutupModel? get currentPenutup => _currentPenutup;
  BatasSuhuModel? get batasSuhu => _batasSuhu;
  BatasIntensitasCahayaModel? get batasCahaya => _batasCahaya;
  UsersModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;

  Future<void> loadData(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final results = await Future.wait([
        _suhuService.getSuhu(),
        _intensitasCahayaService.getIntensitasCahaya(),
        _pendinginService.getPendingin(),
        _penutupService.getPenutup(),
        _batasSuhuService.getBatasSuhu(),
        _batasCahayaService.getBatasCahaya(),
        _usersService.getUsers(),
      ]);

      _currentSuhu = results[0] as SuhuModel;
      _currentIntensitasCahaya = results[1] as IntensitasCahayaModel;
      _currentPendingin = results[2] as PendinginModel;
      _currentPenutup = results[3] as PenutupModel;
      _batasSuhu = results[4] as BatasSuhuModel;
      _batasCahaya = results[5] as BatasIntensitasCahayaModel;
      _currentUser = results[6] as UsersModel;

      _isLoading = false;
      notifyListeners();
      bool isConnected = await _connectivityService.checkConnection(context);
      if (!isConnected) {
        _isLoading = false;
        return;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading data: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> updatePendinginStatus(bool value) async {
    try {
      if (_currentPendingin != null) {
        _currentPendingin!.pendingin_ON = value;
        await _pendinginService.updatePendingin(_currentPendingin!);
        _mqttService.kontrolPendingin(value ? 'on' : 'off');
        notifyListeners();
      }
    } catch (e) {
      _currentPendingin!.pendingin_ON = !value;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updatePenutupStatus(bool value) async {
    try {
      if (_currentPenutup != null) {
        _currentPenutup!.penutup_ON = value;
        await _penutupService.updatePenutup(_currentPenutup!);
        _mqttService.kontrolPenutup(value ? 'tutup' : 'buka');
        notifyListeners();
      }
    } catch (e) {
      _currentPenutup!.penutup_ON = !value;
      notifyListeners();
      rethrow;
    }
  }
}
