import 'package:blueprint/core/providers/web_socket/io_web_socket_channel_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/mocks/library_mocks.dart';


final _provider = IOWebSocketChannelProvider();
final _mockSocketChannel = MockIOWebSocketChannel();
final _mockWebSocketSink = MockWebSocketSink();

void main() {
  group(
    'GIVEN $IOWebSocketChannelProvider',
    () {
      setUp(() {
        when(() => _mockSocketChannel.sink).thenReturn(_mockWebSocketSink);
        when(() => _mockWebSocketSink.close()).thenAnswer((_) async => {});
      });

      tearDown(() {
        reset(_mockSocketChannel);
        reset(_mockWebSocketSink);
      });

      test(
        'WHEN a socket channel has been set '
        'THEN getSocketChannel should return the socket channel',
        () {
          _provider.setSocketChannel(_mockSocketChannel);

          expect(_provider.getSocketChannel(), _mockSocketChannel);
        },
      );

      test(
        'WHEN close socket channel called '
        'THEN the socket channel gets closed',
        () {
          _provider.setSocketChannel(_mockSocketChannel);
          _provider.closeSocketChannel();

          verify(_mockWebSocketSink.close).called(1);
        },
      );

      test(
        'WHEN close socket channel called '
        'AND no socket channel has been set '
        'THEN should not do anything',
        () {
          expect(_provider.closeSocketChannel, returnsNormally);
        },
      );
    },
  );
}
