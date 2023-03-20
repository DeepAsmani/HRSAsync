using HRSAsync.Interface.BAL.Promotions;
using HRSAsync.Interface.DAL.Promotions;
using HRSAsync.Models.Request.Booking;
using HRSAsync.Models.Request.Promotions;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Promotions;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.BAL
{
    public class PromotionService : IPromotionService
    {
        private readonly IPromotionRepository promotionRepository;
        private readonly IPromotionApplyRepository promotionApplyRepository;

        public PromotionService(IPromotionRepository promotionRepository, IPromotionApplyRepository promotionApplyRepository)
        {
            this.promotionRepository = promotionRepository;
            this.promotionApplyRepository = promotionApplyRepository;
        }

        public async Task<Promotion> GetById(int id)
        {
            return await promotionRepository.GetById(id);
        }

        public async Task<IEnumerable<Promotion>> GetAll()
        {
            return await promotionRepository.GetAll();
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await promotionRepository.Delete(id);
        }

        public async Task<ActionsResult> Save(SavePromotionRequest request)
        {
            var promotion = new Promotion()
            {
                PromotionId = request.PromotionId,
                DiscountRates = request.DiscountRates,
                EndDate = request.EndDate,
                PromotionName = request.PromotionName,
                StartDate = request.StartDate
            };
            var createPromotionResult = await promotionRepository.Save(promotion);
            if (createPromotionResult.Id != 0)
            {
                foreach (var roomTypeId in request.RoomTypeIds)
                {
                    _ = await promotionApplyRepository.Save(new PromotionApply()
                    {
                        RoomTypeId = int.Parse(roomTypeId),
                        PromotionId = createPromotionResult.Id
                    });
                }
            }
            return createPromotionResult;
        }

        public async Task<IEnumerable<GetMaxDiscountRatesPromotionAvailable>> GetAvailable()
        {
            return await promotionRepository.GetAvailable();
        }
        public async Task<IEnumerable<GetMaxDiscountRatesPromotionAvailable>> GetAvailableForDate(DateTime date)
        {
            return await promotionRepository.GetAvailableForDate(date);
        }

        public async Task<GetAvailablePromotionForDateAndRoomIdResponse> GetAvailablePromotionForDateAndRoomId(GetAvailablePromotionForDateAndRoomIdRequest request)
        {
            var discountRates = await promotionRepository.GetAvailablePromotionForDateAndRoomId(request);
            return new GetAvailablePromotionForDateAndRoomIdResponse()
            {
                DiscountRates = discountRates
            };
        }
    }
}