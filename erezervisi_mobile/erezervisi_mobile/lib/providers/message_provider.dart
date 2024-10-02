import 'package:erezervisi_mobile/models/requests/category/get_all_categories_request.dart';
import 'package:erezervisi_mobile/models/requests/message/get_messages_request.dart';
import 'package:erezervisi_mobile/models/requests/message/message_create_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/message/message_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/message/messages.dart';
import 'package:erezervisi_mobile/providers/base_provider.dart';
import 'package:erezervisi_mobile/shared/globals.dart';

class MessageProvider extends BaseProvider {
  MessageProvider() : super();

  Future<Messages> getAll(GetAllCategoriesRequest request) async {
    String endpoint = "messages";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['messages']
          .map((x) => MessageGetDto.fromJson(x))
          .cast<MessageGetDto>()
          .toList();

      return Messages(messages: data);
    }
    throw response;
  }

  Future<PagedResponse<MessageGetDto>> getPaged(
      GetMessagesRequest request) async {
    String endpoint = "messages/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['items']
          .map((x) => MessageGetDto.fromJson(x))
          .cast<MessageGetDto>()
          .toList();
      var pagedResponse = PagedResponse.fromJson(response.data);

      return PagedResponse(
          totalItems: pagedResponse.totalItems,
          totalPages: pagedResponse.totalPages,
          pageSize: pagedResponse.pageSize,
          items: data);
    } else {
      throw Exception(response);
    }
  }

  Future send(MessageCreateDto request) async {
    String endpoint = "messages";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }

  Future<Messages> getConversation(num userId) async {
    String endpoint = "messages/$userId";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      var data = response.data['messages']
          .map((x) => MessageGetDto.fromJson(x))
          .cast<MessageGetDto>()
          .toList();

      return Messages(messages: data);
    }

    throw response;
  }
}
