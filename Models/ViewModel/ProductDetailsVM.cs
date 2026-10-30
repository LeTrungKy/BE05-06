using BE05_06.Models;
using PagedList.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Web;

namespace BE05_06.Models.ViewModel
{
    public class ProductDetailsVM
    {
        public Product product { get; set; }
        public int quantity { get; set; } = 1;
        public decimal estimatedValue { get; set; }

        public int PageNumber { get; set; }
        public int PageSize { get; set; } = 3;

        public List<Product> RelatedProducts { get; set; }

        public PagedList.IPagedList<Product> TopProducts { get; set; }
    }
}