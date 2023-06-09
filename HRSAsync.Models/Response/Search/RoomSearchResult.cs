﻿using System;
using System.Collections.Generic;
using System.Text;

namespace HRSAsync.Models.Response.Search
{
    public class RoomSearchResult
    {
        public IEnumerable<RoomTypeSearchResultWithPricesList> RoomTypeSearchResults { get; set; }
        public int Adults { get; set; }
        public int Children { get; set; }
    }
}
