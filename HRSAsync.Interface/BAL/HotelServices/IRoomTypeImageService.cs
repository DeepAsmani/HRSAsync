using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.HotelServices
{
    public interface IRoomTypeImageService
    {
        Task<IEnumerable<RoomTypeImage>> GetByRoomTypeId(int id);

        Task<ActionsResult> Save(UploadRoomTypeImagesRequest roomTypeImage);

        Task<ActionsResult> Delete(int id);
    }
}