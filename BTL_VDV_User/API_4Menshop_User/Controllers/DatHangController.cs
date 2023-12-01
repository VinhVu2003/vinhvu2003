using System;
using DataModel;
using BusinessLogicLayer;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DatHangController : ControllerBase
    {
       
        private IDatHangBusiness _khachBusiness;
      

        public DatHangController(IDatHangBusiness khachBusiness)
        {
            this._khachBusiness = khachBusiness;
           
        }

       

        [Route("Create")]
        [HttpPost]
        public DatHangModel CreateItem([FromBody] DatHangModel model)
        {
            _khachBusiness.Create(model);
            return model;
        }
      

    }
}
