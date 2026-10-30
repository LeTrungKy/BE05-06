using System.ComponentModel.DataAnnotations.Schema;
using System.Web;

namespace BE05_06.Models
{
    public partial class Product
    {

        [NotMapped]
        public HttpPostedFileBase UploadImg { get; set; }
    }
}