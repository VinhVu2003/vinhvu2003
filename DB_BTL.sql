create database BTL_API_BLBH
go 
use BTL_API_BLBH
go
create table LoaiTaiKhoan(
MaLoai int identity(1,1) primary key,
TenLoai nvarchar(50),
Mota nvarchar(250)
)

CREATE TABLE TaiKhoan(
	MaTaiKhoan int IDENTITY(1,1) primary key,
	LoaiTaiKhoan int foreign key references LoaiTaiKhoan(MaLoai) on delete cascade on update cascade,
	TenTaiKhoan nvarchar(50),
	MatKhau nvarchar(50) ,
	Email nvarchar(150),
)
CREATE TABLE [dbo].[ChiTietTaiKhoan](
	[MaChitietTaiKhoan] [int] IDENTITY(1,1) primary key,
	[MaTaiKhoan] [int] foreign key references TaiKhoan(MaTaiKhoan) on delete cascade on update cascade,
	[HoTen] [nvarchar](50) ,
	[DiaChi] [nvarchar](250),
	[SoDienThoai] [nvarchar](11) ,
	[AnhDaiDien] [nvarchar](500) ,
)



CREATE TABLE [dbo].[NhaPhanPhois](
	[MaNhaPhanPhoi] [int] IDENTITY(1,1) primary key,
	[TenNhaPhanPhoi] [nvarchar](250) ,
	[DiaChi] [nvarchar](max) ,
	[SoDienThoai] [nvarchar](50) ,
	[MoTa] [nvarchar](max) ,
)

CREATE TABLE [dbo].[ChuyenMucs](
	[MaChuyenMuc] [int] IDENTITY(1,1) primary key,
	--[MaChuyenMucCha] [int] ,
	[TenChuyenMuc] [nvarchar](50) ,
	[DacBiet] [bit] ,
	[NoiDung] [nvarchar](max) ,
)

CREATE TABLE [dbo].[SanPhams](
	[MaSanPham] [int] IDENTITY(1,1) primary key ,
	[MaChuyenMuc] [int] foreign key references [ChuyenMucs]([MaChuyenMuc]) on delete cascade on update cascade,
	[TenSanPham] [nvarchar](150) ,
	[AnhDaiDien] [nvarchar](350) ,
	[Gia] [decimal](18, 0) ,
	[GiaGiam] [decimal](18, 0) ,
	[SoLuong] [int] ,
	[TrangThai] [bit] ,
	[LuotXem] [int] ,
	[DacBiet] [bit] ,
	MaSize int foreign key references Size(MaSize) on delete cascade on update cascade;
)


CREATE TABLE [dbo].[SanPhams_NhaPhanPhois](
	[MaSanPham] [int] foreign key references [SanPhams]([MaSanPham]) on delete cascade on update cascade ,
	[MaNhaPhanPhoi] [int] foreign key references [NhaPhanPhois]([MaNhaPhanPhoi]) on delete cascade on update cascade,
	constraint FK_CTDHN primary key ([MaSanPham],[MaNhaPhanPhoi])
)


CREATE TABLE [dbo].[HoaDonNhaps](
	[MaHoaDon] [int] IDENTITY(1,1) primary key ,
	[MaNhaPhanPhoi] [int] foreign key references [NhaPhanPhois]([MaNhaPhanPhoi]) on delete cascade on update cascade ,
	[NgayTao] [datetime] ,
	[KieuThanhToan] [nvarchar](max) ,
)
alter table HoaDonNhaps add MaTaiKhoan int foreign key references TaiKhoan(MaTaiKhoan) on delete cascade on update cascade;


CREATE TABLE [dbo].[ChiTietHoaDonNhaps](
	[Id] [int] IDENTITY(1,1)  primary key,
	[MaHoaDon] [int] foreign key references [HoaDonNhaps]([MaHoaDon]) on delete cascade on update cascade,
	[MaSanPham] [int] foreign key references [SanPhams]([MaSanPham]) on delete cascade on update cascade,
	[SoLuong] [int] ,
	[DonViTinh] [nvarchar](50) ,
	[GiaNhap] [decimal](18, 0) ,
	[TongTien] [decimal](18, 0) 
)

CREATE TABLE [dbo].[HoaDons](
	[MaHoaDon] [int] IDENTITY(1,1) primary key ,
	[TrangThai] [bit] ,
	[NgayTao] [datetime] ,
	[NgayDuyet] [datetime] ,
	[TongGia] [decimal](18, 0) ,
	[DiaChiGiaoHang] [nvarchar](350) ,
	[ThoiGianGiaoHang] [datetime] ,
)

CREATE TABLE [dbo].[ChiTietHoaDons](
	[MaChiTietHoaDon] [int] IDENTITY(1,1) primary key ,
	[MaHoaDon] [int] foreign key references [HoaDons]([MaHoaDon]) on delete cascade on update cascade ,
	[MaSanPham] [int] foreign key references [SanPhams]([MaSanPham]) on delete cascade on update cascade ,
	[SoLuong] [int] ,
	[TongGia] [decimal](18, 0) 
)

create table KhachHang(
MaKH int identity(1,1) primary key,
TenKH nvarchar(50) ,
DiaChi nvarchar(50),
SDT char(10) 
)


select*from SanPhams
create table Size(
MaSize int identity(1,1) primary key,
TenSize nvarchar(250),
Ghichu nvarchar(250)
)

ALTER TABLE HoaDonNhaps
ADD TongTien decimal(18, 0)


select*from SanPhams
select*from HoaDonNhaps
Select*from ChiTietHoaDonNhaps

select*from HoaDons
select*from ChiTietHoaDons

ALTER TABLE HoaDons
DROP COLUMN NgayDuyet	

create table GioHang(
MaGH int identity(1,1) primary key,
MaTaiKhoan int foreign key references TaiKhoan(MaTaiKhoan) on delete cascade on update cascade,
[MaSanPham] [int] foreign key references [SanPhams]([MaSanPham]) on delete cascade on update cascade
)