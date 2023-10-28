using DataAccessLayer;
using DataModel;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class ChuyenMucRepository:IChuyenMucRepository
    {
        private IDatabaseHelper _db;
        public ChuyenMucRepository(IDatabaseHelper db)
        {
            _db = db;
        }
        public bool Create(ChuyenMucModel model) 
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "create_chuyen_muc",
                    "@TenChuyenMuc", model.TenChuyenMuc
                   /* "@NoiDung", model.NoiDung*/);
                if ((result != null && !string.IsNullOrEmpty(result.ToString()) || !string.IsNullOrEmpty(msgError)))
                {
                    throw new Exception(Convert.ToString(result)+msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool Update(ChuyenMucModel model)
        {
            string msg = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msg, "Update_chuyen_muc",
                    "@MaChuyenMuc", model.MaChuyenMuc,
                    "@TenChuyenMuc", model.TenChuyenMuc
                    /*"@NoiDung", model.NoiDung*/);
                if ((result != null && !string.IsNullOrEmpty(result.ToString()) || !string.IsNullOrEmpty(msg)))
                {
                    throw new Exception (Convert.ToString(result)+msg);
                }
                return true;
            }
            catch (Exception ex) { throw ex;}
        }

        public bool Delete(int ID)
        {
            string msg = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msg, "Delete_chuyen_muc", "@MaChuyenMuc", ID);
                if((result != null && !string.IsNullOrEmpty(result.ToString()) || !string.IsNullOrEmpty(msg)))
                {
                    throw new Exception(Convert.ToString(result) + msg);
                }
                return true;
            }
            catch (Exception ex) { throw ex;}
        }


        public List<ChuyenMucModel> Search(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Chuyenmuc_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize

                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<ChuyenMucModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        
    }
}
