using HRSAsync.Interface.BAL.Search;
using HRSAsync.Interface.DAL.HotelServices;
using HRSAsync.Models.Request.Search;
using HRSAsync.Models.Response.Search;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace HRSAsync.API.Controllers
{
    [ApiController]
    public class SearchController : Controller
    {
        private readonly ISearchService searchService;

        public SearchController(ISearchService searchService)
        {
            this.searchService = searchService;
        }
        [HttpPost]
        [Route("api/[controller]")]
        public async Task<SearchResult> Search(SearchRequest request)
        {
            return await searchService.Search(request);
        }
    }
}
