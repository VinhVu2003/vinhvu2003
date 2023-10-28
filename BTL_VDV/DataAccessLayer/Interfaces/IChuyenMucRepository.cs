using DataModel;
using System;
using System.Collections.Generic;
using System.Diagnostics.SymbolStore;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer 
{
    public partial interface IChuyenMucRepository
    {
        bool Create(ChuyenMucModel model);
        bool Update(ChuyenMucModel model);
        bool Delete(int ID);
        public List<ChuyenMucModel> Search(int pageIndex, int pageSize, out long total);
       
    }
}
