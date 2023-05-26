import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TestReportGeneratorAsPdf {
  static Future<void> TEST_REPORT_GENERATOR_AS_PDF({
    required String subject,
    required double mcqsLength,
    required int time,
    required double obtainedMarks,
    required int wrongMcqs,
    required int rightMcqs,
    required int skippedMcqs,
    required int examTakingTime,
  }) async {
    PdfBrush statusColor;
    double precentage = (obtainedMarks / mcqsLength) * 100;
    String status = "";
    if (precentage >= 90) {
      status = "Excellent";
      statusColor = PdfBrushes.green;
    } else if (precentage >= 50) {
      status = "Good";
      statusColor = PdfBrushes.yellow;
    } else if (precentage >= 40) {
      status = "Normal";
      statusColor = PdfBrushes.blue;
    } else {
      status = "Fail";
      statusColor = PdfBrushes.red;
    }
    int minutes = time ~/ 60;
    int seconds = (time % 60);
    int examTakingMinutes = examTakingTime ~/ 60;
    int examTakingSeconds = examTakingTime % 60;
    String mcqsTime =
        "${minutes.toString().padLeft(2, "0")}Min ${seconds.toString().padLeft(2, "0")}Sec";
    String examTakingTimeString =
        "${examTakingMinutes.toString().padLeft(2, "0")}Min ${examTakingSeconds.toString().padLeft(2, "0")}Sec";
    String fileName =
        DateFormat("dd-MMM-yyyy hh:mm:ss a").format(DateTime.now());
    final data = await rootBundle.load("assets/images/ForLightBackground.png");
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    // page.graphics.drawString(
    //   "Test Mentor",
    //   PdfStandardFont(
    //     PdfFontFamily.timesRoman,
    //     20,
    //   ),
    //   bounds: Rect.fromLTWH((page.getClientSize().width / 2 + 5), 35, 300, 50),
    //   format: PdfStringFormat(
    //     alignment: PdfTextAlignment.justify,
    //   ),
    //   brush: PdfBrushes.steelBlue,
    // );
    page.graphics.drawImage(
      PdfBitmap(
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)),
      Rect.fromLTWH(((page.getClientSize().width / 2) - 80), 0, 100, 100),
    );
    page.graphics.drawString(
      "Date: ${DateFormat("dd-MMM-yyyy").format(DateTime.now())}",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.getClientSize().width - 150, 100, 300, 50),
    );
    page.graphics.drawString(
      "Time: ${DateFormat("hh:mm a").format(DateTime.now())}",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.getClientSize().width - 150, 120, 300, 50),
    );
    page.graphics.drawString(
      "Quiz Status: $status",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.getClientSize().width - 150, 140, 300, 50),
      brush: statusColor,
    );
    // page.graphics.drawString(
    //   "Ahmad Khan",
    //   PdfStandardFont(PdfFontFamily.timesRoman, 18),
    //   bounds: Rect.fromLTWH(0, 160, 300, 50),
    // );
    page.graphics.drawString(
      "Test Subject: $subject",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(0, 180, page.getClientSize().width, 50),
    );
    page.graphics.drawString(
      "Mcqs Length: $mcqsLength",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(0, 200, page.getClientSize().width, 50),
    );
    page.graphics.drawString(
      "Test Total Duration: $mcqsTime",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(0, 220, page.getClientSize().width, 50),
    );
    page.graphics.drawString(
      "Test Duration: $examTakingTimeString",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(0, 250, page.getClientSize().width, 50),
    );
    page.graphics.drawString(
      "Result",
      PdfStandardFont(PdfFontFamily.timesRoman, 25),
      bounds:
          Rect.fromLTWH((page.getClientSize().width / 2) - 35, 280, 200, 50),
    );

    page.graphics.drawString(
      "Total Marks",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .1, 310, 100, 50),
    );
    page.graphics.drawString(
      "Obtain Marks",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .35, 310, 100, 50),
    );
    page.graphics.drawString(
      "Precentage",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .6, 310, 100, 50),
    );
    page.graphics.drawString(
      "$mcqsLength",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .15, 330, 100, 50),
    );
    page.graphics.drawString(
      "$obtainedMarks",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .40, 330, 100, 50),
    );
    page.graphics.drawString(
      ((obtainedMarks / mcqsLength) * 100).toStringAsFixed(2),
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .62, 330, 100, 50),
    );

    page.graphics.drawString(
      "Right: $rightMcqs",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .1, 355, 100, 50),
    );
    page.graphics.drawString(
        "Worng: $wrongMcqs", PdfStandardFont(PdfFontFamily.timesRoman, 18),
        bounds: Rect.fromLTWH(page.size.width * .35, 355, 100, 50),
        brush: PdfBrushes.red);
    page.graphics.drawString(
      "Skipped: $skippedMcqs",
      PdfStandardFont(PdfFontFamily.timesRoman, 18),
      bounds: Rect.fromLTWH(page.size.width * .6, 355, 100, 50),
    );
    page.graphics.drawString(
      "Develop By Ahmad Khan & Hamza Sher",
      PdfStandardFont(PdfFontFamily.timesRoman, 12),
      bounds: Rect.fromLTWH(
          page.size.width * .30, page.getClientSize().height - 15, 300, 50),
    );

    List<int> bytes = await document.save();
    document.dispose();
    await TestReportGeneratorAsPdf()._saveAndLaunchFile(bytes, "$fileName.pdf");
    // final path = (await getExternalStorageDirectory())!.path;
    // final file = File("$path/Quiz Report $fileName");
    // await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open('$path/$fileName');
    // print('$path/$fileName');
  }

  Future<void> _saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File("$path/$fileName");
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
    print('$path/$fileName');
  }
}
