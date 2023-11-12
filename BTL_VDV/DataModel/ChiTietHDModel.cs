using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ChiTietHDModel
    {
        public int MaChiTietHoaDon { get; set; }
        public int MaHoaDon { get; set; }
        public int MaSanPham { get; set; }
        public int SoLuong { get; set; }
        public decimal TongGia { get; set; }
        public string GiamGia {  get; set; }
        public int status { get; set; }
    }
}
