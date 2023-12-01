using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Versioning;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class SanPhamBUS:ISanPhamBUS
    {
        private ISanPhamRepository _repository;
        public SanPhamBUS(ISanPhamRepository repository)
        {
            _repository = repository;
        }
        public bool Create(SanPhamModel model)
        {
           return _repository.Create(model);
        }
        public bool Delete(int ID)
        {
            return _repository.Delete(ID);
        }

        public bool Update(SanPhamModel m)
        {
            return _repository.Update(m);
        }

        public List<SanPham_Search_Model> Search(int pageIndex, int pageSize, out long total, string TenChuyenMuc, string TenSize)
        {
            return _repository.Search(pageIndex, pageSize, out total,TenChuyenMuc,TenSize);
        }
        public SanPhamModel GetDatabyID(int id)
        {
            return _repository.GetDatabyID(id);
        }
    }
}
