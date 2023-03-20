using HRSAsync.Interface.BAL.HotelServices;
using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.API.Controllers
{
    [ApiController]
    public class ServiceImagesController : ControllerBase
    {
        private readonly IServiceImageService serviceImageService;

        public ServiceImagesController(IServiceImageService serviceImageService)
        {
            this.serviceImageService = serviceImageService;
        }

        [HttpGet]
        [Route("api/serviceimages/getbyserviceid/{id}")]
        public async Task<IEnumerable<ServiceImage>> GetByServiceId(int id)
        {
            return await serviceImageService.GetByServiceId(id);
        }

        [HttpPost]
        [Route("api/serviceimages/save")]
        public async Task<ActionsResult> Save(UploadServiceImagesRequest service)
        {
            return await serviceImageService.Save(service);
        }

        [HttpDelete]
        [Route("api/serviceimages/delete/{id}")]
        public async Task<ActionsResult> Remove(int id)
        {
            return await serviceImageService.Delete(id);
        }
    }
}