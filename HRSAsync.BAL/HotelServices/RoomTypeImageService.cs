using HRSAsync.Interface.BAL.HotelServices;
using HRSAsync.Interface.DAL.HotelServices;
using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.BAL.HotelServices
{
    public class RoomTypeImageService : IRoomTypeImageService
    {
        private readonly IRoomTypeImageRepository roomTypeImageRepository;

        public RoomTypeImageService(IRoomTypeImageRepository roomTypeImageRepository)
        {
            this.roomTypeImageRepository = roomTypeImageRepository;
        }

        public async Task<IEnumerable<RoomTypeImage>> GetByRoomTypeId(int id)
        {
            return await roomTypeImageRepository.GetByRoomTypeId(id);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await roomTypeImageRepository.Delete(id);
        }

        public async Task<ActionsResult> Save(UploadRoomTypeImagesRequest roomTypeImage)
        {
            return await roomTypeImageRepository.Save(roomTypeImage);
        }
    }
}