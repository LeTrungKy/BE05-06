










namespace BE05_06.Models
{

using System;
    using System.Collections.Generic;
    
public partial class Order
{

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
    public Order()
    {

        this.OrderDetails = new HashSet<OrderDetail>();

        this.OrderDetails1 = new HashSet<OrderDetail>();

    }


    public int OrderID { get; set; }

    public int CustomerID { get; set; }

    public System.DateTime OrderDate { get; set; }

    public decimal TotalAmount { get; set; }

    public string PaymentStatus { get; set; }

    public string AddressDelivery { get; set; }



    public virtual Customer Customer { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<OrderDetail> OrderDetails { get; set; }

    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]

    public virtual ICollection<OrderDetail> OrderDetails1 { get; set; }

}

}
