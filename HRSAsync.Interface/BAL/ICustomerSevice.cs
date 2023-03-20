using HRSAsync.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL
{
    public interface ICustomerSevice
    {
        Task<IEnumerable<Customer>> Get();

        Task<Customer> Get(int id);

        Task<ActionsResult> Save(Customer customer);

        Task<ActionsResult> Delete(int id);
    }
}