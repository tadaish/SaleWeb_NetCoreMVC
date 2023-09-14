using SaleWeb33.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace SaleWeb33.Controllers
{
    public class CategoryController : Controller
    {
        SaledbContext da = new SaledbContext();
        // GET: CategoryController
        public ActionResult ListCategories()
        {
            List<Category> ds = da.Categories.Select(s=>s).ToList();
            return View(ds);
        }

        // GET: CategoryController/Details/5
        public ActionResult Details(int id)
        {
            Category cate = da.Categories.FirstOrDefault(s => s.CategoryId == id);
            return View(cate);
        }

        // GET: CategoryController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: CategoryController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Category cate, IFormCollection collection)
        {
            try
            {
                if (da.Categories.FirstOrDefault(s => s.CategoryId == cate.CategoryId) == null)
                {
                    da.Categories.Add(cate);
                    da.SaveChanges();

                    return RedirectToAction("ListCategories");
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

        // GET: CategoryController/Edit/5
        public ActionResult Edit(int id)
        {
            Category u = da.Categories.FirstOrDefault(s => s.CategoryId == id);
            return View(u);
        }

        // POST: CategoryController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Category cate, IFormCollection collection)
        {
            using (var tran = da.Database.BeginTransaction())
            {
                try
                {
                    Category c = da.Categories.FirstOrDefault(s => s.CategoryId == cate.CategoryId);
                    c.CategoryName = cate.CategoryName;

                    da.Categories.Update(c);
                    da.SaveChanges();

                    tran.Commit();

                    return RedirectToAction("ListCategories");
                }
                catch (Exception)
                {
                    tran.Rollback();
                    return View();
                }
            }
        }

        // GET: CategoryController/Delete/5
        public ActionResult Delete(int id)
        {
            Category c = da.Categories.FirstOrDefault(s => s.CategoryId == id);
            return View(c);
        }

        // POST: CategoryController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            Category c = da.Categories.FirstOrDefault(s => s.CategoryId == id);
            try
            {
                da.Categories.Remove(c);
                da.SaveChanges();
            }
            catch (SqlException ex)
            {
                ViewBag.EX = ex;
                return RedirectToAction("Delete");
            }

            return RedirectToAction("ListCategories");
        }
    }
}
