using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using SaleWeb33.Extensions;
using SaleWeb33.Models;

namespace SaleWeb33.Controllers
{
    public class BaseController : Controller
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            List<CartModel> carts = HttpContext.Session.GetJson<List<CartModel>>("Cart");

            if (carts == null)
            {
                carts = new List<CartModel>();
                HttpContext.Session.SetJson("Cart", carts);
            }
            // Thêm dữ liệu vào ViewBag ở đây
            ViewBag.demSL = carts.Sum(s => s.Quantity);
            base.OnActionExecuting(filterContext);
        }
    }
}
