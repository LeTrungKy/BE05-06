using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BE05_06.Models.ViewModel
{
    public class CategoryStat
    {
        public string Name { get; set; }
        public int Count { get; set; }
    }

    public class HomeStatsVM
    {
        public int ProductCount { get; set; }
        public int CategoryCount { get; set; }
        public int CustomerCount { get; set; }
        public int OrderCount { get; set; }
        public decimal Revenue { get; set; }
        public List<CategoryStat> CategoryStats { get; set; }
    }
}
