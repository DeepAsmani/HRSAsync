using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.DAL.Supports
{
    public interface ISupportRepository
    {
        Task<IEnumerable<DateTime>> CreateTableDateAsync(DateTime startDate, DateTime endDate);
    }
}