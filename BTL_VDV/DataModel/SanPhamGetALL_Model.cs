using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public  class SanPhamGetALL_Model
    {
        public int MaSanPham {  get; set; }
        public string AnhDaiDien {  get; set; }
        public string TenSanPham { get; set; }
        public decimal Gia { get; set; }
        public string Size { get; set; }
        public int SoLuong { set; get; }
    }
}
