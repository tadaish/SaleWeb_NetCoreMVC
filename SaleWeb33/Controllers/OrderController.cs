using SaleWeb33.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Drawing.Drawing2D;
using Microsoft.EntityFrameworkCore;
using Microsoft.CodeAnalysis.CSharp.Syntax;

namespace SaleWeb33.Controllers
{
    public class OrderController : Controller
    {
        SaledbContext da = new SaledbContext();
        // GET: OrderController
        public ActionResult ListOrders()
        {
            List<Order> list = da.Orders.Select(s => s).ToList();
            return View(list);
        }

        // GET: OrderController/Details/5
        public ActionResult Details(int id)
        {
            Order o = da.Orders.FirstOrDefault(s => s.OrderId == id);

            return View(o);
        }

        // GET: OrderController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: OrderController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Order o, IFormCollection collection)
        {
            try
            {
                if (da.Orders.FirstOrDefault(s => s.OrderId == o.OrderId) == null)
                {
                    da.Orders.Add(o);
                    da.SaveChanges();

                    return RedirectToAction("ListOrder");
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

        // GET: OrderController/Edit/5
        public ActionResult Edit(int id)
        {
            Order o = da.Orders.FirstOrDefault(s => s.OrderId == id);
            return View(o);
        }

        // POST: OrderController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Order order, IFormCollection collection)
        {
            using (var tran = da.Database.BeginTransaction())
            {
                try
                {
                    Order o = da.Orders.FirstOrDefault(s => s.OrderId == order.OrderId);
                    o.UserId = order.UserId;
                    o.OrderDate = order.OrderDate;
                    o.ShippingAddress = order.ShippingAddress;

                    da.Orders.Update(o);
                    da.SaveChanges();

                    tran.Commit();

                    return RedirectToAction("ListOrders");
                }
                catch (Exception)
                {
                    tran.Rollback();
                    return View();
                }
            }
        }

        // GET: OrderController/Delete/5
        public ActionResult Delete(int id)
        {
            Order o = da.Orders.FirstOrDefault(s => s.OrderId == id);
            return View(o); ;
        }

        // POST: OrderController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            Order o = da.Orders.FirstOrDefault(s => s.OrderId == id);
            try
            {
                da.Orders.Remove(o);
                da.SaveChanges();
            }
            catch (SqlException ex)
            {
                ViewBag.EX = ex;
                return RedirectToAction("Delete");
            }

            return RedirectToAction("ListOrders");
        }
    }
}
