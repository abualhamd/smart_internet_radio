import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/config/routes_manager.dart';
import '../../../../app/core/utils/app_strings.dart';
import '../../../../app/core/utils/icons_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: IconsManager.arrowBack,
            onPressed: () {
              Navigator.pushNamed(context, Routes.homeRoute);
            },
          ),
          title: const Text(AppStrings.about),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22.w,
                vertical: 10.h,
              ),
              child: Text(
                AppStrings.aboutScreenDescription,
                style: TextStyle(fontSize: 18.sp, height: 1.4),
              ),
            ),
            DataTable(
                columns: const [
                  DataColumn(label: Text(AppStrings.command)),
                  DataColumn(label: Text(AppStrings.commandExplaination))
                ],
                rows: _commands
                    .map((command) => DataRow(cells: [
                          DataCell(Text(command.name)),
                          DataCell(Text(command.explaination))
                        ]))
                    .toList()),
          ],
        ),
      ),
    );
  }
}

class Command {
  final String name;
  final String explaination;

  Command({required this.name, required this.explaination});
}

final List<Command> _commands = [
  Command(name: 'play', explaination: 'play current channel'),
  Command(name: 'play <channel_name>', explaination: 'play a certain channel'),
  Command(name: 'pause/stop', explaination: 'pause audio'),
  Command(name: 'next/skip', explaination: 'skip to the next channel'),
  Command(name: 'previous', explaination: 'play the previous channel'),
  Command(
      name: 'category <category_name>',
      explaination: 'play a random channel from a certain category'),
  Command(
      name: 'add favorite',
      explaination: 'add the current channel to favorites'),
  Command(
      name: 'favorite <channel_name>',
      explaination: 'add a certain channel to favorites'),
];
