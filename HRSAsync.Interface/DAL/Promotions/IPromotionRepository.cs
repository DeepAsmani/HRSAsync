using HRSAsync.Models.Request.Booking;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Promotions;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.Promotions
{
    public interface IPromotionRepository
    {
        Task<IEnumerable<Promotion>> GetAll();

        Task<ActionsResult> Save(Promotion promotion);

        Task<Promotion> GetById(int id);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<GetMaxDiscountRatesPromotionAvailable>> GetAvailable();
        Task<IEnumerable<GetMaxDiscountRatesPromotionAvailable>> GetAvailableForDate(DateTime date);
        Task<float> GetAvailablePromotionForDateAndRoomId(GetAvailablePromotionForDateAndRoomIdRequest request);
    }
}