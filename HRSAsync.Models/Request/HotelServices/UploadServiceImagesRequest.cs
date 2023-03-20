namespace HRSAsync.Models.Request.HotelServices
{
    public class UploadServiceImagesRequest
    {
        public string[] Images { get; set; }
        public int ServiceId { get; set; }
    }
}