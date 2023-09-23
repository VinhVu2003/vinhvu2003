using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public partial interface IKhachRepository
    {
        KhachModel GetDatabyID(int id);

        bool Create(KhachModel model);
        bool Update(KhachModel model);
        bool Delete(int ID);

        public List<KhachModel>SearchKH(int pageIndex, int pageSize,out long total,string ten_khach,string dia_chi);
    }
}