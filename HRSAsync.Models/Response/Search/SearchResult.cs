using System;
using System.Collections.Generic;

namespace HRSAsync.Models.Response.Search
{
    public class SearchResult
    {
        public DateTime CheckInDate { get; set; }
        public DateTime CheckOutDate { get; set; }
        public IEnumerable<RoomSearchResult> RoomSearchResults { get; set; }
    }
}
