using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChuyenMucController : ControllerBase
    {
        private IChuyenMucBUS _bus;
        public ChuyenMucController(IChuyenMucBUS bus)
        {
            _bus = bus;
        }
        [Route("ChuyenMuc_Create")]
        [HttpPost]
        public ChuyenMucModel Create(ChuyenMucModel model) 
        {
            _bus.Create(model);
            return model;
        }

        [Route("ChuyenMuc_Update")]
        [HttpPost]
        public ChuyenMucModel Update(ChuyenMucModel model)
        {
            _bus.Update(model);
            return model;
        }
        [Route("ChuyenMuc_Delete")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            _bus.Delete(id);
            return Ok();
        }

        [Route("ChuyenMuc_Search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new ChuyenMucModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
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
