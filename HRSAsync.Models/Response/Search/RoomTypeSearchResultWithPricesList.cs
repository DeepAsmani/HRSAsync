using System.Collections.Generic;

namespace HRSAsync.Models.Response.Search
{
    public class RoomTypeSearchResultWithPricesList
    {
        public int RoomTypeId { get; set; }
        public int MinRemain { get; set; }
        public IEnumerable<RoomPriceSearchResult> RoomPriceSearchResults { get; set; }
    }
}
