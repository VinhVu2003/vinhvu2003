using BusinessLogicLayer.Interfaces;
using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public class ThongKeBUS:IThongKeBUS
    {
        private IThongKeRepository _res;
        public ThongKeBUS(IThongKeRepository _res)
        {
            this._res = _res;
        }
        public List<ThongKeKhachModel> Thong_Ke_Khach(int pageIndex, int pageSize, out long total, string TenKhach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            return _res.Thong_Ke_Khach(pageIndex, pageSize, out total, TenKhach, fr_NgayTao, to_NgayTao);
        }
        public ThongKeDoanhThuModel ThongKeDoanhThu(DateTime fr_NgayTao, DateTime to_NgayTao)
        {
            return _res.ThongKeDoanhThu( fr_NgayTao, to_NgayTao);
        }

        public List<ThongKe_SP_BanChay> ThongKe_SP_BanChay(int pageIndex, int pageSize, out long total, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            return _res.ThongKe_SP_BanChay(pageIndex, pageSize, out total, fr_NgayTao, to_NgayTao);
        }
    }
}
