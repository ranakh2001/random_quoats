import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:random_quoats/models/image_model.dart';
import 'package:random_quoats/models/quote_model.dart';

class Network {
  String category = "";
  Future<QuoteModel> getQuote() async {
    http.Response response =
        await http.get(Uri.parse("https://api.quotable.io/random"));
    if (response.statusCode == 200) {
      QuoteModel quoteModel = QuoteModel.fromJson(jsonDecode(response.body));
      category = quoteModel.tags![0];
      return quoteModel;
    } else {
      return Future.error("something wrong");
    }
  }

  Future<ImageModel> getImage() async {
    http.Response response = await http.get(Uri.parse(
        "https://random.imagecdn.app/v1/image?category=$category&format=json"));
    if (response.statusCode == 200) {
      ImageModel image = ImageModel.fromJson(jsonDecode(response.body));
      return image;
    } else {
      return Future.error("something wrong");
    }
  }
}
