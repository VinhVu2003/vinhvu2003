using BusinessLogicLayer.Interfaces;
using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class HoaDonBanBUS:IHoaDonBanBUS
    {
        IHoaDonBanRepository _res;
        public HoaDonBanBUS(IHoaDonBanRepository res)
        {
            _res = res;
        }
        public bool Create(DonHangBanModel model)
        {
            return _res.Create(model);
        }
    }
}
