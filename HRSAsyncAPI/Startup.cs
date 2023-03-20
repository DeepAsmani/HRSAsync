using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HRSAsync.BAL;
using HRSAsync.BAL.Bookings;
using HRSAsync.BAL.Coupons;
using HRSAsync.BAL.Facilities;
using HRSAsync.BAL.HotelServices;
using HRSAsync.Interface.BAL;
using HRSAsync.Interface.BAL.Bookings;
using HRSAsync.Interface.BAL.Coupons;
using HRSAsync.Interface.BAL.Facilities;
using HRSAsync.Interface.BAL.HotelServices;
using HRSAsync.Interface.BAL.Promotions;
using HRSAsync.Interface.BAL.Search;
using HRSAsync.Interface.BAL.Supports;
using HRSAsync.BAL.Promotions;
using HRSAsync.BAL.Search;
using HRSAsync.BAL.Supports;
using HRSAsync.DAL;
using HRSAsync.DAL.Bookings;
using HRSAsync.DAL.Coupons;
using HRSAsync.DAL.Facilities;
using HRSAsync.DAL.HotelServices;
using HRSAsync.Interface.DAL;
using HRSAsync.Interface.DAL.Bookings;
using HRSAsync.Interface.DAL.Coupons;
using HRSAsync.Interface.DAL.Facilities;
using HRSAsync.Interface.DAL.HotelServices;
using HRSAsync.Interface.DAL.Promotions;
using HRSAsync.Interface.DAL.Supports;
using HRSAsync.DAL.Promotions;
using HRSAsync.DAL.Supports;
using HRSAsync.Models;

namespace HRSAsync
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "HRSAsyncAPI", Version = "v1" });
            });
            services.AddTransient<IAccountService, AccountService>();
            services.AddTransient<IAccountRepository, AccountRepository>();
            services.AddTransient<IBookingRoomDetailsService, BookingRoomDetailsService>();
            services.AddTransient<IBookingService, BookingService>();
            services.AddTransient<IBookingServiceDetailsService, BookingServiceDetailsService>();
            services.AddTransient<IRoomTypeService, RoomTypeService>();
            services.AddTransient<IServiceService, ServiceService>();
            services.AddTransient<ICustomerSevice, CustomerSerice>();
            services.AddTransient<IBookingRepository, BookingRepository>();
            services.AddTransient<IBookingRoomDetailsRepository, BookingRoomDetailsRepository>();
            services.AddTransient<IBookingServiceDetailsRepository, BookingServiceDetailsRepository>();
            services.AddTransient<IRoomTypeRepository, RoomTypeRepository>();
            services.AddTransient<IServiceRepository, ServiceRepository>();
            services.AddTransient<ICustomerRepository, CustomerRepository>();
            services.AddTransient<IPromotionRepository, PromotionRepository>();
            services.AddTransient<IPromotionService, PromotionService>();
            services.AddTransient<IPromotionApplyRepository, PromotionApplyRepository>();
            services.AddTransient<IPromotionApplyService, PromotionApplyService>();
            services.AddTransient<IFacilityRepository, FacilityRepository>();
            services.AddTransient<IFacilityService, FacilityService>();
            services.AddTransient<IFacilityApplyRepository, FacilityApplyRepository>();
            services.AddTransient<IFacilityApplyService, FacilityApplyService>();
            services.AddTransient<ICouponRepository, CouponRepository>();
            services.AddTransient<ICouponService, CouponService>();
            services.AddTransient<IRoomTypeImageRepository, RoomTypeImageRepository>();
            services.AddTransient<IRoomTypeImageService, RoomTypeImageService>();
            services.AddTransient<ISupportRepository, SupportRepository>();
            services.AddTransient<ISupportService, SupportService>();
            services.AddTransient<IServiceImageRepository, ServiceImageRepository>();
            services.AddTransient<IServiceImageService, ServiceImageService>();
            services.AddTransient<ISearchService, SearchService>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "HRSAsyncAPI v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
