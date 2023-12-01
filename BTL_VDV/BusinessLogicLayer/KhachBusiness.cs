using DataModel;
using DataAccessLayer;


using System.Globalization;

namespace BusinessLogicLayer
{
    public class KhachBusiness : IKhachBusiness
    {
        private IKhachRepository _res;
        public KhachBusiness (IKhachRepository res)
        {
            _res = res;
        }
        public KhachModel GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public bool Create(KhachModel model)
        {
            return _res.Create(model);
        }
        public bool Update(KhachModel model)
        {
            return _res.Update(model);
        }
        public bool Delete(int id)
        {
            return _res.Delete(id);
        }
        public List<KhachModel> SearchKH(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi)
        {
            return _res.SearchKH(pageIndex,pageSize,out total,ten_khach, dia_chi);
        }
    }
}
