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
    public class HoaDonBanBUS : IHoaDonBanBUS
    {
        IHoaDonBanRepository _res;
        public HoaDonBanBUS(IHoaDonBanRepository res)
        {
            _res = res;
        }
        public bool Create(HoaDonModel model)
        {
            return _res.Create(model);
        }
        public bool Update(HoaDonModel model)
        {
            return _res.Update(model);
        }

        public bool Delete(int m)
        {
            return _res.Delete(m);
        }

        public List<HoaDonSearch_Model> Search(int pageIndex, int pageSize, out long total, string TenKhach)
        {
            return _res.Search(pageIndex, pageSize, out total, TenKhach);
        }

        public HoaDonModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }
        public List<CTHDB_GetID_Model> CTHD_Get_List_ByID(int id)
        {
            return _res.CTHD_Get_List_ByID(id);
        }

        public CTHDB_GetID_Model CTHD_GetDatabyID(int id)
        {
            return _res.CTHD_GetDatabyID(id);
        }
    }
}
