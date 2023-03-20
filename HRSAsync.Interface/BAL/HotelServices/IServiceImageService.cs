using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.HotelServices
{
    public interface IServiceImageService
    {
        Task<IEnumerable<ServiceImage>> GetByServiceId(int id);

        Task<ActionsResult> Save(UploadServiceImagesRequest serviceImage);

        Task<ActionsResult> Delete(int id);
    }
}