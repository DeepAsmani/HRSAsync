using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Facilities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.Facilities
{
    public interface IFacilityApplyService
    {
        Task<IEnumerable<FacilityApply>> GetByRoomTypeId(int id);

        Task<ActionsResult> Save(CreateRoomTypeFacilitiesApplyRequest facilityApply);

        Task<ActionsResult> Delete(int id);

        Task<ActionsResult> DeleteByRoomTypeId(int id);
    }
}