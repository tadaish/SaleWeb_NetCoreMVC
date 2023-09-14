using SaleWeb33.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace SaleWeb33.Controllers
{
    public class BrandController : Controller
    {
        SaledbContext da = new SaledbContext();
        // GET: BrandController
        public ActionResult ListBrands()
        {
            List<Brand> list = da.Brands.Select(s => s).ToList();
            return View(list);
        }

        // GET: BrandController/Details/5
        public ActionResult Details(int id)
        {
            Brand b = da.Brands.Where(s => s.BrandId == id).FirstOrDefault();
            return View(b);
        }

        // GET: BrandController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: BrandController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Brand b,IFormCollection collection)
        {
            try
            {
                if (da.Brands.FirstOrDefault(s => s.BrandId == b.BrandId) == null)
                {
                    da.Brands.Add(b);
                    da.SaveChanges();

                    return RedirectToAction("ListBrands");
                }
                else
                {
                    return RedirectToAction("Create");
                }

            }
            catch
            {
                return View();
            }
        }
        // GET: BrandController/Edit/5
        public ActionResult Edit(int id)
        {
            Brand b = da.Brands.FirstOrDefault(s => s.BrandId == id);
            return View(b);
        }

        // POST: BrandController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Brand brand, IFormCollection collection)
        {
            using (var tran = da.Database.BeginTransaction())
            {
                try
                {
                    Brand b = da.Brands.FirstOrDefault(s => s.BrandId == brand.BrandId);
                    b.BrandName = brand.BrandName;

                    da.Brands.Update(b);
                    da.SaveChanges();

                    tran.Commit();

                    return RedirectToAction("ListBrands");
                }
                catch (Exception)
                {
                    tran.Rollback();
                    return View();
                }
            }
        }

        // GET: BrandController/Delete/5
        public ActionResult Delete(int id)
        {
            Brand b = da.Brands.FirstOrDefault(s => s.BrandId == id);
            return View(b);
        }

        // POST: BrandController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            Brand b = da.Brands.FirstOrDefault(s => s.BrandId == id);
            try
            {
                da.Brands.Remove(b);
                da.SaveChanges();
            }
            catch (SqlException ex)
            {
                ViewBag.EX = ex;
                return RedirectToAction("Delete");
            }

            return RedirectToAction("ListBrands");
        }
    }
}
