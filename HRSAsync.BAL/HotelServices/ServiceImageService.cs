using HRSAsync.Interface.BAL.HotelServices;
using HRSAsync.Interface.DAL.HotelServices;
using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.BAL.HotelServices
{
    public class ServiceImageService : IServiceImageService
    {
        private readonly IServiceImageRepository serviceImageRepository;

        public ServiceImageService(IServiceImageRepository serviceImageRepository)
        {
            this.serviceImageRepository = serviceImageRepository;
        }

        public async Task<IEnumerable<ServiceImage>> GetByServiceId(int id)
        {
            return await serviceImageRepository.GetByServiceId(id);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await serviceImageRepository.Delete(id);
        }

        public async Task<ActionsResult> Save(UploadServiceImagesRequest serviceImage)
        {
            return await serviceImageRepository.Save(serviceImage);
        }
    }
}