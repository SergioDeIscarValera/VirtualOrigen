import 'package:virtual_origen_app/models/property.dart';
import 'package:virtual_origen_app/services/repository/interface_listener_repository.dart';

abstract class IPropertyRepository
    implements IListenerRepository<Property, String, String> {}
