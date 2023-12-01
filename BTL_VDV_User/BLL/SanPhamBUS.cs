using BLL.Interfaces;
using DAL.Interfaces;
using DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SanPhamBUS:ISanPhamBUS
    {
        private ISanPhamRepository _repository;
        public SanPhamBUS(ISanPhamRepository repository)
        {
            _repository = repository;
        }
        public SanPhamModel GetDatabyID(int id)
        {
            return _repository.GetDatabyID(id);
        }

        public SanPhamModel Serch_SP_TheoSize(string TenSanPham, int MaSize)
        {
            return _repository.Serch_SP_TheoSize(TenSanPham, MaSize);
        }

        public List<SanPhamModel> Search_CM(int pageIndex, int pageSize, out long total, int MaChuyenMuc)
        {
            return _repository.Search_CM(pageIndex, pageSize, out total, MaChuyenMuc);
        }

        public List<SanPhamModel> Search_SP_BanChay(int pageIndex, int pageSize, out long total)
        {
            return _repository.Search_SP_BanChay(pageIndex, pageSize, out total);
        }

        public List<SanPhamModel> Search_SP_New(int pageIndex, int pageSize, out long total)
        {
            return _repository.Search_SP_New(pageIndex, pageSize, out total);
        }

        public List<GetAllSizeModel> Search_SP_GetAllSize(int pageIndex, int pageSize, out long total, string TenSanPham)
        {
            return _repository.Search_SP_GetAllSize(pageIndex, pageSize, out total, TenSanPham);
        }

        public List<SanPhamModel> Search2(int pageIndex, int pageSize, out long total, string TenSanPham, string TenSize, int MinPrice, int MaxPrice)
        {
            return _repository.Search2(pageIndex, pageSize, out total, TenSanPham, TenSize, MinPrice, MaxPrice);
        }

        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenChuyenMuc, string TenSize)
        {
            return _repository.Search(pageIndex, pageSize, out total, TenChuyenMuc, TenSize);
        }
    }
}
