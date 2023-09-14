using SaleWeb33.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace SaleWeb33.Controllers
{
    public class UserController : Controller
    {
        SaledbContext da = new SaledbContext();
        // GET: UserController
        public ActionResult ListUsers()
        {
            List<User> ds = da.Users.Select(s => s).ToList();

            return View(ds);
        }

        // GET: UserController/Details/5
        public ActionResult Details(int id)
        {
            User u = da.Users.FirstOrDefault(s => s.UserId == id);
            return View(u);
        }

        // GET: UserController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: UserController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(User u, IFormCollection collection)
        {
            try
            {
                if (da.Users.FirstOrDefault(s => s.Username == u.Username) == null)
                {
                    da.Users.Add(u);
                    da.SaveChanges();

                    return RedirectToAction("ListUsers");
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

        // GET: UserController/Edit/5
        public ActionResult Edit(int id)
        {
            User u = da.Users.FirstOrDefault(s => s.UserId == id);
            return View(u);
        }

        // POST: UserController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(User user, IFormCollection collection)
        {

            using (var tran = da.Database.BeginTransaction())
            {
                try
                {
                    User u = da.Users.FirstOrDefault(s => s.UserId == user.UserId);
                    u.Username = user.Username;
                    u.Password = user.Password;
                    u.FullName = user.FullName;
                    u.Phone = user.Phone;
                    u.Address = user.Address;
                    u.Role = user.Role;

                    da.Users.Update(u);
                    da.SaveChanges();

                    tran.Commit();

                    return RedirectToAction("ListUsers");
                }
                catch (Exception)
                {
                    tran.Rollback();
                    return View();
                }
            }
        }

        // GET: UserController/Delete/5
        public ActionResult Delete(int id)
        {
            User u = da.Users.FirstOrDefault(s => s.UserId == id);
            return View(u);
        }

        // POST: UserController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            User u = da.Users.FirstOrDefault(s=>s.UserId == id);
            try
            {
                da.Users.Remove(u);
                da.SaveChanges();
            }
            catch(SqlException ex)
            {
                ViewBag.EX = ex;
                return RedirectToAction("Delete");
            }

            return RedirectToAction("ListUsers");
        }
    }
}
