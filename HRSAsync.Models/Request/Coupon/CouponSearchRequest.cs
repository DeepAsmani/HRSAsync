using System;
using System.Collections.Generic;
using System.Text;

namespace HRSAsync.Models.Request.Coupon
{
    public class CouponSearchRequest
    {
        public string CouponCode { get; set; }
        public DateTime CreateDate { get; set; }
    }
}
