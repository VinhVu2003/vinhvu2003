using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NhaPhanPhoiController : ControllerBase
    {
        private INhaPhanPhoiBUS bus;
        public NhaPhanPhoiController(INhaPhanPhoiBUS bus)
        {
            this.bus = bus;
        }
        [Route("NhaPhanPhoi_Create")]
        [HttpPost]
        public NhaPhanPhoisModel Create(NhaPhanPhoisModel model)
        {
            bus.Create(model);
            return model;
        }

        [Route("PhaPhanPhoi_Update")]
        [HttpPost]
        public NhaPhanPhoisModel Update(NhaPhanPhoisModel model) 
        { 
            bus.Update(model); return model;
        }

        [Route("PhaPhanPhoi_Delete")]
        [HttpDelete]
        public IActionResult Delete(int id)
        {
            bus.Delete(id);
            return Ok();
        }

        [Route("PhaPhanPhoi_GetID")]
        [HttpGet]
        public NhaPhanPhoisModel GetID(int id)
        {
            return bus.GetID(id);
        }



        [Route("NhaPhanPhoi_Search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new NhaPhanPhoisModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                long total = 0;
                var data = bus.Search(page, pageSize, out total/*l, tenSanPham*//*, gia, soluong*/);
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
