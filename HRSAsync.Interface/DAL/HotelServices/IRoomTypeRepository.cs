using HRSAsync.Models.Request.Search;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.HotelServices
{
    public interface IRoomTypeRepository
    {
        Task<IEnumerable<RoomType>> GetAll();

        Task<RoomType> GetById(int id);

        Task<ActionsResult> Save(RoomType roomType);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<RoomTypeSearchResult>> Search(SearchModel request);
    }
}