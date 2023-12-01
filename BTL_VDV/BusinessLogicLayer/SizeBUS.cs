using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class SizeBUS:ISizeBUS
    {
        private ISizeRepository _res;
        public SizeBUS(ISizeRepository res)
        {
            _res = res;
        }

        public SizeModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public List<SizeModel> Search(int pageIndex, int pageSize, out long total)
        {
            return _res.Search(pageIndex, pageSize, out total);
        }
    }
}
