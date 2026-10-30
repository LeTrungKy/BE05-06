using System.ComponentModel.DataAnnotations;

namespace BE05_06.Models
{
    [MetadataType(typeof(CategoryMetadata))]
    public partial class Category
    {
    }

    public class CategoryMetadata
    {
        [Required(ErrorMessage = "Vui lòng nhập tên danh mục")]
        public string CategoryName { get; set; }
    }

    [MetadataType(typeof(ProductMetadata))]
    public partial class Product
    {
    }

    public class ProductMetadata
    {
        [Required(ErrorMessage = "Vui lòng nhập tên sản phẩm")]
        public string ProductName { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập mô tả sản phẩm")]
        public string ProductDescription { get; set; }

        [Range(typeof(decimal), "0", "9999999999999999", ErrorMessage = "Giá phải lớn hơn hoặc bằng 0")]
        public decimal ProductPrice { get; set; }
    }
}
