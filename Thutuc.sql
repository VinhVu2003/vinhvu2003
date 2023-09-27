create database BTL_API_BLBH
go 
use BTL_API_BLBH
go

create table LoaiSP(
MaLoai int identity(1,1) primary key,
TenLoai nvarchar(50) 
)

create table NhaCC(
MaNCC int identity(1,1) primary key,
TenNCC nvarchar(50),
Diachi nvarchar(50),
SDT char(10) check(SDT like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

create table KhachHang(
MaKH int identity(1,1) primary key,
TenKH nvarchar(50) ,
DiaChi nvarchar(50),
SDT char(10) 
)

create table SanPham(
MaLoai int foreign key references LoaiSP(MaLoai) on delete cascade on update cascade,
MaSP int identity(1,1) primary key,
TenSP nvarchar(50),
DVTinh nvarchar(50),
SLTon int
)

create table HoaDonNhap(
MaHDN int identity(1,1) primary key,
--MaNV int foreign key references NhanVien(MaNV) on delete cascade on update cascade,
MaNCC int foreign key references NhaCC(MaNCC) on delete cascade on update cascade,
NgayNhap datetime,
GiaNhap float 
)

create table ChiTietHDN(
ID int identity(1,1) primary key,
MaHDN int references HoaDonNhap(MaHDN) on delete cascade,
MaSP int references SanPham(MaSP) on delete cascade,
SLNhap int check(SLNhap > 0),
TongTien float check(TongTien > 0),
)

create table HoaDonBan(
MaHDB int identity(1,1) primary key,
--MaNV int foreign key references NhanVien(MaNV) on delete cascade on update cascade,
TenKH nvarchar(100),
DiaChi nvarchar(100),
NgayBan datetime,
GiaBan float,
TrangThai bit
)
select*from HoaDonBan
alter table HoaDonBan add TenKH nvarchar(100)
drop table HoaDonBan

create table ChiTietHDB(
ID int identity(1,1) primary key,
MaHDB int references HoaDonBan(MaHDB) on delete cascade,
MaSP int references SanPham(MaSP) on delete cascade,
SLBan int check(SLBan > 0),
TongTien float check(TongTien > 0),
)
-----------------------------------------
create proc KH_get_by_id
@MaID nvarchar(30)
as
begin
select * from KhachHang as k where k.MaKH=@MaID 
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

--{
--  "page": "1",
--  "pageSize": "1",
--  "ten_khach": "Vinh"
--  "dia_chi": "string"
--}
-------------------------------------------------------
select*from HoaDonBan
select*from ChiTietHDB
create PROCEDURE sp_hoadon_create
(@TenKH              NVARCHAR(50), 
 @Diachi          NVARCHAR(250), 
 @TrangThai         bit,  
 @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDon INT;
        INSERT INTO HoaDonBan
                ( TenKH,
				DiaChi,
				TrangThai
                )
                VALUES
                (@TenKH, 
                 @Diachi, 
                 @TrangThai
                );

				SET @MaHoaDon = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitiethoadon IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHDB
						 (MaSP, 
						  MaHDB,
                          SLBan, 
                          TongTien               
                        )
                    SELECT JSON_VALUE(p.value, '$.maSanPham'), 
                            @MaHoaDon, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.tongGia')    
                    FROM OPENJSON(@list_json_chitiethoadon) AS p;
                END;
        SELECT '';
    END;
