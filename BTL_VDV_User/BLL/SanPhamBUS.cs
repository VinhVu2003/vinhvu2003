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

        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, int MaChuyenMuc)
        {
            return _repository.Search(pageIndex, pageSize, out total, MaChuyenMuc);
        }

        public List<SanPhamModel> Search_SP_BanChay(int pageIndex, int pageSize, out long total)
        {
            return _repository.Search_SP_BanChay(pageIndex, pageSize, out total);
        }

        public List<SanPhamModel> Search_SP_New(int pageIndex, int pageSize, out long total)
        {
            return _repository.Search_SP_New(pageIndex, pageSize, out total);
        }
    }
}
