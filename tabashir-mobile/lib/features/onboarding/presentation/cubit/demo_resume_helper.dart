import 'dart:convert';
import 'dart:typed_data';

/// Helper class to provide mock PDF resume data for Apple App Review.
class DemoResumeHelper {
  /// Returns a valid minimal PDF byte array containing a placeholder resume description.
  static Uint8List getDemoPdfBytes() {
    const pdfContent = '%PDF-1.4\n'
        '1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n'
        '2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj\n'
        '3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] /Resources << >> /Contents 4 0 R >> endobj\n'
        '4 0 obj << /Length 135 >> stream\n'
        'BT\n'
        '/F1 12 Tf\n'
        '72 712 Td\n'
        '(Demo Resume - Apple Developer App Store Review Testing) Tj\n'
        '0 -18 Td\n'
        '(Name: Apple Reviewer) Tj\n'
        '0 -18 Td\n'
        '(Role: Software Engineer) Tj\n'
        '0 -18 Td\n'
        '(Skills: Flutter, Dart, Python, Mobile App Development) Tj\n'
        'ET\n'
        'endstream\n'
        'endobj\n'
        'xref\n'
        '0 5\n'
        '0000000000 65535 f \n'
        '0000000009 00000 n \n'
        '0000000056 00000 n \n'
        '0000000111 00000 n \n'
        '0000000220 00000 n \n'
        'trailer << /Size 5 /Root 1 0 R >>\n'
        'startxref\n'
        '400\n'
        '%%EOF';
    return Uint8List.fromList(utf8.encode(pdfContent));
  }
}
