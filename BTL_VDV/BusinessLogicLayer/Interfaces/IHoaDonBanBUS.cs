using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface IHoaDonBanBUS
    {
        bool Create(HoaDonModel model);
        bool Update(HoaDonModel model);
        bool Delete(int ID);
        HoaDonModel GetDatabyID(int id);
        public List<HoaDonSearch_Model> Search(int pageIndex, int pageSize, out long total, string TenKhach);
        List<CTHDB_GetID_Model> CTHD_Get_List_ByID(int id);

        CTHDB_GetID_Model CTHD_GetDatabyID(int id);
    }
}
