using BusinessLogicLayer;
using DataAccessLayer;

using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class NhaPhanPhoiBUS:INhaPhanPhoiBUS
    {
        private INhaPhanPhoiRepository _res;
        public NhaPhanPhoiBUS(INhaPhanPhoiRepository res)
        {
            this._res = res;
        }
        public bool Create(NhaPhanPhoisModel m)
        {
            return _res.Create(m);
        }

        public bool Update(NhaPhanPhoisModel m) 
        {
            return _res.Update(m); 
        }

        public bool Delete(int m)
        {
            return _res.Delete(m);
        }
        public NhaPhanPhoisModel GetID(int m) {
            return _res.GetID(m);
        }

        public List<NhaPhanPhoisModel> Search(int pageIndex, int pageSize, out long total)
        {
            return _res.Search(pageIndex, pageSize, out total);
        }
    }
}
