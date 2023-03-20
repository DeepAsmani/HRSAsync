using HRSAsync.Models;
using System.Data;
using MySql.Data.MySqlClient;

namespace HRSAsync.DAL
{
    public class BaseRepository
    {
        protected IDbConnection conn;

        public BaseRepository()
        {
            var connectionString = Common.ConnectionString;
            conn = new MySqlConnection(connectionString);
        }
    }
}