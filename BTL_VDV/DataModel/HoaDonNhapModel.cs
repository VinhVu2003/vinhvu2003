using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonNhapModel
    {
        public int MaHoaDon {  get; set; }
        public int MaNhaPhanPhoi { get; set; }
        public DateTime NgayTao {  get; set; }
        public string KieuThanhToan { get; set; }
        public int MaTaiKhoan {  get; set; }

        public List<ChitietHDNModel> list_js_ChitietHDN { get; set; }
    }

    
}
