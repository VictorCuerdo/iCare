import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:icare/controller/user_controller.dart';
import 'package:printing/printing.dart';

Future<void> printDocument() async {
  final UserController userController = Get.find();

  final pw.Document doc = pw.Document();

  doc.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: <pw.Widget>[
            pw.Text('Nombre del paciente: ${userController.userName.value}',
                style: pw.TextStyle(
                    fontSize: 20.0, font: pw.Font.helveticaBold())),
            pw.Text('Apellido del paciente: ${userController.lastName.value}',
                style: pw.TextStyle(
                    fontSize: 20.0, font: pw.Font.helveticaBold())),
            pw.Text('Correo electrónico: ${userController.email.value}',
                style: pw.TextStyle(
                    fontSize: 20.0, font: pw.Font.helveticaBold())),
            pw.Text('Vacuna aplicada: ${userController.vacunaAplicada.value}',
                style: pw.TextStyle(
                    fontSize: 20.0, font: pw.Font.helveticaBold())),
            pw.Text(
                'Número de dosis aplicadas: ${userController.dosisSeleccionadas.value}',
                style: pw.TextStyle(
                    fontSize: 20.0, font: pw.Font.helveticaBold())),
            pw.Text(
                'Sintomatología: ${userController.symptoms.value.join(', ')}',
                style: pw.TextStyle(
                    fontSize: 20.0, font: pw.Font.helveticaBold())),
          ],
        ),
      ),
    ),
  );

  for (var entry in userController.results.value.entries) {
    if (entry.value is List && entry.value.length > 1) {
      doc.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: <pw.Widget>[
                pw.Text(
                  'Resultado Modelo predicción: ${userController.interpretResult(entry.key, entry.value)}',
                  style:
                      pw.TextStyle(fontSize: 20.0, font: pw.Font.timesBold()),
                ),
                pw.Text(
                  'Precisión de los datos: ${(entry.value[1] * 100).toStringAsFixed(2)}%',
                  style: pw.TextStyle(
                      fontSize: 20.0, font: pw.Font.timesBoldItalic()),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => doc.save(),
  );
}
