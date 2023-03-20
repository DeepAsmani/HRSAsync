using HRSAsync.Models.Response;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL
{
    public interface ICustomerRepository
    {
        Task<IEnumerable<Customer>> Get();

        Task<Customer> Get(int id);

        Task<ActionsResult> Save(Customer customer);

        Task<ActionsResult> Delete(int id);
    }
}