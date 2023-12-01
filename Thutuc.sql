DBCC CHECKIDENT ('SanPhams', RESEED)
select*from HoaDons

select*from ChiTietHoaDons
-----------------------------------------
create proc KH_get_by_id
@MaID int
as
begin
select * from KhachHang as k where k.MaKH=@MaID 
end

create proc Size_get_by_id
@MaID nvarchar(30)
as
begin
select * from Size as k where k.MaSize=@MaID 
end

drop proc KH_get_by_id
exec KH_get_by_id '2'
select*from KhachHang

-------------------------------------------
create proc create_khach_hang(
@TenKH nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	insert into KhachHang(TenKH,DiaChi,SDT)
	values (@TenKH,@diachi,@sdt)
end

select*from KhachHang
 ------------------------------------------
create proc update_khach_hang(
@MaKH nvarchar(50),
@TenKH nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	update KhachHang
	set TenKH=@TenKH, DiaChi=@diachi, SDT=@sdt
	where @MaKH=MaKH
end

select*from KhachHang
 ----------------------------------------------
create proc delete_khachhang(@MaKH nvarchar(50))
as
begin
	delete from KhachHang where MaKH=@MaKH
end
------------------------------------------------
drop proc [sp_khach_search]
create PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @dia_chi Nvarchar(250)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKH,
							  k.TenKH,
							  k.DiaChi,
							  k.SDT
                        INTO #Results1
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKH,
							  k.TenKH,
							  k.DiaChi,
							  k.SDT
                        INTO #Results2
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;
exec [sp_khach_search] '1','10','',''
{
  "page": "1",
  "pageSize": "1"
}
----------------Hoa DOn Ban---------------------------------------
select*from KhachHang
select*from HoaDons
select*from ChiTietHoaDons
select*from SanPhams
select*from KhachHang

drop proc sp_hoadon_create
create PROCEDURE sp_hoadon_create
( 
 @TrangThai bit,  
 @NgayTao datetime,
 @DiaChiGiaoHang nvarchar(250),
 @TongGia float,
 @MaKH int,
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDons
                (
				TrangThai,
				NgayTao,
				TongGia,
				DiaChiGiaoHang,
				MaKH
                )
                VALUES
                (
                 @TrangThai,
				 @NgayTao,
				 @TongGia,
				 @DiaChiGiaoHang,
				 @MaKH
                );

				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadon IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDons
						 (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia,
						  GiamGia
                        )
                    SELECT JSON_VALUE(p.value, '$.maSanPham'), 
                            @MaHoaDon, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.tongGia'),
							JSON_VALUE(p.value, '$.giamGia')
                    FROM OPENJSON(@list_json_chitiethoadon) AS p;
                END;
        SELECT '';
    END;


{
  
  "trangThai": true,
  "ngayTao": "2023-11-03T02:01:49.366Z",
  "diaChiGiaoHang": "string",
  "tongGia": 1,
  "maKH": 2,
  "list_json_ChiTietHD": [
    {
      "maSanPham": 91,
      "soLuong": 1,
      "tongGia": 1,
      "giamGia": "string"
   
    }
  ]
}
------------------------------------
drop proc [sp_hoa_don_update]

create PROCEDURE [dbo].[sp_hoa_don_update]
(@MaHoaDon        int,  
 @MaKH int,
 @TrangThai         bit,  
 @NgayTao datetime,
 @TongGia float,
 @DiaChiGiaoHang nvarchar(250),
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDons
		SET
			TrangThai = @TrangThai,
			NgayTao=@NgayTao,
			DiaChiGiaoHang=@DiaChiGiaoHang,
			TongGia=@TongGia,
			MaKH=@MaKH
		WHERE MaHoaDon = @MaHoaDon;
		
		IF(@list_json_chitiethoadon IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maChiTietHoaDon') as maChiTietHoaDon,
			  JSON_VALUE(p.value, '$.maHoaDon') as maHoaDon,
			  JSON_VALUE(p.value, '$.maSanPham') as maSanPham,
			  JSON_VALUE(p.value, '$.soLuong') as soLuong,
			  JSON_VALUE(p.value, '$.tongGia') as tongGia,
			  JSON_VALUE(p.value, '$.giamGia') as giamGia,
			  JSON_VALUE(p.value, '$.status') AS status 
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadon) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDons (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia,
						  GiamGia) 
			   SELECT
				  #Results.maSanPham,
				  @MaHoaDon,
				  #Results.soLuong,
				  #Results.tongGia,
				  #Results.giamGia
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDons		
			  SET
				 SoLuong = #Results.soLuong,
				 TongGia = #Results.tongGia,
				 GiamGia = #Results.giamGia
			  FROM #Results 
			  WHERE  ChiTietHoaDons.maChiTietHoaDon = #Results.maChiTietHoaDon AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDons C
			INNER JOIN #Results R
				ON C.maChiTietHoaDon=R.maChiTietHoaDon
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;

{
  "maHoaDon": 1,
  "tenKH": "Vinh_update",
  "diaChi": "string",
  "trangThai": true,
  "ngayTao": "2023-10-03T16:03:01.965Z",
  "sdt": "1234567890",
  "diaChiGiaoHang": "string",
  "list_json_ChiTietHD": [
    {
      "maChiTietHoaDon": 1,
      "maHoaDon": 1,
      "maSanPham": 1,
      "soLuong": 1,
      "tongGia": 315000,
      "status": 0
    }
  ]
}

create proc HoaDon_Delete(@MaHoaDon int)
as
begin
	delete from HoaDons where MaHoaDon=@MaHoaDon
end

select*from HoaDons,ChiTietHoaDons

drop proc HoaDon_Search

create PROCEDURE HoaDon_Search (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH

                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') 
						group by h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH
					             
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') 		
						group by h.MaHoaDon,
							  h.MaKH,
							  h.TrangThai,
							  h.NgayTao,
							  h.TongGia,
							  h.DiaChiGiaoHang,
							  kh.TenKH

						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

drop proc HoaDon_Search

{
  "page": "1",
  "pageSize": "10"
}
exec HoaDon_getbyid '83'
create proc HoaDon_getbyid
@MaHD int
as
begin
select * from HoaDons as k where k.MaHoaDon=@MaHD
end

select*from HoaDons
select*from ChiTietHoaDons

--Create proc HD_GetByID_CTHD(@MaHD int)
--as
--	begin
--		select h.MaHoaDon,h.TrangThai,h.NgayTao,h.DiaChiGiaoHang,h.TongGia,h.MaKH,
--				c.MaSanPham,s.TenSanPham,c.SoLuong,c.TongGia,c.GiamGia
--		from HoaDons h inner join ChiTietHoaDons c on h.MaHoaDon=c.MaHoaDon 
--			inner join SanPhams s on s.MaSanPham=c.MaSanPham
--		where h.MaHoaDon=@MaHD
--	end

Create proc Get_List_CTHD(@MaHD int)
as
	begin
		select*
		from ChiTietHoaDons c inner join SanPhams s on c.MaSanPham=s.MaSanPham
		where c.MaHoaDon=@MaHD
	end


exec CTHD_GetByID '83'
drop proc CTHD_GetByID
exec HoaDon_Search '1', '10',''

create proc CTHD_GetByID
@MaID int
as
begin
select * from ChiTietHoaDons as k inner join SanPhams as s on k.MaSanPham=s.MaSanPham 
where k.MaChiTietHoaDon=@MaID 
end
-------------------------------------------------------------------
create PROCEDURE sp_login(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;

select*from SanPhams

create PROCEDURE [dbo].[sp_hoadon_get_by_id](@MaHoaDon        int)
AS
    BEGIN
        SELECT h.*, 
        (
            SELECT c.*
            FROM ChiTietHoaDons AS c
            WHERE h.MaHoaDon = c.MaHoaDon FOR JSON PATH
        ) AS list_json_chitiethoadon
        FROM HoaDons AS h
        WHERE  h.MaHoaDon = @MaHoaDon;
    END;

{
  "username": "Admin1",
  "password": "12345"
}


select*from TaiKhoan

CREATE PROCEDURE sp_get_all_hoadons_with_details
AS
BEGIN
    SELECT
        H.MaHoaDon,
        H.TrangThai,
        H.NgayTao,
        H.TongGia,
        H.DiaChiGiaoHang,
        H.MaKH,
        (
            SELECT
                MaSanPham,
                SoLuong,
                TongGia,
                GiamGia
            FROM ChiTietHoaDons CH
            WHERE CH.MaHoaDon = H.MaHoaDon
            FOR JSON AUTO
        ) AS ChiTietHoaDonJSON
    FROM HoaDons H;
END;
EXEC sp_get_all_hoadons_with_details;
drop proc sp_get_all_hoadons




--------------------------NhaPhanPhoi----------------------------------------------
select*from NhaPhanPhois
select*from ChuyenMucs

create PROCEDURE NhaPhanPhoi_search (@page_index  INT, 
                                 @page_size  int 			  
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaNhaPhanPhoi ASC)) AS RowNumber, 
                              h.MaNhaPhanPhoi,
							  h.TenNhaPhanPhoi,
							  h.DiaChi,
							  h.SoDienThoai,
							  h.MoTa
                        INTO #Results1
                        FROM NhaPhanPhois as h 
					      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaNhaPhanPhoi ASC)) AS RowNumber, 
                              h.MaNhaPhanPhoi,
							  h.TenNhaPhanPhoi,
							  h.DiaChi,
							  h.SoDienThoai,
							  h.MoTa
                        INTO #Results2
                        FROM NhaPhanPhois as h 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

create proc create_NhaPhanPhoi(
@TenNPP nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	insert into NhaPhanPhois(TenNhaPhanPhoi,DiaChi,SoDienThoai)
	values (@TenNPP,@diachi,@sdt)
end
drop proc update_NhaPhanPhoi

create proc update_NhaPhanPhoi(
@MaNPP int,
@TenNPP nvarchar(50),
@diachi nvarchar(250),
@sdt nvarchar(50))
as
begin
	update NhaPhanPhois
	set TenNhaPhanPhoi=@TenNPP, DiaChi=@diachi, SoDienThoai=@sdt
	where @MaNPP=MaNhaPhanPhoi
end

create proc delete_NPP(@MaNPP int)
as
begin
	delete from NhaPhanPhois where MaNhaPhanPhoi=@MaNPP
end

create proc Get_NhaPhanPhoi
@MaID int
as
begin
select * from NhaPhanPhois as k where k.MaNhaPhanPhoi=@MaID 
end
-----------------------------------------------------------------------------
create PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
                                       @page_size   INT,
									   --@ten_khach Nvarchar(50),
									   --@dia_chi Nvarchar(250),
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKH,
							  k.TenKH,
							  k.DiaChi
                        INTO #Results1
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY TenKH ASC)) AS RowNumber, 
                              k.MaKH,
							  k.TenKH,
							  k.DiaChi
                        INTO #Results2
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.TenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChi like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;

---------------------------------------------------------------Hoa_Don_Nhap-----------------------------------------------------------------

create PROCEDURE sp_hoadonnhap_create
( 
 @MaNhaPhanPhoi int,
 @NgayTao datetime,
 @KieuThanhToan nvarchar(250),
 @MaTaiKhoan int,
 @TongTien decimal(18, 0),
 @list_js_ChitietHDN NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDonNhaps
                ( 
				MaNhaPhanPhoi,
				NgayTao,
				KieuThanhToan,
				MaTaiKhoan,
				TongTien
                )
                VALUES
                (
				 @MaNhaPhanPhoi,
                 @NgayTao, 
                 @KieuThanhToan,
				 @MaTaiKhoan,
				 @TongTien
                );
			
				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
			
                IF(@list_js_ChitietHDN IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDonNhaps
						 (
						 
						  MaSanPham,
						  MaHoaDon,
                          SoLuong, 
						  DonViTinh,
						  GiaNhap,
                          TongTien               
                        )
					SELECT  
							JSON_VALUE(p.value, '$.maSanPham'),
							@MaHoaDon,
                            JSON_VALUE(p.value, '$.soLuong'), 
							JSON_VALUE(p.value, '$.donViTinh'),
							JSON_VALUE(p.value,'$.giaNhap'),
                            JSON_VALUE(p.value, '$.tongTien')    
                    FROM OPENJSON(@list_js_ChitietHDN) AS p;
                END;
        SELECT '';
    END;


create proc HoaDonNhap_Delete(@MaHD int)
as
begin
	delete from HoaDonNhaps where MaHoaDon=@MaHD
end

exec HoaDonNhap_Delete '5'
delete HoaDonNhaps

EXEC sp_hoadonnhap_create
    @MaNhaPhanPhoi = 1,  -- Thay thế giá trị thích hợp
    @NgayTao = '2023-10-08',  -- Thay thế giá trị thích hợp
    @KieuThanhToan = N'Tiền mặt',  -- Thay thế giá trị thích hợp
    @MaTaiKhoan = 1,  -- Thay thế giá trị thích hợp
    @list_js_ChitietHDN = N'[
        {
            "maSanPham": 1,
            "soLuong": 5,
            "donViTinh": "Cái",
            "giaNhap": 1044,
            "tongTien": 52888
        }
        
    ]';  -- Thay thế chuỗi JSON thích hợp


select*from HoaDonNhaps
select*from ChiTietHoaDonNhaps

select*from TaiKhoan
select*from NhaPhanPhois
select*from SanPhams

{
  
  "maNhaPhanPhoi": 1,
  "ngayTao": "2023-11-10T11:54:35.008Z",
  "kieuThanhToan": "Tiền mặt",
  "maTaiKhoan": 1,
  "tongTien": 300000,
  "list_js_ChitietHDN": [
    {
    
      "maSanPham": 110,
      "soLuong": 11,
      "donViTinh": "Cái",
      "giaNhap": 20000,
      "tongTien": 1000
    }
  ]
}
select*from HoaDonNhaps
select*from ChiTietHoaDonNhaps
exec HoaDonNhap_Search '1','20'
create PROCEDURE HoaDonNhap_Search (@page_index  INT, 
                                       @page_size   INT
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaNhaPhanPhoi,
							  h.NgayTao,
							  h.KieuThanhToan,
							  h.MaTaiKhoan,
							  h.TongTien
                        INTO #Results1
                        FROM HoaDonNhaps  h
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaHoaDon ASC)) AS RowNumber, 
                              h.MaHoaDon,
							  h.MaNhaPhanPhoi,
							  h.NgayTao,
							  h.KieuThanhToan,
							  h.MaTaiKhoan,
							  h.TongTien
                        INTO #Results2
                        FROM HoaDonNhaps  h		
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

Create proc Get_List_CTHDN(@MaHD int)
as
	begin
		select 
		from ChiTietHoaDonNhaps c inner join SanPhams s on c.MaSanPham=s.MaSanPham
		where c.MaHoaDon=@MaHD
end

select*from ChiTietHoaDonNhaps
exec Get_List_CTHDN '13'
-------------------------------------chuyenmuc-----------------------------------------
create proc create_chuyen_muc(
@TenChuyenMuc nvarchar(250),
@NoiDung nvarchar(250))
as
begin
	insert into ChuyenMucs(TenChuyenMuc,NoiDung)
	values (@TenChuyenMuc,@NoiDung)
end

select*from ChuyenMucs

create proc Delete_chuyen_muc(
@MaChuyenMuc int
)
as
begin
	delete from ChuyenMucs
	where MaChuyenMuc=@MaChuyenMuc
end

create proc  Update_chuyen_muc(
@MaChuyenMuc int,
@TenChuyenMuc nvarchar(250),
@NoiDung nvarchar(250)
)
as
begin
	update ChuyenMucs
	set TenChuyenMuc=@TenChuyenMuc,
		NoiDung=@NoiDung
	where
		NoiDung=@NoiDung
end

create PROCEDURE Chuyenmuc_search (@page_index  INT, 
                                 @page_size  int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaChuyenMuc ASC)) AS RowNumber, 
                              h.MaChuyenMuc,
							  h.TenChuyenMuc,
							  h.DacBiet,
							  h.NoiDung
							  
                        INTO #Results1
                        FROM ChuyenMucs as h 
					      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaChuyenMuc ASC)) AS RowNumber, 
                              h.MaChuyenMuc,
							  h.TenChuyenMuc,
							  h.DacBiet,
							  h.NoiDung
                        INTO #Results2
                        FROM ChuyenMucs as h 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

