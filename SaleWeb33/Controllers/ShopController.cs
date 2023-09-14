using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SaleWeb33.Extensions;
using SaleWeb33.Models;

namespace SaleWeb33.Controllers
{

    public class ShopController : BaseController
    {
        SaledbContext da = new SaledbContext();
        // GET: ShopController
        [Route("/")]
        public ActionResult Index()
        {
            ViewModel viewModel = new ViewModel();
            viewModel.Products = GetProducts();
            return View(viewModel);

        }

        [Route("/products/{id}")]
        public ActionResult ProductDetails(int id)
        {
            Product p = da.Products.Where(s => s.ProductId == id).Include(p => p.Brand)
                                  .Include(p => p.Category)
                                  .Include(p => p.Color)
                                  .Include(p => p.Size).FirstOrDefault();
            return View(p);
        }

        [Route("/categories/{id}")]
        public ActionResult Categories(int id)
        {
            List<Product> ds = da.Products.Where(s => s.CategoryId == id).ToList();
            return View(ds);
        }

        public List<Product> GetProducts()
        {

            List<Product> ds = da.Products.Include(p => p.Brand)
                                    .Include(p => p.Category)
                                    .Include(p => p.Color)
                                    .Include(p => p.Size)
                                    .ToList();

            return ds;
        }

    }
}
