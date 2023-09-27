﻿using BusinessLogicLayer.Interfaces;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API_BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HoaDonBanController : ControllerBase
    {
        private IHoaDonBanBUS bus;
        public HoaDonBanController(IHoaDonBanBUS bus)
        {
            this.bus = bus;
        }
        [Route ("Create_HoaDon")]
        [HttpGet]
        public DonHangBanModel Create(DonHangBanModel model)
        {
            bus.Create (model);
            return model;
        }
    }
}
