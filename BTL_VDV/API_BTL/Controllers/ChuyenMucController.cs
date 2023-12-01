using BusinessLogicLayer;
using DataModel;
using DataAccessLayer;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChuyenMucController : ControllerBase
    {
        private IChuyenMucBUS CMbus;
        public ChuyenMucController(IChuyenMucBUS bus)
        {
            CMbus = bus;
        }
        [Route("ChuyenMuc_Create")]
        [HttpPost]
        public ChuyenMucModel Create(ChuyenMucModel model) 
        {
            CMbus.Create(model);
            return model;
        }

        [Route("ChuyenMuc_Update")]
        [HttpPost]
        public ChuyenMucModel Update(ChuyenMucModel model)
        {
            CMbus.Update(model);
            return model;
        }
        [Route("ChuyenMuc_Delete")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            CMbus.Delete(id);
            return Ok();
        }

        //[Authorize]
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
                var data = CMbus.Search(page, pageSize, out total/*l, tenSanPham*//*, gia, soluong*/);
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
