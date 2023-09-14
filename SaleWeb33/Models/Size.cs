using System;
using System.Collections.Generic;

namespace SaleWeb33.Models;

public partial class Size
{
    public int SizeId { get; set; }

    public string? SizeOption { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
