import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';

@injectable
class GeneratedUuidProvider {
  const GeneratedUuidProvider();

  static const _uuid = Uuid();

  String call() => _uuid.v4();
}
