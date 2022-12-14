import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

import '../config/variables.dart';

// Source: https://medium.com/flutter-community/paypal-payment-gateway-integration-in-flutter-379fbb3b87f5
class PayPalAPI {
  static String? domain = Variables.paypalDomain;
  static String? clientId = Variables.payPalClientId;
  static String? secret = Variables.payPalClientSecret;

  // for getting the access token from Paypal
  static Future<String?> getAccessToken() async {
    if (domain == null || clientId == null || secret == null) {
      return Future.error(
          "PayPal environemt isn't found. Contact app owner for repair this issue.");
    }

    try {
      var client = BasicAuthClient(clientId!, secret!);
      var response = await client.post(
          Uri.parse('$domain/v1/oauth2/token?grant_type=client_credentials'));

      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  static Future<Map<String, String>?> createPaypalPayment(
      transactions, accessToken) async {
    if (domain == null || clientId == null || secret == null) {
      return Future.error(
          "PayPal environemt isn't found. Contact app owner for repair this issue.");
    }

    try {
      var response = await http.post(
        Uri.parse("$domain/v1/payments/payment"),
        body: convert.jsonEncode(transactions),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
      );

      final body = convert.jsonDecode(response.body);

      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  static Future<String?> executePayment(url, payerId, accessToken) async {
    if (domain == null || clientId == null || secret == null) {
      return Future.error(
          "PayPal environemt isn't found. Contact app owner for repair this issue.");
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        body: convert.jsonEncode({"payer_id": payerId}),
        headers: {
          "content-type": "application/json",
          'Authorization': 'Bearer $accessToken'
        },
      );

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
