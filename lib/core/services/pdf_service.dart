import 'package:countries_navigator/features/countries/domain/entities/country.dart';

class PdfService {
  import 'package:pdf/pdf.dart';
  import 'package:pdf/widgets.dart' as pw;
  
  class PdfService {
    pw.Document preparePDF(List<String> data) {
      // Implementation for preparing the PDF using the provided data
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(data.join('\n')),
            );
          },
        ),
      );
      return pdf;
    }
  }