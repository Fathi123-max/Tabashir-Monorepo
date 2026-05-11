import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/_clients/auth_dio_client.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import '../../../../core/network/models/resume_response/resume_item.dart';

class ResumePreviewScreen extends StatefulWidget {
  const ResumePreviewScreen({
    required this.resume,
    super.key,
  });

  final ResumeItem resume;

  @override
  State<ResumePreviewScreen> createState() => _ResumePreviewScreenState();
}

class _ResumePreviewScreenState extends State<ResumePreviewScreen> {
  PdfController? _pdfController;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  Future<void> _loadPdf() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Check if originalUrl is available
      final url = widget.resume.originalUrl;
      if (url == null || url.isEmpty) {
        throw Exception('Resume URL is not available');
      }

      // Detect file type
      final bool isDocx =
          widget.resume.filename.toLowerCase().endsWith('.docx') ||
          widget.resume.fileType.toLowerCase() == 'docx';

      // Download the file to temporary directory
      final dir = await getTemporaryDirectory();

      // Ensure we don't double the extension
      String fileName = widget.resume.filename;
      final extension = isDocx ? '.docx' : '.pdf';
      if (!fileName.toLowerCase().endsWith(extension)) {
        fileName = '$fileName$extension';
      }
      final filePath = '${dir.path}/$fileName';

      if (url.startsWith('http')) {
        final token = await AuthSessionService.instance.accessToken;
        final dio = getIt<AuthDioClient>().dio;
        await dio.download(
          url,
          filePath,
          options: Options(
            headers: {
              if (token != null) 'Authorization': 'Bearer $token',
            },
          ),
        );
      } else {
        // Handle local file path
        final sourceFile = File(url);
        if (await sourceFile.exists()) {
          // If it's already in a good location, we can use it directly,
          // but for consistency with the rest of the logic, we'll copy it to the temp path.
          await sourceFile.copy(filePath);
        } else {
          throw Exception('Local resume file not found at $url');
        }
      }

      // Verify file existence
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Failed to download resume file');
      }

      // If it's a PDF, initialize the PDF controller
      if (!isDocx) {
        final controller = PdfController(
          document: PdfDocument.openFile(filePath),
        );

        if (mounted) {
          setState(() {
            _pdfController = controller;
            _isLoading = false;
          });
        }
      } else {
        // For DOCX, we just finish loading without a PDF controller
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDocx =
        widget.resume.filename.toLowerCase().endsWith('.docx') ||
        widget.resume.fileType.toLowerCase() == 'docx';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.resume.filename,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _downloadAndShare(context, isDocx ? 'docx' : 'pdf'),
            tooltip: 'Share',
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadResume(context, isDocx ? 'docx' : 'pdf'),
            tooltip: 'Download',
          ),
        ],
      ),
      body: _buildBody(context, isDocx),
      floatingActionButton: _pdfController != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'prev',
                  onPressed: () => _pdfController?.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: const Icon(Icons.chevron_left),
                ),
                SizedBox(height: 10.h),
                FloatingActionButton(
                  heroTag: 'next',
                  onPressed: () => _pdfController?.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: const Icon(Icons.chevron_right),
                ),
              ],
            )
          : null,
    );
  }

  Widget _buildBody(BuildContext context, bool isDocx) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(height: 16.h),
            Text(
              'Loading resume...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.sp,
                color: AppTheme.errorColor,
              ),
              SizedBox(height: 16.h),
              Text(
                'Failed to load resume',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: _loadPdf,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (isDocx) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description,
                size: 80.sp,
                color: Colors.blue.shade700,
              ),
              SizedBox(height: 24.h),
              Text(
                'Word Document',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Previews are not available for DOCX files in-app. You can download and open it with your favorite office app.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              ElevatedButton.icon(
                onPressed: () => _downloadResume(context, 'docx'),
                icon: const Icon(Icons.download),
                label: const Text('Download & View'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_pdfController == null) {
      return const Center(
        child: Text('No PDF data available'),
      );
    }

    return PdfView(
      controller: _pdfController!,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
    );
  }

  Future<void> _downloadResume(BuildContext context, String format) async {
    try {
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      // Check if originalUrl is available
      final url = widget.resume.originalUrl;
      if (url == null || url.isEmpty) {
        throw Exception('Resume URL is not available');
      }

      // Add format parameter to URL
      final downloadUrl = url.contains('?')
          ? '$url&output_format=$format'
          : '$url?output_format=$format';

      final dir = await getApplicationDocumentsDirectory();
      final dotExtension = format == 'docx' ? '.docx' : '.pdf';

      // Clean fileName
      String baseFileName = widget.resume.filename;
      if (baseFileName.toLowerCase().endsWith('.pdf'))
        baseFileName = baseFileName.substring(0, baseFileName.length - 4);
      if (baseFileName.toLowerCase().endsWith('.docx'))
        baseFileName = baseFileName.substring(0, baseFileName.length - 5);

      final fileName = '$baseFileName$dotExtension';
      final filePath = '${dir.path}/$fileName';

      final token = await AuthSessionService.instance.accessToken;
      final dio = getIt<AuthDioClient>().dio;

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Downloading ${format.toUpperCase()}...'),
          duration: const Duration(seconds: 1),
        ),
      );

      await dio.download(
        downloadUrl,
        filePath,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Resume downloaded successfully'),
          backgroundColor: AppTheme.successColor,
          action: SnackBarAction(
            label: 'Open',
            textColor: Colors.white,
            onPressed: () => OpenFilex.open(filePath),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _downloadAndShare(BuildContext context, String format) async {
    try {
      final url = widget.resume.originalUrl;
      if (url == null || url.isEmpty) throw Exception('URL not available');

      final downloadUrl = url.contains('?')
          ? '$url&output_format=$format'
          : '$url?output_format=$format';

      final tempDir = await getTemporaryDirectory();
      final ext = format == 'docx' ? '.docx' : '.pdf';

      String baseFileName = widget.resume.filename;
      if (baseFileName.toLowerCase().endsWith('.pdf'))
        baseFileName = baseFileName.substring(0, baseFileName.length - 4);
      if (baseFileName.toLowerCase().endsWith('.docx'))
        baseFileName = baseFileName.substring(0, baseFileName.length - 5);

      final filePath =
          '${tempDir.path}/share_${baseFileName}_${DateTime.now().millisecondsSinceEpoch}$ext';

      final token = await AuthSessionService.instance.accessToken;
      final dio = getIt<AuthDioClient>().dio;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preparing ${format.toUpperCase()} for sharing...'),
          duration: const Duration(seconds: 1),
        ),
      );

      await dio.download(
        downloadUrl,
        filePath,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      final result = await Share.shareXFiles([
        XFile(filePath),
      ], text: 'My Resume');

      if (result.status == ShareResultStatus.success) {
        AppLogger.debug('File shared successfully');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }
}
