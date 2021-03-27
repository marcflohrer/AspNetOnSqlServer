using Microsoft.AspNetCore.Mvc;

namespace app.Controllers
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