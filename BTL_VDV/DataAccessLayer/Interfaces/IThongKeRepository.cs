using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface IThongKeRepository
    {
        public List<ThongKeKhachModel> Thong_Ke_Khach(int pageIndex, int pageSize, out long total, string TenKhach, DateTime? fr_NgayTao, DateTime? to_NgayTao);
        public ThongKeDoanhThuModel ThongKeDoanhThu(DateTime fr_NgayTao, DateTime to_NgayTao);
        public List<ThongKe_SP_BanChay> ThongKe_SP_BanChay(int pageIndex, int pageSize, out long total, DateTime? fr_NgayTao, DateTime? to_NgayTao);
    }
}
