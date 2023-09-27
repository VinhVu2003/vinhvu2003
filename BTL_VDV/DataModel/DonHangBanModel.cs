using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class DonHangBanModel
    {

        public int MMaDHB { get; set; }
        public string TenKH { get; set;  }
        public string DiaChi {  get; set; }
        public bool TrangThai {  get; set; }

        public List<ChiTietHDBModel> list_json_ChiTietHDB { get; set; }
    }

    public class ChiTietHDBModel
    {
        public int ID { get; set; }
        public int MaHDB { get; set; }
        public int MaSP { get; set; }
        public int SLBan { get; set; }
        public double TongTien { get; set; }
        public int status { get; set; }
    }
}
