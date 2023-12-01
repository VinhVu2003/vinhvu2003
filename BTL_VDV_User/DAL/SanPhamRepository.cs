using DAL.Interfaces;
using DataAccessLayer;
using DataModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
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

        public SanPhamModel Serch_SP_TheoSize(string TenSanPham, int MaSize)
        {
            string msgError = "";
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Search_sp_TheoSize", 
                    "@TenSP", TenSanPham,
                    "@MaSize", MaSize
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModel>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> Search_CM(int pageIndex, int pageSize, out long total, int MaChuyenMuc)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "User_SP_Search_ChuyenMuc",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@MaCM", MaChuyenMuc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<SanPhamModel> Search_SP_BanChay(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "User_Selling_Products",
                    "@page_index", pageIndex,
                    "@page_size", pageSize);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> Search_SP_New(int pageIndex, int pageSize, out long total)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "User_New_Products",
                    "@page_index", pageIndex,
                    "@page_size", pageSize);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<GetAllSizeModel> Search_SP_GetAllSize(int pageIndex, int pageSize, out long total, string TenSanPham)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "Get_all_Size",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_SP",TenSanPham
                  );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<GetAllSizeModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public List<SanPhamModel> Search2(int pageIndex, int pageSize, out long total, string TenSanPham, string TenSize, int MinPrice, int MaxPrice)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _db.ExecuteSProcedureReturnDataTable(out msgError, "USer_SanPham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@TenSP", TenSanPham,
                    "@TenSize", TenSize,
                    "@MinPrice", MinPrice,
                    "@MaxPrice", MaxPrice
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModel> Search(int pageIndex, int pageSize, out long total, string TenChuyenMuc, string TenSize)
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
                return dt.ConvertTo<SanPhamModel>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
