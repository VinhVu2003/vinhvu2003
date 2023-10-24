using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class ChitietHDNModel
    {
        public int Id {  get; set; }
        public int MaHoaDon {  get; set; }
        public int MaSanPham {  get; set; }
        public int SoLuong {  get; set; }
        public string DonViTinh {  get; set; }
        public int GiaNhap { get; set; }
        public int TongTien {  get; set; }
        public int status { get; set; }
    }
}
