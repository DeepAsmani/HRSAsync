using HRSAsync.Models.Request.Search;
using HRSAsync.Models.Response.Search;
using System.Threading.Tasks;

namespace HRSAsync.Interface.BAL.Search
{
    public interface ISearchService
    {
        Task<SearchResult> Search(SearchRequest request);
    }
}
