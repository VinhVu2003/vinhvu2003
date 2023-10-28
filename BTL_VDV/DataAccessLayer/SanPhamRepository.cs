using DataAccessLayer;
using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class SanPhamRepository:ISanPhamRepository
    {
        private IDatabaseHelper _db;
        public SanPhamRepository(IDatabaseHelper db)
        {
            _db = db;
        }

        public SanPhamModel GetDatabyID(int id)
        {

            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Sanpham_getbyID", "@MaID", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public bool Create(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "create_San_Pham",

                "@MaChuyenMuc", model.MaChuyenMuc,
                "@Anh",model.AnhDaiDien,
                "@TenSanPham", model.TenSanPham,
                "@Gia", model.Gia,
                "@SoLuong", model.SoLuong,
                "@MaSize", model.MaSize);

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

        public bool Delete(int ID)
        {
            string msgError = "";
            try
            {
                var result = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "SanPham_Delete",
                    "@MaSP", ID);
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex) { throw ex; }
        }

        public bool Update(SanPhamModel model)
        {
            string msgError = "";
            try
            {
                var redult = _db.ExecuteScalarSProcedureWithTransaction(out msgError, "SanPham_Update",
                    "@MaSP", model.MaSanPham,
                    "@MaChuyenMuc", model.MaChuyenMuc,
                    "@Anh", model.AnhDaiDien,
                    "@TenSanPham", model.TenSanPham,
                    "@Gia", model.Gia,
                    "@SoLuong",model.SoLuong,   
                    "@MaSize",model.MaSize
                   );
                if ((redult != null && !string.IsNullOrEmpty(redult.ToString()) || !string.IsNullOrEmpty(msgError)))
                {
                    throw new Exception(Convert.ToString(redult) + msgError);
                }
                return true;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public List<SanPham_Search_Model> Search(int pageIndex, int pageSize, out long total, string TenChuyenMuc, string TenSize)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "SanPham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@TenCM", TenChuyenMuc,
                    "@TenSize", TenSize

                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPham_Search_Model>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
