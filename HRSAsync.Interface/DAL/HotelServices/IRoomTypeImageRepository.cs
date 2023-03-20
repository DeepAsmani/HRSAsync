using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.HotelServices
{
    public interface IRoomTypeImageRepository
    {
        Task<ActionsResult> Save(UploadRoomTypeImagesRequest roomTypeImagesRequest);

        Task<IEnumerable<RoomTypeImage>> GetByRoomTypeId(int id);

        Task<ActionsResult> Delete(int id);
    }
}