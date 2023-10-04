using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public  class HoaDonBanRepository : IHoaDonBanRepository
    {
        private IDatabaseHelper _dbHelper;
        public HoaDonBanRepository(IDatabaseHelper DatabaseHelper)
        {
            this._dbHelper = DatabaseHelper;
        }

        public bool Create(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadon_create",
                "@TenKH", model.TenKH,
                "@Diachi", model.DiaChi,
                "@TrangThai", model.TrangThai,
                "@NgayTao", model.NgayTao,
                "@SDT", model.SDT,
                "@DiaChiGiaoHang", model.DiaChiGiaoHang,
                "@list_json_chitiethoadon", model.list_json_ChiTietHD != null ? MessageConvert.SerializeObject(model.list_json_ChiTietHD) : null);
                //if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                //{
                //    throw new Exception(Convert.ToString(result) + msgError);
                //}
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(HoaDonModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoa_don_update",
                "@MaHoaDon", model.MaHoaDon,
                "@TenKH", model.TenKH,
                "@Diachi", model.DiaChi,
                "@TrangThai", model.TrangThai,
                "@NgayTao", model.NgayTao,
                "@SDT", model.SDT,
                "@DiaChiGiaoHang", model.DiaChiGiaoHang,
                "@list_json_chitiethoadon", model.list_json_ChiTietHD != null ? MessageConvert.SerializeObject(model.list_json_ChiTietHD) : null);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
