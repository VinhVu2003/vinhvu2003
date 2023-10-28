using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public interface  ISizeRepository
    {
        SizeModel GetDatabyID(int id);
        public List<SizeModel> Search(int pageIndex, int pageSize, out long total);
        
    }
}
