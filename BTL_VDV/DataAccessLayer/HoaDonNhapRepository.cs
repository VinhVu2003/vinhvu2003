using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class HoaDonNhapRepository:IHoaDonNhapRepository
    {
        private IDatabaseHelper _databaseHelper;
        public HoaDonNhapRepository(IDatabaseHelper databaseHelper)
        {
            _databaseHelper= databaseHelper;
        }


        public bool Create(HoaDonNhapModel model)
        {
            string msgError = "";
            try
            {
                var result = _databaseHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_hoadonnhap_create",
                "@MaNhaPhanPhoi", model.MaNhaPhanPhoi,
                "@NgayTao", model.NgayTao,
                "@KieuThanhToan", model.KieuThanhToan,
                "@MaTaiKhoan", model.MaTaiKhoan,
                "@@list_js_ChitietHDN", model.list_js_ChitietHDN != null ? MessageConvert.SerializeObject(model.list_js_ChitietHDN) : null);
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
    }
}
