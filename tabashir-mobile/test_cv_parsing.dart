import 'dart:convert';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();

  const resumeText = '''
    John Doe
    Email: john.doe@example.com
    Phone: +1234567890

    Experience:
    - Senior Developer at ABC Corp (2020-2023)
    - Junior Developer at XYZ Ltd (2018-2020)

    Education:
    - BSc Computer Science, University of Tech (2016-2020)

    Skills:
    - Flutter, Dart, Firebase, Python, Java
  ''';

  try {
    final response = await dio.post(
      'https://backend.tabashir.ae/api/v1/resume/format-cv-object',
      data: {
        'rawData': resumeText,
        'outputLanguage': 'regular',
      },
    );

    if (response.statusCode == 200) {
      print('✅ API Response:');
      print(json.encode(response.data));
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Exception: $e');
  }
}
