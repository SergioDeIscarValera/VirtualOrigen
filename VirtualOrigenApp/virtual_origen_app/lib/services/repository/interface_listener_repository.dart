import 'package:virtual_origen_app/services/repository/interface_listener_repository_only_get.dart';
import 'package:virtual_origen_app/services/repository/interface_repository.dart';

abstract class IListenerRepository<T, ID, IDC>
    implements
        IRepository<T, ID, IDC>,
        IListenerRepositoryOnlyGet<T, ID, IDC> {}
