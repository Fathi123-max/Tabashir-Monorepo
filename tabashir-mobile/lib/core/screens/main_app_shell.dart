import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/jobs/presentation/cubit/jobs_cubit.dart';
import '../../features/jobs/presentation/screens/jobs_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../features/shared/widgets/widgets.dart';
import '../di/injection.dart';

class MainAppShell extends StatefulWidget {
  const MainAppShell({
    super.key,
    this.onTabChange,
  });

  final void Function(int)? onTabChange;

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.onTabChange?.call(index);
  }

  List<Widget> get _screens => [
    HomeScreen(
      onTabChange: _changeTab,
    ),
    const JobsScreen(),

    const ServicesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => BlocProvider<JobsCubit>(
    create: (context) => getIt<JobsCubit>(),
    child: Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeTab,
      ),
    ),
  );
}