--------------------------Size------------------------------------------
select*from Size
create PROCEDURE Size_search (@page_index  INT, 
                                 @page_size  int)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSize ASC)) AS RowNumber, 
                              h.MaSize,
							  h.TenSize,
							  h.Ghichu
                        INTO #Results1
                        FROM Size as h 
					      
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
						SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSize ASC)) AS RowNumber, 
                              h.MaSize,
							  h.TenSize,
							  h.Ghichu
                        INTO #Results2
                        FROM Size as h 
						
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
drop proc Size_search
----------------------SanPham-------------------------------------

create proc Sanpham_getbyID
@MaID nvarchar(30)
as
begin
select * from SanPhams as k where k.MaSanPham=@MaID 
end

SELECT SP.TenSanPham, string_agg(s.MaSize, ',') AS Size, SP.Gia
FROM SanPhams SP inner join Size s on SP.MaSize=s.MaSize
GROUP BY SP.TenSanPham, SP.Gia;

select*from SanPhams
select*from Size


create proc create_San_Pham(

@MaChuyenMuc int,
@Anh nvarchar(250),
@TenSanPham nvarchar(max),
@Gia int,
@SoLuong int,
@MaSize int)
as
begin
	insert into SanPhams(MaChuyenMuc,AnhDaiDien,TenSanPham,Gia,SoLuong,MaSize)
	values (@MaChuyenMuc,@Anh,@TenSanPham,@Gia,@SoLuong,@MaSize)
