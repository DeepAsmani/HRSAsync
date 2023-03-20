using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HRSAsync.Interface.BAL;
using HRSAsync.Interface.DAL;
using HRSAsync.Models.Request.Account;
using HRSAsync.Models.Response.Account;

namespace HRSAsync.BAL
{
    public class AccountService : IAccountService
    {
        private readonly IAccountRepository accountRepository;
        public AccountService(IAccountRepository accountRepository)
        {
            this.accountRepository = accountRepository;
        }
        public  Task<LoginResult> AdminLogin(LoginRequest request)
        {
            return accountRepository.AdminLogin(request);
        }

        public  Task<RegisterResult> AdminRegister(RegisterRequest request)
        {
            return accountRepository.AdminRegister(request);
        }

        public Task<LoginResult> CustomerLogin(LoginRequest request)
        {
            return accountRepository.CustomerLogin(request);
        }

        public  Task<RegisterResult> CustomerRegister(RegisterRequest request)
        {
            return accountRepository.CustomerRegister(request);
        }
    }
}
