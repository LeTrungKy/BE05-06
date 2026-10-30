using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList.Mvc;

namespace BE05_06.Models.ViewModel
{
    public class HomeProductVM
    {
        public string SearchTerm { get; set; }

        public int PageNumber { get; set; }
        public int PageSize { get; set; } = 6;
        
        public List<Product> FeaturedProducts { get; set; }

        public PagedList.IPagedList<Product> NewProducts { get; set; }
    }
}