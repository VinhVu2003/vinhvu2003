using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;
using DataAccessLayer;
namespace BusinessLogicLayer.Interfaces
{
    public partial interface IKhachBusiness
    {
        KhachModel GetDatabyID(int id);
        bool Create(KhachModel model);
        bool Update(KhachModel model);
        bool Delete(int id);

        public List<KhachModel> SearchKH(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi);
    }
   
}
