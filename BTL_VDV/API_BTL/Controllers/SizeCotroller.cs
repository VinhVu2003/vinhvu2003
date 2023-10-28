using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataAccessLayer;
namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SizeCotroller : ControllerBase
    {
        private ISizeBUS _bus;
        public SizeCotroller(ISizeBUS bus)
        {
            _bus = bus;
        }

        [Route("get_by_id")]
        [HttpGet]
        public SizeModel GetAtabeyID(int id)
        {
            return _bus.GetDatabyID(id);
        }

        [Route("Size_Search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new SizeModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = _bus.Search(page, pageSize, out total);
                return Ok(
                   new
                   {
                       TotalItems = total,
                       Data = data,
                       Page = page,
                       PageSize = pageSize
                   }
                   );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
