using System;

namespace HRSAsync.Models.Request.Booking
{
    public class GetAvailablePromotionForDateAndRoomIdRequest
    {
        public int RoomTypeId { get; set; }
        public DateTime Date { get; set; }
    }
}
