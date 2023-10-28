using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface INhaPhanPhoiBUS
    {
        bool Create(NhaPhanPhoisModel model);
        bool Update(NhaPhanPhoisModel model);
        bool Delete(int id);
        NhaPhanPhoisModel GetID(int id);
        List<NhaPhanPhoisModel> Search(int pageIndex, int pageSize, out long total);
    }
}
