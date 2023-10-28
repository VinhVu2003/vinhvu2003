using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class NhaPhanPhoiRepository : INhaPhanPhoiRepository
    {
        private IDatabaseHelper _db;
        public NhaPhanPhoiRepository(IDatabaseHelper db)
        {
            _db = db;
        }
        public bool Create(NhaPhanPhoisModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "create_NhaPhanPhoi",
                    "@TenNPP", model.TenNhaPhanPhoi,
                    "@diachi", model.DiaChi,
                    "@sdt", model.SoDienThoai
                    );
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result)+msgError);
                }
                return true;
            }
            catch(Exception ex) 
            {
                throw ex;
            }
        }

        public bool Update(NhaPhanPhoisModel model)
        {
            string msgError = "";
            try
            {
                var redult = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "update_NhaPhanPhoi",
                    "@MaNPP", model.MaNhaPhanPhoi,
                    "@TenNPP", model.TenNhaPhanPhoi,
                    "@diachi", model.DiaChi,
                    "@sdt", model.SoDienThoai
                   );
                if((redult != null && !string.IsNullOrEmpty(redult.ToString()) || !string.IsNullOrEmpty(msgError)))
                {
                    throw new Exception (Convert.ToString(redult)+msgError);
                }
                return true;
            }
            catch(Exception e) 
            {
                throw e;
            }
        }

        public bool Delete(int id)
        {
            string msg = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msg, "delete_NPP",
                    "@MaNPP", id);
                if ((result != null && !string.IsNullOrEmpty(result.ToString()) || !string.IsNullOrEmpty(msg)))
                {
                    throw new Exception(Convert.ToString(result) + msg);
                }
                return true;
            }
            catch (Exception ex) { throw ex; }
        }

        public NhaPhanPhoisModel GetID(int id)
        {
            string msg = "";
            try
            {
                var result = _db.ExecuteSProcedureReturnDataTable(out msg, "Get_NhaPhanPhoi",
                    "@MaID", id);
                if (!string.IsNullOrEmpty(msg))
                
                    throw new Exception(msg);
                return result.ConvertTo<NhaPhanPhoisModel>().FirstOrDefault();
                
                
            }
            catch (Exception ex) { throw ex; }
        }

        public List<NhaPhanPhoisModel> Search(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "NhaPhanPhoi_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize
               
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<NhaPhanPhoisModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
