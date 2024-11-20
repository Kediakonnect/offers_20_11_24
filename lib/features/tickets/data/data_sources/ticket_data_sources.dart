import 'package:divyam_flutter/core/api/custom_client.dart';
import 'package:divyam_flutter/core/constants/url_constants.dart';
import 'package:divyam_flutter/core/error/exception.dart';
import 'package:divyam_flutter/core/response/api_base_response.dart';
import 'package:divyam_flutter/features/tickets/domain/entity/create_ticket_entity.dart';

class TicketDataSources {
  final CustomHttpClient _client = CustomHttpClient();

  Future<ApiBaseResponseNoData> createTicket(
      {required CreateTicketEntity entity}) async {
    try {
      final res = await _client.createMultipartRequest(
          formData: entity.toFormData(), url: createTicketUrl);

      final decoded = res.data;

      if (decoded['success'] == false) {
        throw ApiException(message: decoded['message']);
      } else {
        return ApiBaseResponseNoData.fromJson(decoded);
      }
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
