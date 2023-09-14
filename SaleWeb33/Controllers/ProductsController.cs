using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.Identity.Client;
using SaleWeb33.Extensions;
using SaleWeb33.Models;
using SaleWeb33.Setting;

namespace SaleWeb33.Controllers
{
    public class ProductsController : Controller
    {
        SaledbContext da = new SaledbContext();

        private readonly Cloudinary cloudinary;
        public ProductsController(IOptions<CloudinarySetting> config)
        {
            var account = new Account(
                config.Value.CloudName,
                config.Value.ApiKey,
                config.Value.ApiSecret);

            cloudinary = new Cloudinary(account);
        }

        // GET: ProductsController
        public ActionResult Index()
        {
            List<Product> ds = da.Products.Include(p => p.Brand)
                                    .Include(p => p.Category)
                                    .Include(p => p.Color)
                                    .Include(p => p.Size)
                                    .ToList(); ;
            return View(ds);

        }

        // GET: ProductsController/Details/5
        public ActionResult Details(int id)
        {
            Product p = da.Products.Where(s => s.ProductId == id).Include(p => p.Brand)
                                    .Include(p => p.Category)
                                    .Include(p => p.Color)
                                    .Include(p => p.Size).FirstOrDefault();
            //Product p2 = da.Products.FirstOrDefault(s=>s.ProductID == id);
            return View(p);
        }

        // GET: ProductsController/Create
        public ActionResult Create()
        {
            ViewData["BrandId"] = new SelectList(da.Brands, "BrandId", "BrandName");
            ViewData["CategoryId"] = new SelectList(da.Categories, "CategoryId", "CategoryName");
            ViewData["SizeId"] = new SelectList(da.Sizes, "SizeId", "SizeOption");
            ViewData["ColorId"] = new SelectList(da.Colors, "ColorId", "ColorName");
            return View();
        }

        // POST: ProductsController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Product p, IFormCollection collection)
        {
            try
            {
                ;
                // TODO: Add insert logic here
                p.CategoryId = int.Parse(collection["CategoryId"]);
                p.BrandId = int.Parse(collection["BrandId"]);
                p.SizeId = int.Parse(collection["SizeId"]);
                p.ColorId = int.Parse(collection["ColorId"]);
                if (collection.Files["photo"] != null)
                {
                    p.Images = Upload(collection);
                }


                da.Products.Add(p);
                da.SaveChanges();

                return RedirectToAction("Index");
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
                return View();
            }
        }

        // GET: ProductsController/Edit/5
        public ActionResult Edit(int id)
        {
            Product p = da.Products.FirstOrDefault(s => s.ProductId == id);

            ViewData["BrandId"] = new SelectList(da.Brands, "BrandId", "BrandName");
            ViewData["CategoryId"] = new SelectList(da.Categories, "CategoryId", "CategoryName");
            ViewData["SizeId"] = new SelectList(da.Sizes, "SizeId", "SizeOption");
            ViewData["ColorId"] = new SelectList(da.Colors, "ColorId", "ColorName");

            return View(p);
        }

        // POST: ProductsController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Product product, IFormCollection collection)
        {
            try
            {
                // TODO: Add update logic here
                Product p = da.Products.First(s => s.ProductId == product.ProductId);
                p.ProductId = product.ProductId;
                p.ProductName = product.ProductName;
                p.Price = product.Price;
                p.UnitsInStock = product.UnitsInStock;
                p.Quantity = product.Quantity;
                p.Description = product.Description;
                if (collection.Files["photo"] != null)
                {
                    p.Images = Upload(collection);
                }




                p.CategoryId = int.Parse(collection["CategoryId"]);
                p.BrandId = int.Parse(collection["BrandId"]);
                p.SizeId = int.Parse(collection["SizeId"]);
                p.ColorId = int.Parse(collection["ColorId"]);

                da.Products.Update(p);
                da.SaveChanges();

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: ProductsController/Delete/5
        public ActionResult Delete(int id)
        {
            Product p = da.Products.FirstOrDefault(s => s.ProductId == id);
            return View(p);
        }

        // POST: ProductsController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here
                Product p = da.Products.First(s => s.ProductId == id);

                da.Products.Remove(p);
                da.SaveChanges();


                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        public String Upload(IFormCollection collection)
        {
            var uploadResult = new ImageUploadResult();
            if (collection.Files["photo"].Length > 0)
            {
                var stream = collection.Files["photo"].OpenReadStream();
                var uploadParams = new ImageUploadParams
                {
                    File = new FileDescription(collection.Files["photo"].FileName, stream)
                };

                uploadResult = cloudinary.Upload(uploadParams);

            }

            var url = uploadResult.SecureUri.ToString();

            return url;
        }



    }
}

