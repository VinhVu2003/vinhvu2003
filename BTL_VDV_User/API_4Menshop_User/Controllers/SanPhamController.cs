using BLL.Interfaces;
using DataModels;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_4Menshop_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBUS _bus;
        public SanPhamController(ISanPhamBUS bus)
        {
            _bus = bus;
        }

        [Route("get_by_id")]
        [HttpGet]
        public SanPhamModel GetAtabeyID(int id)
        {
            return _bus.GetDatabyID(id);
        }

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int MaChuyenMuc=0;
                
                if (formData.Keys.Contains("MaChuyenMuc") && MaChuyenMuc>0)
                {
                    MaChuyenMuc = Convert.ToInt32(formData["MaChuyenMuc"]);
                }
                long total = 0;
                var data = _bus.Search(page, pageSize, out total, MaChuyenMuc);
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


        [Route("Search_SP_BanChay")]
        [HttpPost]
        public IActionResult Search_SP_BanChay([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = _bus.Search_SP_BanChay(page, pageSize, out total);
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

        [Route("Search_SP_New")]
        [HttpPost]
        public IActionResult Search_SP_New([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = _bus.Search_SP_New(page, pageSize, out total);
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
