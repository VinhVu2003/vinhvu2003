using BusinessLogicLayer;
using DataAccessLayer;
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
        public List<HoaDonNhapModel> Search(int pageIndex, int pageSize, out long total)
        {
            return _res.Search(pageIndex, pageSize, out total);
        }
        public List<ChitietHDNModel> CTHDN_Get_List_ByID(int id)
        {
            return _res.CTHDN_Get_List_ByID(id);
        }
    }
}
