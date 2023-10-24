using BusinessLogicLayer.Interfaces;
using DataAccessLayer.Interfaces;
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

        public List<SanPhamGetALL_Model> Search(int pageIndex, int pageSize, out long total/*, string tenSanPham*//*, int gia, int soluong*/)
        {
            return _repository.Search(pageIndex, pageSize, out total);
        }
    }
}
