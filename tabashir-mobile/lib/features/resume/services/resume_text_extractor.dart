import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';
import 'package:xml/xml.dart';

/// Utility that extracts plain text from supported resume formats on-device.
class ResumeTextExtractor {
  const ResumeTextExtractor._();

  /// Extracts text from the given [file]. Returns an empty string if the
  /// conversion fails or the extension is unsupported.
  static Future<String> extractText(File file) async {
    final lowerPath = file.path.toLowerCase();

    try {
      if (lowerPath.endsWith('.txt')) {
        return _extractText(file);
      }

      if (lowerPath.endsWith('.pdf')) {
        return _extractPdf(file);
      }

      if (lowerPath.endsWith('.docx')) {
        return _extractDocx(file);
      }
    } catch (e) {
      // Intentionally swallow exceptions to allow server-side fallback later.
      print('⚠️ [RESUME_TEXT_EXTRACTOR] Failed to extract text: $e');
    }

    return '';
  }

  static Future<String> _extractText(File file) async {
    final bytes = await file.readAsBytes();
    return utf8.decode(bytes);
  }

  static Future<String> _extractPdf(File file) async {
    final doc = await PDFDoc.fromFile(file);
    final text = await doc.text;
    return text.trim();
  }

  static Future<String> _extractDocx(File file) async {
    final bytes = await file.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes, verify: true);
    final documentFile = archive.files.firstWhere(
      (entry) => entry.name == 'word/document.xml',
      orElse: () => ArchiveFile('word/document.xml', 0, const <int>[]),
    );

    if (!documentFile.isFile || documentFile.size == 0) {
      return '';
    }

    final xmlBytes = documentFile.content as List<int>;
    final xmlString = utf8.decode(xmlBytes);
    final xmlDocument = XmlDocument.parse(xmlString);

    final buffer = StringBuffer();
    for (final node in xmlDocument.findAllElements('w:t')) {
      buffer.write(node.text);
      buffer.write(' ');
    }

    return buffer.toString().trim();
  }
}
