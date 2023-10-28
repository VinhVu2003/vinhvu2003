
using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class ChuyenMucBUS:IChuyenMucBUS
    {
        private IChuyenMucRepository _res;
        public ChuyenMucBUS(IChuyenMucRepository res)
        {
            _res = res;
        }
        public bool Create(ChuyenMucModel model)
        {
            return _res.Create(model);
        }

        public bool Update(ChuyenMucModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(int ID)
        {
            return _res.Delete(ID);
        }

        public List<ChuyenMucModel> Search(int pageIndex, int pageSize, out long total)
        {
            return _res.Search(pageIndex, pageSize, out total);
        }
        
    }
}
