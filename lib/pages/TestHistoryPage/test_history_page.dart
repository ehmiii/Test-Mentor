import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import '/utils/constants.dart';
import '/utils/widgets/custom_appbar.dart';
import '/utils/widgets/show_toast.dart';

class TestHistoryPage extends StatefulWidget {
  @override
  State<TestHistoryPage> createState() => _TestHistoryPageState();
}

class _TestHistoryPageState extends State<TestHistoryPage> {
  Future<List<FileSystemEntity>> filesPath() async {
    final path = (await getExternalStorageDirectory())!.path;
    final listOfReports = Directory(path).listSync();
    listOfReports.reversed;
    return listOfReports;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FileSystemEntity>>(
        future: filesPath(),
        builder: (context, filesPaths) {
          return Scaffold(
            backgroundColor: Constants.LIGHT_BLUE_COLOR,
            appBar: CustomAppBar.CUSTOM_APPBAR(
              context: context,
              title: "History",
              isLeadingBack: true,
            ),
            body: RefreshIndicator(
              onRefresh: () => filesPath(),
              child: filesPaths.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : filesPaths.data!.isEmpty
                      ? Center(
                          child: Text(
                            "No Test result found",
                            style: TextStyle(
                              color: Constants.DARK_BLUE_COLOR,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (_, index) {
                            return Card(
                              color: Constants.DARK_BLUE_COLOR,
                              child: ListTile(
                                onTap: () async {
                                  try {
                                    final result = await OpenFile.open(
                                      filesPaths.data?[index].path,
                                    );
                                  } catch (error) {
                                    ShowToast.SHOW_TOAST(error.toString());
                                  }
                                },
                                title: Row(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset(
                                        Constants.PDF_ICON,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "${filesPaths.data?[index].toString().split("/").last.replaceAll(".pdf'", "")}",
                                        style: TextStyle(
                                          color: Constants.LIGHT_BLUE_COLOR,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                                contentPadding: EdgeInsets.only(left: 20),
                                trailing: IconButton(
                                    onPressed: () {
                                      final targetFile =
                                          filesPaths.data?[index];
                                      if (targetFile!.existsSync()) {
                                        targetFile.deleteSync(recursive: true);
                                      }
                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                        EdgeInsets.zero,
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ),
                            );
                          },
                          itemCount: filesPaths.data?.length,
                        ),
            ),
          );
        });
  }
}
