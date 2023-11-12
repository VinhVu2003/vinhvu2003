using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class CTHDB_GetID_Model
    {
        public int MaChiTietHoaDon { get; set; }
        public int MaHoaDon { get; set; }
        public int MaSanPham { get; set; }
        public string TenSanPham { get;set; }
        public string AnhDaiDien { get; set; }
        public decimal Gia {  get; set; }
        public int SoLuong { get; set; }
        public decimal TongGia { get; set; }
        public string GiamGia { get; set; }
    }
}
