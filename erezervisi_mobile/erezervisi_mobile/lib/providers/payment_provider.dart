import 'package:erezervisi_mobile/models/requests/payment/payment_intent_request.dart';
import 'package:erezervisi_mobile/models/responses/payment/payment_intent_dto.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class PaymentProvider extends BaseProvider {
  PaymentProvider() : super();

  Future<PaymentIntentDto> create(PaymentIntentRequest request) async {
    String endpoint = "payments/create";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return PaymentIntentDto.fromJson(response.data);
    }
    throw response;
  }
}
