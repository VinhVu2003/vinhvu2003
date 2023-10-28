using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface ISanPhamBUS
    {
        SanPhamModel GetDatabyID(int id);
        bool Create(SanPhamModel model);
        bool Update(SanPhamModel model);
        bool Delete(int ID);
        public List<SanPham_Search_Model> Search(int pageIndex, int pageSize, out long total, string TenChuyenMuc, string TenSize);
    }
}
