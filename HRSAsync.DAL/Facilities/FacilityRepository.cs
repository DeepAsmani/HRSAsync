using Dapper;
using HRSAsync.Interface.DAL.Facilities;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Facilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.Facilities
{
    public class FacilityRepository : BaseRepository, IFacilityRepository
    {
        public async Task<Facility> GetById(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@FacilityId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<Facility>(cnn: conn, sql: "Facility_GetbyId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<Facility>> GetAll()
        {
            return await SqlMapper.QueryAsync<Facility>(conn, "Facility_GetAll", commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@FacilityId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Facility_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(Facility facility)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@FacilityId", facility.FacilityId);
                parameters.Add("@FacilityName", facility.FacilityName);
                parameters.Add("@FacilityImage", facility.FacilityImage);
                return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Facility_Save", param: parameters, commandType: CommandType.StoredProcedure);
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
    }
}