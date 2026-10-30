using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PagedList;

namespace BE05_06.Models.ViewModel
{
    public class CustomerSearchVM
    {
        public string SearchTerm { get; set; }
        public string SortOrder { get; set; }
        public int PageNumber { get; set; }
        public int PageSize { get; set; }
        public IPagedList<Customer> Customers { get; set; }
    }

    public class CustomerOrdersVM
    {
        public Customer Customer { get; set; }
        public List<Order> Orders { get; set; }
    }

    public class OrderDetailsVM
    {
        public Order Order { get; set; }
        public Customer Customer { get; set; }
        public List<OrderDetail> Items { get; set; }
    }
}
