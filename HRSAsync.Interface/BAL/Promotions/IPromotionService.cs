using HRSAsync.Models.Request.Booking;
using HRSAsync.Models.Request.Promotions;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Promotions;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.Promotions
{
    public interface IPromotionService
    {
        Task<Promotion> GetById(int id);

        Task<IEnumerable<Promotion>> GetAll();

        Task<ActionsResult> Save(SavePromotionRequest promotion);

        Task<ActionsResult> Delete(int id);

        Task<IEnumerable<GetMaxDiscountRatesPromotionAvailable>> GetAvailable();

        Task<IEnumerable<GetMaxDiscountRatesPromotionAvailable>> GetAvailableForDate(DateTime date);
        Task<GetAvailablePromotionForDateAndRoomIdResponse> GetAvailablePromotionForDateAndRoomId(GetAvailablePromotionForDateAndRoomIdRequest request);
    }
}