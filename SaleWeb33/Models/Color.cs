using System;
using System.Collections.Generic;

namespace SaleWeb33.Models;

public partial class Color
{
    public int ColorId { get; set; }

    public string? ColorName { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
