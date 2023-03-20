using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.Supports
{
    public interface ISupportService
    {
        Task<IEnumerable<DateTime>> CreateTableDateAsync(DateTime startDate, DateTime endDate);
    }
}