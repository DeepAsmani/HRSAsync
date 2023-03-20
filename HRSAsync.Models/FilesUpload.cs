using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace HRSAsync.Models
{
    public class FilesUpload
    {
        public IEnumerable<IFormFile> Files { get; set; }
    }
}