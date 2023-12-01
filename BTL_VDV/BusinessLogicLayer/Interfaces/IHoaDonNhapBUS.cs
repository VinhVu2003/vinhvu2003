using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface IHoaDonNhapBUS
    {
        bool Create(HoaDonNhapModel model);
        public List<HoaDonNhapModel> Search(int pageIndex, int pageSize, out long total);
        List<ChitietHDNModel> CTHDN_Get_List_ByID(int id);
    }
}
