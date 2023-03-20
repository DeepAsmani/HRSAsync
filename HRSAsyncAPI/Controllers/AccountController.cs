using HRSAsync.Models.Request.Account;
using HRSAsync.Models.Response.Account;
using HRSAsync.Models;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using HRSAsync.Interface.BAL;
using System.Threading.Tasks;
using Dapper;
using System;

namespace HRSAsync.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AccountController : ControllerBase
    {
        private readonly RoleManager<IdentityRole> roleManager;
        private readonly IWebHostEnvironment webHostEnvironment;
        private readonly IAccountService accountService;

        public AccountController(IAccountService accountService)
        {
            this.accountService = accountService;
        }

        public AccountController(RoleManager<IdentityRole> roleManager, IWebHostEnvironment webHostEnvironment)
        {
            this.roleManager = roleManager;
            this.webHostEnvironment = webHostEnvironment;
        }

        [HttpPost]
        [Route("/api/account/adminlogin")]
        public async Task<LoginResult> AdminLogin(LoginRequest request)
        {
            return await accountService.AdminLogin(request);
        }
        /*
         * Customer Login Controlller         
         */
        [HttpPost]
        [Route("/api/account/customerlogin")]
        public async Task<LoginResult> CustomerLogin(LoginRequest request)
        {
            return await accountService.CustomerLogin(request);
        }
        /*
         * Admin Register Controlller         
         */
        [HttpPost]
        [Route("/api/account/adminregister")]
        public async Task<RegisterResult> AdminRegister(RegisterRequest request)
        {
            return await accountService.AdminRegister(request);
        }
        /*
         * Customer Register Controlller         
         */
        [HttpPost]
        [Route("/api/account/customerregister")]
        public async Task<RegisterResult> CustomerRegister(RegisterRequest request)
        {
            return await accountService.CustomerRegister(request);
        }
    }
}