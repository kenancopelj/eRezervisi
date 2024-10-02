import 'package:erezervisi_desktop/models/requests/category/get_all_categories_request.dart';
import 'package:erezervisi_desktop/models/requests/category/get_categories_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/category/categories.dart';
import 'package:erezervisi_desktop/models/responses/category/category_get_dto.dart';
import 'package:erezervisi_desktop/providers/base_provider.dart';
import 'package:erezervisi_desktop/shared/globals.dart';

class CategoryProvider extends BaseProvider {
  CategoryProvider() : super();

  Future<Categories> getAll(GetAllCategoriesRequest request) async {
    String endpoint = "categories";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request.toJson());

    if (response.statusCode == 200) {
      var data = response.data['categories']
          .map((x) => CategoryGetDto.fromJson(x))
          .cast<CategoryGetDto>()
          .toList();

      return Categories(categories: data);
    }
    throw response;
  }

  Future<PagedResponse<CategoryGetDto>> getPaged(
      GetCategoriesRequest request) async {
    String endpoint = "categories/paged";
    var url = Globals.apiUrl + endpoint;

    var response = await dio.post(url, data: request);

    if (response.statusCode == 200) {
      return PagedResponse<CategoryGetDto>.fromJson(response.data);
    } else {
      throw Exception(response);
    }
  }
}
