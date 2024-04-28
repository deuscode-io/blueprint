import 'package:blueprint/core/providers/web_socket/connection_subscription_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_utils/mocks/library_mocks.dart';

final _provider = ConnectionSubscriptionProvider();
final _mockSubscription = MockStreamSubscription();

void main() {
  group(
    'GIVEN $ConnectionSubscriptionProvider',
    () {
      setUp(() {
        reset(_mockSubscription);
        when(_mockSubscription.cancel).thenAnswer(Future.value);
      });

      test(
        'WHEN a subscription has been set '
        'THEN getSubscription should return the subscription',
        () {
          _provider.setSubscription(_mockSubscription);

          expect(_provider.getSubscription(), _mockSubscription);
        },
      );

      test(
        'WHEN cancelSubscription called '
        'THEN the subscription gets cancelled',
        () async {
          _provider.setSubscription(_mockSubscription);
          _provider.cancelSubscription();

          verify(_mockSubscription.cancel).called(1);
        },
      );

      test(
        'WHEN cancelSubscription called '
        'AND no subscription has been set '
        'THEN should not do anything',
        () {
          expect(_provider.cancelSubscription, returnsNormally);
        },
      );
    },
  );
}
