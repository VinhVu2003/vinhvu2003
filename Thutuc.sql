DBCC CHECKIDENT ('SanPhams', RESEED)
-----------------------------------------
create proc KH_get_by_id
@MaID nvarchar(30)
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
exec KH_get_by_id '1'
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
create PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @dia_chi Nvarchar(250),

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

{
  "page": "1",
  "pageSize": "1",
  "ten_khach": "Vinh"
  "dia_chi": "string"
}
----------------Hoa DOn Ban---------------------------------------
select*from HoaDons
select*from ChiTietHoaDons
create PROCEDURE sp_hoadon_create
(@TenKH              NVARCHAR(50), 
 @Diachi          NVARCHAR(250), 
 @TrangThai         bit,  
 @NgayTao datetime,
 @SDT nvarchar(10),
 @DiaChiGiaoHang nvarchar(250),
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDons
                ( TenKH,
				DiaChi,
				TrangThai,
				NgayTao,
				SDT,
				DiaChiGiaoHang
                )
                VALUES
                (@TenKH, 
                 @Diachi, 
                 @TrangThai,
				 @NgayTao,
				 @SDT,
				 @DiaChiGiaoHang
                );

				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadon IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDons
						 (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia               
                        )
                    SELECT JSON_VALUE(p.value, '$.maSanPham'), 
                            @MaHoaDon, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.tongGia')    
                    FROM OPENJSON(@list_json_chitiethoadon) AS p;
                END;
        SELECT '';
    END;

{
  
  "tenKH": "Vinh",
  "diaChi": "HD",
  "trangThai": true,
  "ngayTao": "2023-10-03T15:34:17.361Z",
  "sdt": "0123456789",
  "diaChiGiaoHang": "HD",
  "list_json_ChiTietHD": [
    { 
      "maSanPham": 1,
      "soLuong": 1,
      "tongGia": 315000,
      "status": 1
    }
  ]
}
------------------------------------
create PROCEDURE [dbo].[sp_hoa_don_update]
(@MaHoaDon        int, 
 @TenKH              NVARCHAR(50), 
 @Diachi          NVARCHAR(250), 
 @TrangThai         bit,  
 @NgayTao datetime,
 @SDT nvarchar(10),
 @DiaChiGiaoHang nvarchar(250),
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDons
		SET
			TenKH  = @TenKH ,
			Diachi = @Diachi,
			TrangThai = @TrangThai,
			NgayTao=@NgayTao,
			SDT=@SDT,
			DiaChiGiaoHang=@DiaChiGiaoHang
			
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
			  JSON_VALUE(p.value, '$.status') AS status 
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitiethoadon) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDons (MaSanPham, 
						  MaHoaDon,
                          SoLuong, 
                          TongGia ) 
			   SELECT
				  #Results.maSanPham,
				  @MaHoaDon,
				  #Results.soLuong,
				  #Results.tongGia			 
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDons 
			  SET
				 SoLuong = #Results.soLuong,
				 TongGia = #Results.tongGia
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
select*from HoaDons,ChiTietHoaDons
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

---------------------------Hoa_Don_Nhap-----------------------------------------------------------------

create PROCEDURE sp_hoadonnhap_create
( 
 @MaNhaPhanPhoi int,
 @NgayTao datetime,
 @KieuThanhToan nvarchar(250),
 @MaTaiKhoan int,
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
				MaTaiKhoan
                )
                VALUES
                (
				 @MaNhaPhanPhoi,
                 @NgayTao, 
                 @KieuThanhToan,
				 @MaTaiKhoan
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
drop PROCEDURE sp_hoadonnhap_create

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
select*from HoaDons
select*from TaiKhoan
select*from NhaPhanPhois
select*from SanPhams

{
  "maNhaPhanPhoi": 1,
  "ngayTao": "2023-10-08T13:36:33.438Z",
  "kieuThanhToan": "thẻ",
  "maTaiKhoan": 1,
  "list_js_ChitietHDN": [	
    {
      "maSanPham": 1,
      "soLuong": 22,
      "donViTinh": "chiec",
      "giaNhap": 222,
      "tongTien": 222
    }
  ]
}
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

SELECT SP.TenSanPham, STRING_AGG(Size, ', ') AS Size, SP.Gia
FROM SanPhams SP
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

exec SanPham_search '1','10',

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

create proc Thoi_Trang_Moi_Nhat
(

)
as
begin
	select top(6) s.TenSanPham,s.Gia,s.AnhDaiDien
	from SanPhams s inner join ChiTietHoaDonNhaps c on s.MaSanPham=c.MaSanPham
	inner join HoaDonNhaps h on h.MaHoaDon=c.MaHoaDon
end;