end

{
  "maChuyenMuc": 1,
  "anhDaiDien" : "xsa",
  "tenSanPham": "vinh",
  "gia": 33,
  "soLuong": 22,
  "size": 1
}


drop proc SanPham_search

create PROCEDURE SanPham_search (@page_index  INT, 
                                       @page_size   INT,
									   @TenCM nvarchar(10),
									   @TenSize nvarchar(10)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
							
                        INTO #Results1
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
					    where
							(@TenCM = '' Or c.TenChuyenMuc like N'%'+@TenCM+'%') and
							(@TenSize = '' Or s.TenSize like N'%'+@TenSize+'%')
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
                        INTO #Results2
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
						where
							(@TenCM = '' Or c.TenChuyenMuc like N'%'+@TenCM+'%') and
							(@TenSize = '' Or s.TenSize like N'%'+@TenSize+'%')
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;



select*from SanPhams

exec SanPham_search '1','10','Áo','XL'

create proc SanPham_Delete(@MaSP nvarchar(50))
as
begin
	delete from SanPhams where MaSanPham=@MaSP
end
{
  "page": "1",
  "pageSize": "5"
}


CREATE PROCEDURE SanPham_Update
(
@MaSP int,
@MaChuyenMuc int,
@Anh nvarchar(max),
@TenSanPham nvarchar(max),
@Gia int,
@SoLuong int,
@MaSize int
)
AS
BEGIN
    UPDATE SanPhams
    SET MaChuyenMuc = @MaChuyenMuc,
        AnhDaiDien = @Anh,
        TenSanPham = @TenSanPham,
        Gia = @Gia,
		SoLuong=@SoLuong,
		MaSize=@MaSize
    WHERE MaSanPham = @MaSP;
END;
drop proc SanPham_Update
select*from SanPhams


-------------------------------------------------Trang_Nguoi_Dung---------------------------------------------------------------------
select*from SanPhams
select*from HoaDonNhaps
select*from ChiTietHoaDonNhaps
select*from HoaDons
select*from ChiTietHoaDons

select  s.MaSanPham,s.TenSanPham,s.AnhDaiDien,s.Gia,count(h.NgayTao) as NgayLapHD
FROM HoaDonNhaps  h
						inner join ChiTietHoaDonNhaps c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 


GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
order by NgayLapHD asc

drop proc User_New_Products

exec User_New_Products '1','10'

create PROCEDURE User_New_Products (@page_index  INT, 
                                       @page_size   INT
									   --@fr_NgayTao datetime, 
									   --@to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results1
                        FROM HoaDonNhaps  h
						inner join ChiTietHoaDonNhaps c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 
					 --   WHERE  						
						--((@fr_NgayTao IS NULL
      --                  AND @to_NgayTao IS NULL)
      --                  OR (@fr_NgayTao IS NOT NULL
      --                      AND @to_NgayTao IS NULL
      --                      AND h.NgayTao >= @fr_NgayTao)
      --                  OR (@fr_NgayTao IS NULL
      --                      AND @to_NgayTao IS NOT NULL
      --                      AND h.NgayTao <= @to_NgayTao)
      --                  OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))       
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results2
                        FROM HoaDonNhaps  h
						inner join ChiTietHoaDonNhaps c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 
					 --   WHERE  					
						--((@fr_NgayTao IS NULL
      --                  AND @to_NgayTao IS NULL)
      --                  OR (@fr_NgayTao IS NOT NULL
      --                      AND @to_NgayTao IS NULL
      --                      AND h.NgayTao >= @fr_NgayTao)
      --                  OR (@fr_NgayTao IS NULL
      --                      AND @to_NgayTao IS NOT NULL
      --                      AND h.NgayTao <= @to_NgayTao)
      --                  OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;





DELETE FROM HoaDons

drop proc User_Selling_Products

exec User_Selling_Products '1','6'

create PROCEDURE User_Selling_Products (@page_index  INT, 
                                       @page_size   INT		   
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT (ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS SoLuongBan,
							  s.Gia
                        INTO #Results1
                        FROM SanPhams  s
						inner join ChiTietHoaDons c on s.MaSanPham= c.MaSanPham
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia
						
					
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT (ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS SoLuongBan,
							  s.Gia
                        INTO #Results2
                        FROM SanPhams  s
						inner join ChiTietHoaDons c on s.MaSanPham= c.MaSanPham
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia

					
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;


create PROCEDURE User_Hot_Product (@page_index  INT, 
                                       @page_size   INT,
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))       
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  s.Gia,
							  h.NgayTao
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
					    WHERE  					
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR (h.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
----------------------------------------------------------------------------------------------------------------------------------------------------
select*from SanPhams
select*from ChuyenMucs

drop proc User_SP_Search_ChuyenMuc

CREATE PROCEDURE User_SP_Search_ChuyenMuc (
    @page_index INT, 
    @page_size INT,
    @MaCM INT
)
AS
BEGIN
    DECLARE @RecordCount BIGINT;

    IF (@page_size <> 0)
    BEGIN
        SET NOCOUNT ON;

        -- Sử dụng ROW_NUMBER() để chọn bản ghi duy nhất cho mỗi TenSanPham và lấy dữ liệu vào bảng tạm #Results1
        SELECT *
        INTO #Results1
        FROM (
            SELECT ROW_NUMBER() OVER(PARTITION BY TenSanPham ORDER BY TenSanPham) AS RowNumber,
                   s.MaSanPham,
                   s.MaChuyenMuc,
                   s.TenSanPham,
                   s.Gia,
                   s.AnhDaiDien
            FROM SanPhams s
            WHERE @MaCM = s.MaChuyenMuc
        ) AS SubQuery
        WHERE RowNumber = 1;

        -- Đếm số lượng bản ghi duy nhất
        SELECT @RecordCount = COUNT(*)
        FROM #Results1;

        -- Lấy dữ liệu duy nhất kèm theo số lượng bản ghi và vị trí trang
        SELECT *, 
               @RecordCount AS RecordCount
        FROM #Results1
        WHERE RowNumber BETWEEN (@page_index - 1) * @page_size + 1 AND ((@page_index - 1) * @page_size + 1) + @page_size - 1
              OR @page_index = -1;

        DROP TABLE #Results1; 
    END;
    -- Xử lý ELSE ở đây nếu cần
END;
{
  "page": "1",
  "pageSize": "10",
  "MaChuyenMuc": "2"
}
select*from ChuyenMucs
exec User_SP_Search_ChuyenMuc '1','10',4

drop proc Get_all_Size

select*from SanPhams
exec Get_all_Size '1','10', N'Áo sơ mi 1'



create PROCEDURE Get_all_Size (@page_index  INT, 
                                       @page_size   INT,
									   @ten_SP Nvarchar(50)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY sz.TenSize ASC)) AS RowNumber, 
							  s.MaSize,
							  sz.TenSize
							  
                        INTO #Results1
                        FROM SanPhams  s
						inner join Size sz on s.MaSize = sz.MaSize
					    WHERE  (@ten_SP = '' Or s.TenSanPham like N'%'+@ten_SP+'%') 					
						          
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY sz.TenSize ASC)) AS RowNumber, 
							  s.MaSize,
							  sz.TenSize
							
                        INTO #Results2
                        FROM SanPhams  s
						inner join Size sz on s.MaSize = sz.MaSize
					    WHERE  (@ten_SP = '' Or s.TenSanPham like N'%'+@ten_SP+'%') 	
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;
-----------------------------------------------------GioHang------------------------------------------------------

select*from KhachHang 
select*from TaiKhoan
select*from SanPhams
create proc create_gio_hang(
@MaTaiKhoan int,
@MaSanPham int)
as
begin
	insert into GioHang(MaTaiKhoan,MaSanPham)
	values (@MaTaiKhoan,@MaSanPham)
end

create proc Get_all_GioHang
as
begin
	select*from GioHang
end


create proc delete_giohang
as
begin
	delete from GioHang 
end
exec Get_all_GioHang
------------------------------------------SearchSP_theoSize-------------------------------------------------------------------
select*from SanPhams
select*from Size
exec Search_sp_TheoSize N'Áo sơ mi 1', '3'
drop proc Search_sp_TheoSize


alter proc Search_sp_TheoSize( @TenSP nvarchar(250),
									   @MaSize int)
as
begin
	select s.MaSanPham,s.MaChuyenMuc,s.TenSanPham,s.AnhDaiDien,s.Gia,s.SoLuong,s.MaSize,sz.TenSize
	from SanPhams s inner join Size sz on s.MaSize=sz.MaSize 
	where ( @TenSP = '' Or s.TenSanPham like N'%'+ @TenSP+'%') and
							(@MaSize = s.MaSize)
end 
select*from SanPhams

	exec USer_SanPham_search '1','12',N'Áo','',0,100000
{
  "page": "1",
  "pageSize": "5",
  "TenSanPham": "Áo sơ mi",
  "TenSize":"M",
  "MinPrice":1,
  "MaxPrice":100000
}
drop proc USer_SanPham_search

alter PROCEDURE USer_SanPham_search (@page_index  INT, 
                                       @page_size   INT,
									   @TenSP nvarchar(250),
									   @TenSize nvarchar(10),
									   @MinPrice int,
									   @MaxPrice int
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
							
                        INTO #Results1
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
					    where
							(@TenSP = '' Or h.TenSanPham like N'%'+@TenSP+'%') and
							(@TenSize = '' Or s.TenSize like N'%'+@TenSize+'%') 
							and	(@MinPrice =0  or h.Gia >= @MinPrice)
							and(@MaxPrice =0  or h.Gia <= @MaxPrice)
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.MaSanPham ASC)) AS RowNumber, 
                              h.MaSanPham,
							  h.MaChuyenMuc,
							  c.TenChuyenMuc,
							  h.TenSanPham,
							  h.AnhDaiDien,
							  h.MaSize,
							  s.TenSize,
							  h.Gia,
							  h.SoLuong
                        INTO #Results2
                        FROM SanPhams  h
						inner join ChuyenMucs c on c.MaChuyenMuc = h.MaChuyenMuc
						inner join Size s on s.MaSize = h.MaSize
						 where
							(@TenSP = '' Or h.TenSanPham like N'%'+@TenSP+'%') and
							(@TenSize = '' Or s.TenSize like N'%'+@TenSize+'%') 
							and	(@MinPrice =0  or h.Gia >= @MinPrice)
							and(@MaxPrice =0  or h.Gia <= @MaxPrice)
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

--------------------------------------DatHang-----------------------------------------------------------------
select*from KhachHang
select*from HoaDons
select*from ChiTietHoaDons
select*from SanPhams
select*from Size
delete KhachHang
delete HoaDons
delete ChiTietHoaDons
--create proc Search_MaKH( @TenKH nvarchar(250),@DiaChi nvarchar(250),@SDT nvarchar(11))
--as
--begin
--	select*
--	from KhachHang k 
--	where k.TenKH=@TenKH and k.DiaChi=@DiaChi and k.SDT=@SDT
--end 
--exec Search_MaKH 'a','a','a'
--select*from SanPhams

select*from ChuyenMucs
select s.MaSanPham
from SanPhams s
where s.MaChuyenMuc=4

CREATE PROCEDURE sp_create_KhachHang_va_HoaDon (
    @TenKH NVARCHAR(50),
    @diachi NVARCHAR(250),
    @sdt NVARCHAR(50),
    @TrangThai BIT,
    @NgayTao DATETIME,
    @DiaChiGiaoHang NVARCHAR(250),
    @TongGia FLOAT,
    @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @MaKH INT;

    -- Tạo khách hàng mới và lưu mã khách hàng vào @MaKH
    INSERT INTO KhachHang (TenKH, DiaChi, SDT)
    VALUES (@TenKH, @diachi, @sdt);

    -- Lấy MaKH của khách hàng vừa tạo
    SET @MaKH = SCOPE_IDENTITY();

    -- Tạo hóa đơn bán với mã khách hàng vừa tạo
    INSERT INTO HoaDons (TrangThai, NgayTao, TongGia, DiaChiGiaoHang, MaKH)
    VALUES (@TrangThai, @NgayTao, @TongGia, @DiaChiGiaoHang, @MaKH);

    DECLARE @MaHoaDon INT;
    SET @MaHoaDon = SCOPE_IDENTITY();

    -- Thêm các chi tiết hóa đơn
    IF (@list_json_chitiethoadon IS NOT NULL)
    BEGIN
        INSERT INTO ChiTietHoaDons (MaSanPham, MaHoaDon, SoLuong, TongGia, GiamGia)
        SELECT JSON_VALUE(p.value, '$.maSanPham'), @MaHoaDon, JSON_VALUE(p.value, '$.soLuong'), JSON_VALUE(p.value, '$.tongGia'), JSON_VALUE(p.value, '$.giamGia')
        FROM OPENJSON(@list_json_chitiethoadon) AS p;
    END;

    SELECT @MaKH AS 'MaKH', @MaHoaDon AS 'MaHoaDon'; -- Trả về MaKH và MaHoaDon
END;

{

  "tenKH": "Vũ Đình Vinh",
  "diaChi": "Hải Dương",
  "sdt": "0865087460",
 
  "trangThai": true,
  "ngayTao": "2023-11-27T10:21:09.515Z",
  "diaChiGiaoHang": "Hải Dương",
  "tongGia": 100000,
  "list_json_ChiTietHD": [
    {
	
    
      "maSanPham": 110,
      "soLuong": 5,
      "tongGia": 100000,
      "giamGia": "string",
      "status": 0
    }
  ]
}
---------------------------------------------------------Admin_ThongKe---------------------------------------------------------------------
select*from TaiKhoan
select*from LoaiTaiKhoan
select*from ChiTietTaiKhoan

select*from SanPhams
select*from KhachHang

select*from HoaDons
select*from ChiTietHoaDons
exec [sp_thong_ke_khachhang] '1','100','','2023/11/26','2023/12/01'

{
  "page": "1",
  "pageSize": "10",
  "TenKhach": "",
  "fr_NgayTao":"2023/11/29",
  "to_NgayTao":"2023/11/30"
}
alter PROCEDURE [dbo].[sp_thong_ke_khachhang] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  kh.TenKH,
							  kh.Diachi
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham 
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') and						
							h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao);             
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  c.SoLuong,
							  c.TongGia,
							  h.NgayTao,
							  kh.TenKH,
							  kh.Diachi
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
						inner join KhachHang kh on h.MaKH=kh.MaKH
					    WHERE  (@ten_khach = '' Or kh.TenKH like N'%'+@ten_khach+'%') and						
						h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao);
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

