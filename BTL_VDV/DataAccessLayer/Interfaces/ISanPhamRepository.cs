using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface ISanPhamRepository
    {
        bool Create(SanPhamModel model);
        bool Delete(int ID);
        public List<SanPhamGetALL_Model> Search(int pageIndex, int pageSize, out long total/* string tenSanPham*//*, int gia, int soluong*/);
    }
}
