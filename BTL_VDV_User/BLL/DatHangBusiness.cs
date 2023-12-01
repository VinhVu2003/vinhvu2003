using DataModel;
using DataAccessLayer;
using BLL;

using System.Globalization;

namespace BusinessLogicLayer
{
    public class DatHangBusiness : IDatHangBusiness
    {
        private IDatHangRepository _res;
        public DatHangBusiness (IDatHangRepository res)
        {
            _res = res;
        }
        //public DatHangModel SearchIDKH(string tenkh, string diachi, string sdt)
        //{
        //    return _res.SearchIDKH(tenkh,diachi,sdt);
        //}

        public bool Create(DatHangModel model)
        {
            return _res.Create(model);
        }
        //public bool Update(KhachModel model)
        //{
        //    return _res.Update(model);
        //}
        //public bool Delete(int id)
        //{
        //    return _res.Delete(id);
        //}
        //public List<KhachModel> SearchKH(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi)
        //{
        //    return _res.SearchKH(pageIndex,pageSize,out total,ten_khach, dia_chi);
        //}
    }
}
