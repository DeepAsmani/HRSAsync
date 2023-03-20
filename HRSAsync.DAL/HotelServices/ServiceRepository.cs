using Dapper;
using HRSAsync.Interface.DAL.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.HotelServices
{
    public class ServiceRepository : BaseRepository, IServiceRepository
    {
        public async Task<Service> Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@ServiceId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<Service>(cnn: conn, sql: "Service_GetByServiceId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<Service>> Get()
        {
            return await SqlMapper.QueryAsync<Service>(conn, "Service_GetAll", commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@ServiceId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Service_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(Service service)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@ServiceId", service.ServiceId);
                parameters.Add("@ServiceName", service.ServiceName);
                parameters.Add("@Price", service.Price);
                parameters.Add("@Description", service.Description);
                return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Service_Save", param: parameters, commandType: CommandType.StoredProcedure);
            }
            catch (Exception)
            {
                return new ActionsResult()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!"
                };
            }
        }

        public async Task<IEnumerable<Service>> Search(string keyWord)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@keyWord", keyWord);
            return await SqlMapper.QueryAsync<Service>(cnn: conn, sql: "Service_Search", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}