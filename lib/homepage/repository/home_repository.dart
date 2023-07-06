import 'package:http/http.dart' as http;

class Repository {
  Future homeapi() async {
    try {
      final response =
          await http.get(Uri.parse('https://reqres.in/api/users/'));
      if (response.statusCode == 200) {
        print(response.statusCode);
        return response;
      } else {
        return "error";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
