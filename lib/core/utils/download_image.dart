import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class NetworkImageHelper {
  static Future<File?> downloadAndSaveImageTemp(String imageUrl) async {
    // Fetch image data from the network
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Get the temporary directory
      final directory = await getTemporaryDirectory();

      // Create a file path
      final fileName = path.basename(imageUrl);
      final filePath = path.join(directory.path, fileName);

      // Save the image data to the file
      final file = File(filePath);
      return await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Failed to download image');
    }
  }
}
