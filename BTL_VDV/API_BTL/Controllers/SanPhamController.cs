using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
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
        [Route("San_Pham_Create")]
        [HttpPost]
        public SanPhamModel Create(SanPhamModel model)
        {
            _bus.Create(model);
            return model;
        }

        [Route("San_Pham_Delete")]
        [HttpDelete]
        public IActionResult Delete(int ID)
        {
            _bus.Delete(ID);
            return Ok();
          
        }

       
        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new SanPhamGetALL_Model();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                //string tenSanPham = "";
                //if (formData.Keys.Contains("tenSanPham") && !string.IsNullOrEmpty(Convert.ToString(formData["tenSanPham"]))) { tenSanPham = Convert.ToString(formData["tenSanPham"]); }
                //int gia = 0; // You can change the default value as needed.
                //int soluong = 0; // You can change the default value as needed.

                //if (formData.Keys.Contains("gia") && !string.IsNullOrEmpty(Convert.ToString(formData["gia"])))
                //{
                //    gia = int.Parse(Convert.ToString(formData["gia"]));
                //}

                //if (formData.Keys.Contains("soluong") && !string.IsNullOrEmpty(Convert.ToString(formData["soluong"])))
                //{
                //    soluong = int.Parse(Convert.ToString(formData["soluong"]));
                //}

                long total = 0;
                var data = _bus.Search(page, pageSize, out total/*l, tenSanPham*//*, gia, soluong*/);
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
