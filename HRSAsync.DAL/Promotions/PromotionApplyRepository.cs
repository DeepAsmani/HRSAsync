using Dapper;
using HRSAsync.Interface.DAL.Promotions;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Promotions;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.Promotions
{
    public class PromotionApplyRepository : BaseRepository, IPromotionApplyRepository
    {
        public async Task<IEnumerable<PromotionApply>> GetAll()
        {
            return await SqlMapper.QueryAsync<PromotionApply>(conn, "PromotionApply_GetAll", commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@PromotionApplyId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "PromotionApply_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> DeleteByPromotionId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@PromotionId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "PromotionApply_DeleteByPromotionId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(PromotionApply promotionApply)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@PromotionApplyId", promotionApply.PromotionApplyId);
                parameters.Add("@PromotionId", promotionApply.PromotionId);
                parameters.Add("@RoomTypeId", promotionApply.RoomTypeId);
                return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "PromotionApply_Save", param: parameters, commandType: CommandType.StoredProcedure);
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

        public async Task<IEnumerable<PromotionApply>> GetByRoomTypeId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return await SqlMapper.QueryAsync<PromotionApply>(cnn: conn, sql: "PromotionApply_GetByRoomTypeId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<PromotionApply>> GetByPromotionId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@PromotionId", id);
            return await SqlMapper.QueryAsync<PromotionApply>(cnn: conn, sql: "PromotionApply_GetByPromotionId", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}