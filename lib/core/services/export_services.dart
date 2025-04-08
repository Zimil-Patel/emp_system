import 'dart:developer';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:emp_system/utils/constants.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class ExportServices {
  static final String todayDate = DateFormat('yMMMd').format(DateTime.now());

  static Future<void> exportToPDF(String filename, {String? title}) async {
    final pdf = pw.Document();
    final date =
        DateFormat.yMMMd().format(supervisorController.selectedDate.value);
    List<Map<String, dynamic>> data = supervisorController.filteredList
        .map((e) => e.toMap() as Map<String, dynamic>)
        .toList();
    List<dynamic> headers;

    if (data.isEmpty) {
      headers = ["ID", "Employee", "Check-in Time", "Check-out Time"];
    } else {
      headers = data.first.keys.toList();
    }

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Center(
              child: pw.Text("Spectrum",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
                child: pw.Text(
                    "Attendance Report ${title != null ? "($title)" : ""}",
                    style: pw.TextStyle(fontSize: 18))),
            pw.SizedBox(height: 5),
            pw.Text("Date: $date", style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Table.fromTextArray(
              headers: headers,
              data: data.map((e) => e.values.toList()).toList(),
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              cellAlignment: pw.Alignment.centerLeft,
            )
          ],
        ),
      ),
    );

    final dir = await getTemporaryDirectory();
    final path = "${dir.path}/$filename.pdf";
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    log("CSV exported to $file");
    Share.shareXFiles([XFile(path)], text: 'Exported PDF');
  }

  static Future<void> exportToCSV(String fileName, {String? title}) async {
    final date =
        DateFormat.yMMMd().format(supervisorController.selectedDate.value);
    List<Map<String, dynamic>> data = supervisorController.filteredList
        .map((e) => e.toMap() as Map<String, dynamic>)
        .toList();

    final List<List<String>> csvData = [
      ['My Company Pvt. Ltd.', '', '', ''],
      ['Attendance Report ${title != null ? "($title)" : ""}', '', '', ''],
      ['Date: $date'],
      ['ID', 'Employee', 'Check-in Time', 'Check-out Time'],
      ...data.map((e) => [
            e['ID'] ?? '',
            e['Employee'] ?? '',
            e['Check-in Time'] ?? '',
            e['Check-out Time'] ?? '',
          ])
    ];

    final csvContent = const ListToCsvConverter().convert(csvData);
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$fileName.csv';
    final file = File(path);
    await file.writeAsString(csvContent);

    Share.shareXFiles([XFile(path)], text: 'Exported CSV');
  }
}
