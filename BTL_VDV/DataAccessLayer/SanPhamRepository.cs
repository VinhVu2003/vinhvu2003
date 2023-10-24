using DataAccessLayer.Interfaces;
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
                "@Size", model.Size);

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

        public List<SanPhamGetALL_Model> Search(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "SanPham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize
                    //"@tensanpham", tenSanPham,
                    //"@gia", gia,
                    //"@soluong", soluong

                    //"@Email",Email,
                    //"@SDT",SDT,
                    //"@DiaChiGiaoHang", DiaChiGiaoHang
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamGetALL_Model>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
