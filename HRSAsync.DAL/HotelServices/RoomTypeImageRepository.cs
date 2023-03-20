using Dapper;
using HRSAsync.Interface.DAL.HotelServices;
using HRSAsync.Models.Request.HotelServices;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.HotelServices;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.HotelServices
{
    public class RoomTypeImageRepository : BaseRepository, IRoomTypeImageRepository
    {
        public async Task<IEnumerable<RoomTypeImage>> GetByRoomTypeId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeId", id);
            return await SqlMapper.QueryAsync<RoomTypeImage>(conn, "RoomTypeImage_GetByRoomTypeId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@RoomTypeImageId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "RoomTypeImage_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(UploadRoomTypeImagesRequest uploadRoomTypeImagesRequest)
        {
            try
            {
                var result = new ActionsResult();
                foreach (var imgData in uploadRoomTypeImagesRequest.Images)
                {
                    DynamicParameters parameters = new DynamicParameters();
                    parameters.Add("@RoomTypeId", uploadRoomTypeImagesRequest.RoomTypeId);
                    parameters.Add("@ImageData", imgData);
                    result = await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "RoomTypeImage_Save", param: parameters, commandType: CommandType.StoredProcedure);
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
    }
}