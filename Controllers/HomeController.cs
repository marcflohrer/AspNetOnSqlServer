using Microsoft.AspNetCore.Mvc;

namespace MyDemoApp.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }
    }
}