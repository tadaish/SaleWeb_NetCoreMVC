using NuGet.DependencyResolver;

namespace SaleWeb33.Models
{
    public class ViewModel
    {
        public IEnumerable<Product> Products { get; set; }
        public IEnumerable<Category> Category { get; set; }
        public IEnumerable<Brand> Brands { get; set; }
        public IEnumerable<CartModel> Cart { get; set; }

        public Order? Order { get; set; }
    }
}
