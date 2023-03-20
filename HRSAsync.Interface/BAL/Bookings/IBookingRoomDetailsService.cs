﻿using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Bookings;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.Bookings
{
    public interface IBookingRoomDetailsService
    {
        Task<IEnumerable<BookingRoomDetails>> Display(int id);

        Task<IEnumerable<BookingRoomDetails>> Get(int id);

        Task<ActionsResult> Save(BookingRoomDetails bookingRoomDetails);

        Task<ActionsResult> Delete(int id);

        Task<ActionsResult> DeleteByBookingId(int id);
    }
}