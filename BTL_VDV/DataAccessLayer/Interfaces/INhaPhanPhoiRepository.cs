using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public partial interface INhaPhanPhoiRepository
    {
        bool Create(NhaPhanPhoisModel model);
        bool Update(NhaPhanPhoisModel model);
        bool Delete(int id);
        NhaPhanPhoisModel GetID(int id);
        public List<NhaPhanPhoisModel> Search(int pageIndex, int pageSize, out long total);
    }
}
