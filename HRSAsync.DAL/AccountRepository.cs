using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using HRSAsync.Interface.DAL;
using HRSAsync.Models.Request.Account;
using HRSAsync.Models.Response.Account;

namespace HRSAsync.DAL
{
    public class AccountRepository : BaseRepository, IAccountRepository
    {
        public async Task<LoginResult> AdminLogin(LoginRequest request)
        {
            try
            {
            DynamicParameters parameters = new DynamicParameters();
            parameters.Add("@email1", request.Email);
            parameters.Add("@password1", request.Password);
            var result = new LoginResult();
            result = SqlMapper.QueryFirstOrDefault<LoginResult>(cnn: conn,sql: "Admin_Login", param: parameters, commandType: CommandType.StoredProcedure);
            if (result.Message.Equals("Login successful."))
                result.Success = true;
            else
                result.Success = false;
            return result;

            }
            catch (Exception)
            {
                return new LoginResult()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }

        public async Task<RegisterResult> AdminRegister(RegisterRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@name", request.Name);
                parameters.Add("@email1", request.Email);
                parameters.Add("@phone", request.Phone);
                parameters.Add("@password1", request.Password);
                RegisterResult result = SqlMapper.QueryFirstOrDefault<RegisterResult>(cnn:conn, sql: "Admin_Register", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Registration successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;
            }
            catch (Exception)
            {
                return new RegisterResult()
                {
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }

        public async Task<LoginResult> CustomerLogin(LoginRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@email1", request.Email);
                parameters.Add("@password1", request.Password);
                LoginResult result = SqlMapper.QueryFirstOrDefault<LoginResult>(cnn: conn, sql: "Customer_Login", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Login successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;

            }
            catch (Exception)
            {
                return new LoginResult()
                {
                    Id = 0,
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }

        public async Task<RegisterResult> CustomerRegister(RegisterRequest request)
        {
            try
            {
                DynamicParameters parameters = new DynamicParameters();
                parameters.Add("@name", request.Name);
                parameters.Add("@email1", request.Email);
                parameters.Add("@phone", request.Phone);
                parameters.Add("@password", request.Password);
                RegisterResult result = SqlMapper.QueryFirstOrDefault<RegisterResult>(cnn: conn, sql: "customer_Register", param: parameters, commandType: CommandType.StoredProcedure);
                if (result.Message.Equals("Registration successful."))
                    result.Success = true;
                else
                    result.Success = false;
                return result;

            }
            catch (Exception)
            {
                return new RegisterResult()
                {
                    Message = "An error occurred, please try again!",
                    Success = false
                };
            }
        }
    }
}
