using HRSAsync.Interface.BAL.Coupons;
using HRSAsync.Interface.DAL.Coupons;
using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Coupons;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.BAL.Coupons
{
    public class CouponService : ICouponService
    {
        private readonly ICouponRepository couponRepository;

        public CouponService(ICouponRepository couponRepository)
        {
            this.couponRepository = couponRepository;
        }

        public async Task<ActionsResult> Delete(int id)
        {
            return await couponRepository.Delete(id);
        }

        public async Task<IEnumerable<Coupon>> GetAll()
        {
            return await couponRepository.GetAll();
        }

        public async Task<Coupon> GetById(int id)
        {
            return await couponRepository.GetById(id);
        }

        public async Task<ActionsResult> Save(Coupon coupon)
        {
            return await couponRepository.Save(coupon);
        }

        public async Task<CouponSearchResult> Search(string couponCode)
        {
            return await couponRepository.Search(couponCode);
        }
    }
}