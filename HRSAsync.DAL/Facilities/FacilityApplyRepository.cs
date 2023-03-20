using Dapper;
using HRSAsync.Interface.DAL.Facilities;
using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Facilities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.Facilities
{
    public class FacilityApplyRepository : BaseRepository, IFacilityApplyRepository
    {
        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@FacilityApplyId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "FacilityApply_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> DeleteByRoomTypeId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "FacilityApply_DeleteByRoomTypeId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(CreateRoomTypeFacilitiesApplyRequest facilitysApply)
        {
            try
            {
                var result = new ActionsResult();
                foreach (var facility in facilitysApply.FacilitieIds)
                {
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@FacilityId", int.Parse(facility));
                    parameters.Add("@RoomTypeId", facilitysApply.RoomTypeId);
                    result = await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "FacilityApply_Save", param: parameters, commandType: CommandType.StoredProcedure);
                }
                return result;
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

        public async Task<IEnumerable<FacilityApply>> GetByRoomTypeId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return await SqlMapper.QueryAsync<FacilityApply>(cnn: conn, sql: "FacilityApply_GetByRoomTypeId", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}