select*from HoaDons
select*from ChiTietHoaDons
exec ThongKeDoanhThu '2023/11/29','2023/12/01'
alter PROCEDURE ThongKeDoanhThu
    @from_Ngay DATETIME,
    @to_Ngay DATETIME
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        --N'Tổng' AS Ngay,
        COUNT( h.MaHoaDon) AS SoDonHang,
        SUM(h.TongGia) AS DoanhThu,
		sum(c.SoLuong) as SoLuongSP
    FROM 
        HoaDons h inner join ChiTietHoaDons c on h.MaHoaDon=c.MaHoaDon
    WHERE 
         h.NgayTao >= @from_Ngay AND h.NgayTao <= DATEADD(day, 1, @to_Ngay);
END;
select*from HoaDons
select*from ChiTietHoaDons

exec Admin_Selling_Products '1','10','2023-11-29','2023-12-01'

alter PROCEDURE Admin_Selling_Products (@page_index  INT, 
                                       @page_size   INT,
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
						      s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							  sz.TenSize,
							  s.Gia,
							  h.NgayTao
							 
                        INTO #Results1
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
						inner join Size sz on s.MaSize=sz.MaSize
					    WHERE  						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao))  
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao,sz.TenSize
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY SUM(c.SoLuong) DESC)) AS RowNumber, 
                              s.MaSanPham,
							  s.TenSanPham,
							  s.AnhDaiDien,
							  SUM(c.SoLuong) AS TongSoLuong,
							   sz.TenSize,
							  s.Gia,
							  h.NgayTao
                        INTO #Results2
                        FROM HoaDons  h
						inner join ChiTietHoaDons c on c.MaHoaDon = h.MaHoaDon
						inner join SanPhams s on s.MaSanPham = c.MaSanPham
						inner join Size sz on s.MaSize=sz.MaSize
					    WHERE  					
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND h.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND h.NgayTao <= @to_NgayTao)
                        OR h.NgayTao >= @fr_NgayTao AND h.NgayTao <= DATEADD(day, 1, @to_NgayTao))
						GROUP BY s.MaSanPham, s.TenSanPham, s.AnhDaiDien, s.Gia, h.NgayTao,sz.TenSize
						SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

{
  "page": "1",
  "pageSize": "10",
  "fr_NgayTao": "2023/11/29",
  "to_NgayTao": "2023/12/01"
}