import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@injectable
class GeneratedUuidProvider {
  const GeneratedUuidProvider();

  static const _uuid = Uuid();

  String call() => _uuid.v4();
}
