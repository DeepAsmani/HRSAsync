using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Request.Search;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.HotelServices
{
    public interface IRoomTypeService
    {
        Task<IEnumerable<RoomType>> GetAll();

        Task<IEnumerable<RoomTypes>> GetAllRoomTypeWithImages();

        Task<IEnumerable<RoomTypes>> GetAllRoomTypeWithImagesAndFacilities();

        Task<RoomType> GetById(int id);

        Task<RoomType> GetByIdWithImagesAndFacilities(int id);

        Task<ActionsResult> Save(CreateRoomTypeRequest roomType);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<RoomTypeSearchResult>> Search(SearchModel request);
    }
}