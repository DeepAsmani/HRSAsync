using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HRSAsync.Models.Response.Account;
using HRSAsync.Models.Request.Account;

namespace HRSAsync.Interface.DAL
{
    public interface IAccountRepository
    {
        Task<LoginResult> AdminLogin(LoginRequest request);
        Task<LoginResult> CustomerLogin(LoginRequest request);
        Task<RegisterResult> AdminRegister(RegisterRequest request);
        Task<RegisterResult> CustomerRegister(RegisterRequest request);
    }
}
