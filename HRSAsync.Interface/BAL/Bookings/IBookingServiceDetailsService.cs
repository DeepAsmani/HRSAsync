using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Bookings;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.Bookings
{
    public interface IBookingServiceDetailsService
    {
        Task<IEnumerable<BookingServiceDetails>> Get();

        Task<IEnumerable<BookingServiceDetails>> Get(int id);

        Task<ActionsResult> Save(BookingServiceDetails bookingServiceDetails);

        Task<ActionsResult> Delete(int id);

        Task<ActionsResult> DeleteByBookingId(int id);
    }
}