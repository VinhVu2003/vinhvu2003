using DataAccessLayer.Interfaces;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class ThongKeRepository:IThongKeRepository
    {
        private IDatabaseHelper _db;
        public ThongKeRepository(IDatabaseHelper db)
        {
            _db = db;
        }

        public List<ThongKeKhachModel> Thong_Ke_Khach(int pageIndex, int pageSize, out long total, string TenKhach, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "[sp_thong_ke_khachhang]",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_khach", TenKhach,
                    "@fr_NgayTao", fr_NgayTao,
                    "@to_NgayTao",to_NgayTao
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<ThongKeKhachModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public ThongKeDoanhThuModel ThongKeDoanhThu(DateTime fr_NgayTao,DateTime to_NgayTao)
        {
            string msgError = "";
            
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "ThongKeDoanhThu",
                    "@from_Ngay", fr_NgayTao,
                    "@to_Ngay", to_NgayTao
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
               
                return dt.ConvertTo<ThongKeDoanhThuModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ThongKe_SP_BanChay> ThongKe_SP_BanChay(int pageIndex, int pageSize, out long total, DateTime? fr_NgayTao, DateTime? to_NgayTao)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Admin_Selling_Products",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@fr_NgayTao",fr_NgayTao,
                    "@to_NgayTao",to_NgayTao);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<ThongKe_SP_BanChay>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
