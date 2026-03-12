import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/models/resume_response/resume_item.dart';

import '../../../../core/theme/app_theme.dart';

class ResumePreviewScreen extends StatefulWidget {
  const ResumePreviewScreen({
    super.key,
    required this.resume,
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

      // Download the PDF to temporary file
      final dir = await getTemporaryDirectory();
      final fileName = '${widget.resume.filename}.pdf';
      final filePath = '${dir.path}/$fileName';

      final dio = Dio();
      await dio.download(
        url,
        filePath,
      );

      // Open the PDF
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Failed to download resume file');
      }

      final controller = PdfController(
        document: PdfDocument.openFile(filePath),
      );

      if (mounted) {
        setState(() {
          _pdfController = controller;
          _isLoading = false;
        });
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
            icon: const Icon(Icons.download),
            onPressed: () => _downloadResume(context),
            tooltip: 'Download',
          ),
        ],
      ),
      body: _buildBody(context),
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

  Widget _buildBody(BuildContext context) {
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

    if (_pdfController == null) {
      return const Center(
        child: Text('No PDF data available'),
      );
    }

    return PdfView(
      controller: _pdfController!,
      scrollDirection: Axis.vertical,
      pageSnapping: true,
      physics: const BouncingScrollPhysics(),
    );
  }

  Future<void> _downloadResume(BuildContext context) async {
    try {
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      // Check if originalUrl is available
      final url = widget.resume.originalUrl;
      if (url == null || url.isEmpty) {
        throw Exception('Resume URL is not available');
      }

      final dir = await getApplicationDocumentsDirectory();
      final fileName = '${widget.resume.filename}.pdf';
      final filePath = '${dir.path}/$fileName';

      final dio = Dio();
      await dio.download(
        url,
        filePath,
      );

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Resume downloaded to $filePath'),
          backgroundColor: AppTheme.successColor,
          action: SnackBarAction(
            label: 'View',
            textColor: Colors.white,
            onPressed: () {
              // Open file location (not possible on all platforms)
            },
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
}
