using DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Interfaces
{
    public partial interface ISanPhamRepository
    {
        SanPhamModel GetDatabyID(int id);
        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, int MaChuyenMuc);

        public List<SanPhamModel> Search_SP_BanChay(int pageIndex, int pageSize, out long total);

        public List<SanPhamModel> Search_SP_New(int pageIndex, int pageSize, out long total);
    }
}
