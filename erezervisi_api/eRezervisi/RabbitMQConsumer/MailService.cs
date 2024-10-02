using MimeKit;
using MimeKit.Text;
using MailKit.Net.Smtp;
using Newtonsoft.Json;
using System.Net.Mail;
using SmtpClient = MailKit.Net.Smtp.SmtpClient;

namespace RabbitMQConsumer
{
    public class MailService
    {
        public void Send(string message)
        {
            try
            {
                string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com";
                int smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "465");
                string fromMail = Environment.GetEnvironmentVariable("SMTP_USERNAME") ?? "kenancopelj@gmail.com";
                string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "zvjq jzmd bmmc lhxk";

                var emailData = JsonConvert.DeserializeObject<MailDto>(message);
                var senderEmail = emailData.Sender;
                var recipientEmail = emailData.Recipient;
                var subject = emailData.Subject;
                var content = emailData.Content;

                var mailObj = new MimeMessage();

                mailObj.Sender = MailboxAddress.Parse(senderEmail);

                mailObj.To.Add(MailboxAddress.Parse(recipientEmail));

                mailObj.Subject = subject;
                mailObj.Body = new TextPart(TextFormat.Plain)
                {
                    Text = content
                };

                using (var smtpClient = new SmtpClient())
                {
                    smtpClient.Connect(smtpServer, smtpPort, true);
                    smtpClient.Authenticate(fromMail, password);
                    smtpClient.Send(mailObj);
                    smtpClient.Disconnect(true);
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending email: {ex.Message}");
            }
        }
    }
}
