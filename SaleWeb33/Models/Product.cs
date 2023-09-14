using System;
using System.Collections.Generic;

namespace SaleWeb33.Models;

public partial class Product
{
    public int ProductId { get; set; }

    public int? CategoryId { get; set; }

    public int? BrandId { get; set; }

    public int? SizeId { get; set; }

    public string? ProductName { get; set; }

    public int? Quantity { get; set; }

    public decimal? Price { get; set; }

    public int? UnitsInStock { get; set; }

    public string? Description { get; set; }

    public bool? Limited { get; set; }

    public string? Images { get; set; }

    public int? ColorId { get; set; }

    public virtual Brand? Brand { get; set; }

    public virtual Category? Category { get; set; }

    public virtual Color? Color { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual Size? Size { get; set; }
}
