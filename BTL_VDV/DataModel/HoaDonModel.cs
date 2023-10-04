﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataModel
{
    public class HoaDonModel
    {

        public int MaHoaDon { get; set; }
        public string TenKH { get; set;  }
        public string DiaChi {  get; set; }
        public bool TrangThai {  get; set; }
        public DateTime NgayTao { get; set; }
        public string SDT { get; set; }
        public string DiaChiGiaoHang { get; set; }


        public List<ChiTietHDModel> list_json_ChiTietHD { get; set; }
    }

    public class ChiTietHDModel
    {
        public int MaChiTietHoaDon { get; set; }
        public int MaHoaDon { get; set; }
        public int MaSanPham { get; set; }
        public int SoLuong { get; set; }
        public double TongGia { get; set; }
        public int status { get; set; }
    }
}