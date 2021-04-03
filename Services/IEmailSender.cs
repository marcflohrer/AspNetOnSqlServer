using System.Threading.Tasks;

namespace MyDemoApp.Services
{
    public interface IEmailSender
    {
        Task SendEmailAsync(string email, string subject, string message);
    }
}