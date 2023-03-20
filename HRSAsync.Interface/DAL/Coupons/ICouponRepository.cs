using HRSAsync.Models.Response;
using HRSAsync.Models.Response.Coupons;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.Coupons
{
    public interface ICouponRepository
    {
        Task<IEnumerable<Coupon>> GetAll();

        Task<ActionsResult> Save(Coupon coupon);

        Task<Coupon> GetById(int id);

        Task<ActionsResult> Delete(int id);

        Task<CouponSearchResult> Search(string couponCode);
    }
}