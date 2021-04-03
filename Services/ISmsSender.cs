using System.Threading.Tasks;

namespace MyDemoApp.Services
{
    public interface ISmsSender
    {
        Task SendSmsAsync(string number, string message);
    }
}