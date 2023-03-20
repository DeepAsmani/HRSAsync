using HRSAsync.Models.Response.HotelServices;

namespace HRSAsync.Models.Request.Booking
{
    public class RoomTypeBookingRequest
    {
        public RoomType RoomType { get; set; }
        public int Quantity { get; set; }
    }
}