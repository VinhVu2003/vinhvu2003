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
    public class HoaDonNhapBUS:IHoaDonNhapBUS
    {
        private IHoaDonNhapRepository _res;
        public HoaDonNhapBUS(IHoaDonNhapRepository res)
        {
            _res = res;
        }
        public bool Create(HoaDonNhapModel model)
        {
            return _res.Create(model);
        }
    }
}
