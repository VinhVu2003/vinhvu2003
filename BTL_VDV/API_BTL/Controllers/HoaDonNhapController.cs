using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonNhapController : ControllerBase
    {
        private IHoaDonNhapBUS _bus;
        public HoaDonNhapController(IHoaDonNhapBUS bus)
        {
            this._bus = bus;
        }
        [Route("HoaDonNhap_Create")]
        [HttpPost]
        public HoaDonNhapModel Create(HoaDonNhapModel model) 
        {
            _bus.Create(model);
            return model;
        }

        [Route("HoaDonNhap_Search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
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



        [Route("List_CTHDN_Getbyid")]
        [HttpGet]
        public List<ChitietHDNModel> CTHDN_Get_List_ByID(int id)
        {
            return _bus.CTHDN_Get_List_ByID(id);
        }
    }
}
