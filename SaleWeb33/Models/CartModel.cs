using System;
using System.Collections.Generic;

namespace SaleWeb33.Models
{
    public class CartModel
    {
        SaledbContext da = new SaledbContext();
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public decimal? Price { get; set; }
        public int Quantity { get; set; }

        public string? Images { get; set; }

        public decimal? Total { get { return Price * Quantity; } }
        public CartModel(int productID)
        {
            Product p = da.Products.FirstOrDefault(s => s.ProductId == productID);
            ProductID = p.ProductId;
            ProductName = p.ProductName;
            Price = p.Price;
            Images = p.Images;
            Quantity = 1;

        }
    }
}
