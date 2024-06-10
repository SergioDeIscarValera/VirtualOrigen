import 'package:virtual_origen_app/models/smart_device.dart';
import 'package:virtual_origen_app/services/repository/interface_listener_repository.dart';

abstract class ISmartDeviceRepository
    implements IListenerRepository<SmartDevice, String, String> {}
