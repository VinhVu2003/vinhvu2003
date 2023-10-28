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
    }
}
