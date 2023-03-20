﻿using System.Collections.Generic;

namespace HRSAsync.Models.Response.HotelServices
{
    public class Service
    {
        public int ServiceId { get; set; }
        public string ServiceName { get; set; }
        public int Price { get; set; }
        public bool IsDelete { get; set; }
        public string Description { get; set; }
        public IEnumerable<ServiceImage> Images { get; set; }
    }
}