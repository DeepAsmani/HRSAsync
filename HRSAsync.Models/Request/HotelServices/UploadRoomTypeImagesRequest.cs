namespace HRSAsync.Models.Request.HotelServices
{
    public class UploadRoomTypeImagesRequest
    {
        public string[] Images { get; set; }
        public int RoomTypeId { get; set; }
    }
}