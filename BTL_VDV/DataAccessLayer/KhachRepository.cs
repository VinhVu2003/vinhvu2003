
using DataModel;
using System;
using System.Reflection;
using DataAccessLayer;

namespace DataAccessLayer
{
    public class KhachRepository : IKhachRepository
    {
        private IDatabaseHelper _dbHelper;

        public KhachRepository (IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public KhachModel GetDatabyID(int id)
        {
           
            string msgError = "";
            try {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "KH_get_by_id", "@MaID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<KhachModel>().FirstOrDefault();
            }
            catch(Exception ex) 
            {
                throw ex;
            }
        }

        public bool Create(KhachModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "create_khach_hang",
              
                "@TenKH", model.TenKH,
                "@diachi", model.DiaChi,
                "@sdt", model.SDT);
                
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
        public bool Update(KhachModel model)
        {
            string msgError = "";
            try {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "update_khach_hang",
                    "@MaKH", model.MaKH,
                    "@TenKH", model.TenKH,
                    "@diachi", model.DiaChi,
                    "@sdt", model.SDT);
                    if((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch(Exception ex) 
            {
                throw ex;
            }
            return true;
        }
        public bool Delete(int ID)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "delete_khachhang",
                    "@MaKH", ID);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch(Exception ex) { throw ex; }
        }


        public List<KhachModel> SearchKH(int pageIndex, int pageSize, out long total, string ten_khach, string dia_chi)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_khach_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_khach", ten_khach,
                    "@dia_chi", dia_chi);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<KhachModel>().ToList();
            }
            catch(Exception ex) { throw ex; }
        }

    }
}
