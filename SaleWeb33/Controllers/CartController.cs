using SaleWeb33.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Transactions;
using System.Collections.Generic;
using Newtonsoft.Json;
using SaleWeb33.Extensions;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace SaleWeb33.Controllers
{
    public class CartController : BaseController
    {

        SaledbContext da = new SaledbContext();



        // GET: CartController
        public List<CartModel> GetListCarts()
        {

            List<CartModel> carts = HttpContext.Session.GetJson<List<CartModel>>("Cart");

            if (carts == null)
            {
                carts = new List<CartModel>();
                HttpContext.Session.SetJson("Cart", carts);
            }

            return carts;
        }

        [Route("/cart")]
        public ActionResult ListCarts()
        {
            List<CartModel> carts = GetListCarts();
            ViewBag.Count = carts.Sum(s => s.Quantity);
            ViewBag.Total = carts.Sum(s => s.Total);
            return View(carts);
        }


        public ActionResult AddCart(int id)
        {


            List<CartModel> carts = GetListCarts();
            CartModel c = carts.Find(s => s.ProductID == id);
            if (c == null)
            {
                c = new CartModel(id);
                carts.Add(c);
            }
            else
            {
                c.Quantity++;
            }

            HttpContext.Session.SetJson("Cart", carts);

            return Redirect(Request.Headers["Referer"].ToString());

        }
        public ActionResult OrderProduct()
        {
            using (TransactionScope transScope = new TransactionScope())
            {
                try
                {
                    var session = HttpContext.Session;

                    List<CartModel> carts = GetListCarts();
                    Order order = new Order();
                    order.OrderDate = DateTime.Now;

                    da.Orders.Add(order);
                    da.SaveChanges();
                    da.Entry(order).State = EntityState.Detached;

                    foreach (CartModel item in carts)
                    {
                        OrderDetail od = new OrderDetail();

                        od.OrderId = order.OrderId;
                        od.ProductId = item.ProductID;
                        od.Price = item.Price;
                        od.Quantity = item.Quantity;

                        da.OrderDetails.Add(od);

                    }

                    da.SaveChanges();


                    transScope.Complete();
                    session.Remove("Cart");


                }
                catch (SqlException ex)
                {
                    Console.WriteLine(ex.Message);

                    transScope.Dispose();
                    return RedirectToAction("ListCarts"); ;
                }
                return RedirectToAction("Index", "Shop");
            }
        }

        public ActionResult ListOrders()
        {
            var sp = da.Orders.OrderByDescending(s => s.OrderDate).ToList();
            return View(sp);
        }
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Delete(int id)
        {

            List<CartModel> carts = GetListCarts();
            CartModel c = carts.Find(s => s.ProductID == id);
            try
            {
                if (c != null)
                {
                    carts.RemoveAll(s => s == c);
                    HttpContext.Session.SetJson("Cart", carts);
                }
            }
            catch (Exception ex)
            {
                return Content(ex.Message);
            }

            return RedirectToAction("ListCarts");
        }
    }
}


