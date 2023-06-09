﻿using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.HotelServices
{
    public interface IServiceService
    {
        Task<IEnumerable<Service>> Get();

        Task<Service> Get(int id);

        Task<ActionsResult> Save(CreateServiceRequest service);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<Service>> Search(string keyWord);

        Task<Service> GetByIdWithImages(int id);

        Task<IEnumerable<Services>> GetAllWithImages();
    }
}