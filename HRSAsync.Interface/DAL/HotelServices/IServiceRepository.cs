using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.HotelServices
{
    public interface IServiceRepository
    {
        Task<IEnumerable<Service>> Get();

        Task<Service> Get(int id);

        Task<ActionsResult> Save(Service service);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<Service>> Search(string keyWord);
    }
}