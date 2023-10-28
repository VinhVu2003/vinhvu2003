using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer.Interfaces
{
    public partial interface ISanPhamBUS
    {
        SanPhamModel GetDatabyID(int id);
        bool Create(SanPhamModel model);
        
        bool Delete(int ID);
        List<SanPhamModel> Search(int pageIndex, int pageSize, out long total/*, string tenSanPham*//*, int gia, int soluong*/);
    }
}
