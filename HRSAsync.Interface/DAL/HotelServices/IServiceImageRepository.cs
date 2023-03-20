using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.HotelServices
{
    public interface IServiceImageRepository
    {
        Task<ActionsResult> Save(UploadServiceImagesRequest serviceImagesRequest);

        Task<IEnumerable<ServiceImage>> GetByServiceId(int id);

        Task<ActionsResult> Delete(int id);
    }
}