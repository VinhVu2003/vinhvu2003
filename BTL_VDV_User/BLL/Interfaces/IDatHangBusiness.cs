using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;
using DataAccessLayer;
namespace BusinessLogicLayer
{
    public partial interface IDatHangBusiness
    {
        //DatHangModel SearchIDKH(string tenkh, string diachi, string sdt);
        bool Create(DatHangModel model);
        //bool Update(KhachModel model);
        //bool Delete(int id);

        //public List<KhachModel> SearchKH(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi);
    }
   
}
