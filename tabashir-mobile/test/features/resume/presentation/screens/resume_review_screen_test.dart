import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_review_cubit.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_review_state.dart';
import 'package:tabashir/features/resume/presentation/screens/resume_review_screen.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ResumeReviewCubit mockResumeReviewCubit;
  final getIt = GetIt.instance;

  setUpAll(() {
    provideDummy<ResumeReviewState>(const ResumeReviewState());
  });

  setUp(() {
    mockResumeReviewCubit = MockResumeReviewCubit();
    when(mockResumeReviewCubit.stream).thenAnswer((_) => const Stream.empty());
    getIt.registerFactory<ResumeReviewCubit>(() => mockResumeReviewCubit);
  });

  tearDown(getIt.reset);

  final testData = {
    'fullName': 'John Doe',
    'email': 'john.doe@example.com',
    'skills': ['Flutter', 'Dart'],
  };

  Widget buildTestWidget() => ScreenUtilInit(
    designSize: const Size(375, 812),
    builder: (context, child) => MaterialApp(
      home: BlocProvider.value(
        value: mockResumeReviewCubit,
        child: const ResumeReviewScreen(),
      ),
    ),
  );

  testWidgets('ResumeReviewScreen renders all sections', (tester) async {
    when(mockResumeReviewCubit.state).thenReturn(
      ResumeReviewState(data: testData),
    );

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Personal Info'), findsOneWidget);

    // Scroll until elements are visible
    final scrollable = find.byType(Scrollable).first;

    final summaryFinder = find.text('Summary');
    await tester.scrollUntilVisible(
      summaryFinder,
      100,
      scrollable: scrollable,
    );
    expect(summaryFinder, findsOneWidget);

    final experienceFinder = find.text('Experience');
    await tester.scrollUntilVisible(
      experienceFinder,
      100,
      scrollable: scrollable,
    );
    expect(experienceFinder, findsOneWidget);

    final educationFinder = find.text('Education');
    await tester.scrollUntilVisible(
      educationFinder,
      100,
      scrollable: scrollable,
    );
    expect(educationFinder, findsOneWidget);

    final skillsFinder = find.text('Skills');
    await tester.scrollUntilVisible(
      skillsFinder,
      100,
      scrollable: scrollable,
    );
    expect(skillsFinder, findsOneWidget);
  });

  testWidgets('Confirm button is disabled when critical fields are missing', (
    tester,
  ) async {
    when(mockResumeReviewCubit.state).thenReturn(
      const ResumeReviewState(),
    );

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNull);
  });

  testWidgets('Confirm button is enabled when critical fields are present', (
    tester,
  ) async {
    when(mockResumeReviewCubit.state).thenReturn(
      ResumeReviewState(data: testData),
    );

    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });
}
