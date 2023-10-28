using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class SanPhamModel
    {
        public int MaSanPham {  get; set; }
        public int MaChuyenMuc { get; set; }
        //public string tenchuyenmuc { get; set; }
        public string TenSanPham {  set; get; }
        public string AnhDaiDien {  set; get; }
        public decimal Gia {  set; get; }
        public decimal GiaGiam {  set; get; }
        public int SoLuong {  set; get; }
        public bool TrangThai {  set; get; }
        public int LuotXem {  set; get; }
        public int MaSize { get; set; }
        //public string TenSize { get; set; }
    }
}
