using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface ISizeBUS
    {
        SizeModel GetDatabyID(int id);
        List<SizeModel> Search(int pageIndex, int pageSize, out long total);
    }
}
