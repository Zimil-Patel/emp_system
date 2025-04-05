import 'dart:developer';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class ExportServices{

  static final String todayDate = DateFormat('yMMMd').format(DateTime.now());

  static final List<Map<String, dynamic>> attendanceSampleData = [
    {
      "Employee": "Zimil Patel",
      "Email": "patelzimil2310@gmail.com",
      "Check-in Time": "10:15 AM",
      "Check-out Time": "06:00 PM",
    },
    {
      "Employee": "Satyam Yadav",
      "Email": "satyam21@gmail.com",
      "Check-in Time": "09:00 AM",
      "Check-out Time": "05:30 PM",
    },
    {
      "Employee": "Yogesh Sharma",
      "Email": "yogesh24@gmail.com",
      "Check-in Time": "10:30 AM",
      "Check-out Time": "04:45 PM",
    },
    {
      "Employee": "Priya Mehta",
      "Email": "priya.m@gmail.com",
      "Check-in Time": "09:10 AM",
      "Check-out Time": "06:15 PM",
    },
  ];


  static Future<void> exportToPDF(List<Map<String, dynamic>> data, String filename,
      {String? title}) async {
    final pdf = pw.Document();
    final date = DateFormat('yMMMd').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Center(child: pw.Text("Spectrum", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),),
            pw.SizedBox(height: 5),
            pw.Center(child: pw.Text("Attendance Report ${title!=null ? "($title)" : ""}", style: pw.TextStyle(fontSize: 18))),
            pw.SizedBox(height: 5),
            pw.Text("Date: $date", style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),

            pw.Table.fromTextArray(
              headers: data.first.keys.toList(),
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

  static Future<void> exportToCSV(List<Map<String, dynamic>> data, String fileName, {String? title}) async {

    final now = DateFormat.yMMMd().format(DateTime.now());
    final List<List<String>> csvData = [
      ['My Company Pvt. Ltd.', '', '', ''],
      ['Attendance Report','', '', ''],
      ['Date: $now'],
      ['Employee', 'Email', 'Check-in Time', 'Check-out Time'],
      ...data.map((e) => [
        e['Employee'] ?? '',
        e['Email'] ?? '',
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