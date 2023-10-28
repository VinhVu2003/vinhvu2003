using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface IChuyenMucBUS
    {
        bool Create(ChuyenMucModel model);
        bool Update(ChuyenMucModel model);
        bool Delete(int ID);
        List<ChuyenMucModel> Search(int pageIndex, int pageSize, out long total);
        
    }
}
