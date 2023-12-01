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

        [Route("Serch_SP_TheoSize")]
        [HttpGet]
        public SanPhamModel Serch_SP_TheoSize(string TenSanPham, int MaSize)
        {
            return _bus.Serch_SP_TheoSize(TenSanPham,MaSize);
        }

        [Route("search_ChuyenMuc")]
        [HttpPost]
        public IActionResult Search_CM([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                int MaChuyenMuc=0;
                if (formData.ContainsKey("MaChuyenMuc") && !string.IsNullOrEmpty(formData["MaChuyenMuc"].ToString()))
                {
                    if (int.TryParse(formData["MaChuyenMuc"].ToString(), out int mcm))
                    {
                        MaChuyenMuc = mcm;
                    }
                }
                long total = 0;
                var data = _bus.Search_CM(page, pageSize, out total, MaChuyenMuc);
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


        [Route("Search_SP_GetAllSize")]
        [HttpPost]
        public IActionResult Search_SP_GetAllSize([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                
                string TenSanPham = "";

                if (formData.Keys.Contains("TenSanPham") && !string.IsNullOrEmpty(Convert.ToString(formData["TenSanPham"]))) { TenSanPham = Convert.ToString(formData["TenSanPham"]); }

                long total = 0;
                var data = _bus.Search_SP_GetAllSize(page, pageSize, out total, TenSanPham);
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

        [Route("search2")]
        [HttpPost]
        public IActionResult Search2([FromBody] Dictionary<string, object> formData)
        {
            
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string TenSanPham = "";

                if (formData.Keys.Contains("TenSanPham") && !string.IsNullOrEmpty(Convert.ToString(formData["TenSanPham"])))
                {
                    TenSanPham = Convert.ToString(formData["TenSanPham"]);
                }

                string TenSize = "";
                if (formData.Keys.Contains("TenSize") && !string.IsNullOrEmpty(Convert.ToString(formData["TenSize"]))) { TenSize = Convert.ToString(formData["TenSize"]); }

                int MinPrice = 0;
                if (formData.TryGetValue("MinPrice", out var giaFromValue) && int.TryParse(giaFromValue.ToString(), out var parsedGiaFrom))
                {
                    MinPrice = parsedGiaFrom;
                }

                int MaxPrice = 0;
                if (formData.TryGetValue("MaxPrice", out var giaToValue) && int.TryParse(giaToValue.ToString(), out var parsedGiaTo))
                {
                    MaxPrice = parsedGiaTo;
                }

                long total = 0;
                var data = _bus.Search2(page, pageSize, out total, TenSanPham, TenSize, MinPrice, MaxPrice);
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

        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string TenChuyenMuc = "";

                if (formData.Keys.Contains("TenChuyenMuc") && !string.IsNullOrEmpty(Convert.ToString(formData["TenChuyenMuc"])))
                {
                    TenChuyenMuc = Convert.ToString(formData["TenChuyenMuc"]);
                }

                string TenSize = "";
                if (formData.Keys.Contains("TenSize") && !string.IsNullOrEmpty(Convert.ToString(formData["TenSize"]))) { TenSize = Convert.ToString(formData["TenSize"]); }


                long total = 0;
                var data = _bus.Search(page, pageSize, out total, TenChuyenMuc, TenSize);
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
