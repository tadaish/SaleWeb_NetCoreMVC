using Microsoft.AspNetCore.Mvc;
using SaleWeb33.Models;
using System.Diagnostics;

namespace SaleWeb33.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        SaledbContext da = new SaledbContext(); 
        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            var soluongSP = da.Products.Select(s => s).Count();
            var soluongDH =  da.Orders.Select(s => s).Count();
            var doanhThu = da.OrderDetails.Sum(o => o.Price * o.Quantity);
            ViewBag.soluongSP = soluongSP;  
            ViewBag.soluongDH = soluongDH;
            ViewBag.doanhThu = doanhThu;
            return View();
        }


        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}