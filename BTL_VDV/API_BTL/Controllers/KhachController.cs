using DataModel;
using BusinessLogicLayer;
using Microsoft.AspNetCore.Mvc;
namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhachController : ControllerBase
    {
        private IKhachBusiness _khachBusiness;
        public KhachController(IKhachBusiness khachBusiness)
        {
            _khachBusiness = khachBusiness;
        }

        [Route("get_by_id")]
        [HttpGet]
        public KhachModel GetAtabeyID(int id)
        {
            return _khachBusiness.GetDatabyID(id);
        }


        [Route("Create")]
        [HttpPost]
        public KhachModel CreateItem([FromBody] KhachModel model)
        {
            _khachBusiness.Create(model);
            return model;
        }

        [Route("Update_KH")]
        [HttpPost]
        public KhachModel UpdateKH(KhachModel model)
        {
            _khachBusiness.Update(model);   
            return model;
        }
        [Route("Delete_KH")]
        [HttpDelete]
        public IActionResult DeleteKH(int id)
        {
            _khachBusiness.Delete(id);
            return Ok();
        }


        [Route("search")]
        [HttpPost]
        public IActionResult SearchKH([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string ten_khach = "";
                if (formData.Keys.Contains("ten_khach") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_khach"]))) { ten_khach = Convert.ToString(formData["ten_khach"]); }
                string dia_chi = "";
                if (formData.Keys.Contains("dia_chi") && !string.IsNullOrEmpty(Convert.ToString(formData["dia_chi"]))) { dia_chi = Convert.ToString(formData["dia_chi"]); }
                long total = 0;
                var data = _khachBusiness.SearchKH(page, pageSize, out total, ten_khach, dia_chi);
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
