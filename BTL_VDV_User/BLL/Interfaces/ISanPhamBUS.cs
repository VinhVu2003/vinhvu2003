using DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Interfaces
{
    public partial interface ISanPhamBUS
    {
        SanPhamModel GetDatabyID(int id);

        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenChuyenMuc, string TenSize);
        public SanPhamModel Serch_SP_TheoSize(string TenSanPham, int MaSize);
        public List<SanPhamModel> Search_CM(int pageIndex, int pageSize, out long total, int MaChuyenMuc);

        public List<SanPhamModel> Search_SP_BanChay(int pageIndex, int pageSize, out long total);


        public List<SanPhamModel> Search_SP_New(int pageIndex, int pageSize, out long total);

        public List<GetAllSizeModel> Search_SP_GetAllSize(int pageIndex, int pageSize, out long total, string TenSanPham);
        public List<SanPhamModel> Search2(int pageIndex, int pageSize, out long total, string TenSanPham, string TenSize, int MinPrice, int MaxPrice);

    }
}
