﻿using Dapper;
using HRSAsync.Interface.DAL.Bookings;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Bookings;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HRSAsync.DAL.Bookings
{
    public class BookingRepository : BaseRepository, IBookingRepository
    {
        public async Task<Booking> Get(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<Booking>(cnn: conn, sql: "Booking_GetByBookingId", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<IEnumerable<Booking>> Get()
        {
            return await SqlMapper.QueryAsync<Booking>(cnn: conn, sql: "Booking_GetAll", commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Delete(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Booking_Delete", param: parameters, commandType: CommandType.StoredProcedure);
        }

        public async Task<ActionsResult> Save(Booking booking)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@BookingId", booking.BookingId);
                parameters.Add("@CustomerId", booking.CustomerId);
                parameters.Add("@CouponId", booking.CouponId);
                parameters.Add("@CheckinDate", booking.CheckinDate);
                parameters.Add("@CheckoutDate", booking.CheckoutDate);
                parameters.Add("@NumberofAdults", booking.NumberofAdults);
                parameters.Add("@NumberofChildren", booking.NumberofChildren);
                return await SqlMapper.QueryFirstOrDefaultAsync<ActionsResult>(cnn: conn, sql: "Booking_Save", param: parameters, commandType: CommandType.StoredProcedure);
            }
            catch (Exception e)
            {
                return new ActionsResult()
                {
                    Id = 0,
                    Message = e.Message
                    //Message = "An error occurred, please try again!"
                };
            }
        }

        public async Task<IEnumerable<DateTime>> GetListDate(int id)
        {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@BookingId", id);
            return await SqlMapper.QueryAsync<DateTime>(cnn: conn, sql: "Booking_GetListDate", param: parameters, commandType: CommandType.StoredProcedure);
        }
    }
}