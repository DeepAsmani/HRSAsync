using Dapper;
using HRSAsync.Interface.DAL.Bookings;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Bookings;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.Bookings
{
    public class BookingServiceDetailsRepository : BaseRepository, IBookingServiceDetailsRepository
    {
        public async Task<IEnumerable<BookingServiceDetails>> Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return await SqlMapper.QueryAsync<BookingServiceDetails>(cnn: conn, sql: "BookingServiceDetails_GetByBookingId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        //public async Task<IEnumerable<BookingServiceDetails>> Get()
        //{
        //    return await SqlMapper.QueryAsync<BookingServiceDetails>(conn, "GetBookingsServiceDetails", commandType: CommandType.StoredProcedure);
        //}

        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingServiceDetailsId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "BookingServiceDetails_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(BookingServiceDetails bookingServiceDetails)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookingId", bookingServiceDetails.BookingId);
                parameters.Add("@ServiceId", bookingServiceDetails.ServiceId);
                parameters.Add("@ServiceQuantity", bookingServiceDetails.ServiceQuantity);
                return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "BookingServiceDetails_Save", param: parameters, commandType: CommandType.StoredProcedure);
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

        public async Task<IEnumerable<BookingServiceDetails>> Get()
        {
            return await SqlMapper.QueryAsync<BookingServiceDetails>(cnn: conn, sql: "BookingServiceDetails_GetAll", commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> DeleteByBookingId(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "BookingServiceDetails_DeletebyBookingId", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}