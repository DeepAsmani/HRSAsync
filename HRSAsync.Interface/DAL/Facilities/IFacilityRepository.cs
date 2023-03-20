using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Facilities;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.Facilities
{
    public interface IFacilityRepository
    {
        Task<IEnumerable<Facility>> GetAll();

        Task<Facility> GetById(int id);

        Task<ActionsResult> Save(Facility facility);

        Task<ActionsResult> Delete(int id);
    }
}