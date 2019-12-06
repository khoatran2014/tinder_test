// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinder_app/models/profiles.dart';
import 'package:tinder_app/reponsitories/services.dart';
import 'package:http/http.dart' as http;
import 'package:tinder_app/utils/constants.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Test api', () {
    test('Test the network call', () async {
      final client = MockClient();
      when(client.get(AppData.baseUrl))
          .thenAnswer((_) async => http.Response('{"results": []}', 200));
      Services.profileServices.client = client;
      expect(await Services.profileServices.getProfiles(),
          isInstanceOf<Profiles>());
    });
    test('Test one profile return for each call', () async {
      final client = MockClient();
      when(client.get(AppData.baseUrl)).thenAnswer((_) async => http.Response(
          '{"results":[{"user":{"gender":"male","name":{"title":"mr","first":"jesus","last":"barnes"},"location":{"street":"5829 hillcrest rd","city":"cape fear","state":"minnesota","zip":"88612"},"email":"jesus.barnes29@example.com","username":"bigmouse561","password":"coco","salt":"zHI2HjYG","md5":"11411a836c1e2a42c0c2392c8a0672b1","sha1":"41b91a124244327629bc1c785c98eed522a5ec92","sha256":"e082835ff756dff0adcdcf2f3df409ddca9263c4f6dced0a49a274be8f8cc47d","registered":"1145628786","dob":"215198372","phone":"(633)-687-2586","cell":"(105)-749-3480","SSN":"361-70-5784","picture":"http://api.randomuser.me/portraits/men/75.jpg"},"seed":"57c8bb3c8405e798","version":"0.4"}]}',
          200));
      Services.profileServices.client = client;
      final result = await Services.profileServices.getProfiles();
      expect(result.profiles.length, 1);
    });
  });
}
