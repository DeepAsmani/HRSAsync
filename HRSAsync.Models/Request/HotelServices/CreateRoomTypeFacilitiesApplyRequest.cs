﻿namespace HRSAsync.Models.Request.HotelServices
{
    public class CreateRoomTypeFacilitiesApplyRequest
    {
        public int RoomTypeId { get; set; }
        public string[] FacilitieIds { get; set; }
    }
}