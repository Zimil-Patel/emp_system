import 'dart:developer';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailServices {
  MailServices._();

  static final MailServices mailServices = MailServices._();

  final String username = "nobitanobi1023@gmail.com";
  final String password = "orqi uyib assx zaqh";

  // send email
  Future<bool> sendVerificationMail(String recipientEmail) async {
    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, "Spectrum")
      ..recipients.add(recipientEmail)
      ..subject = 'Employee Verification Approved'
      ..text =
          'Congratulations! Your employee account has been approved. You can now sign in and start using the application.';

    try {
      await send(message, smtpServer);
      log("Email sent: $recipientEmail");
      return true;
    } catch (e) {
      log("Error: $e");
      return false;
    }
  }
}
