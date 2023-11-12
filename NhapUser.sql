exec User_Ao_Nam_Search '1','10','Áo khoác',''
drop proc User_Ao_Nam_Search
create PROCEDURE User_Ao_Nam_Search (@page_index  INT, 
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

select s.MaSanPham,s.TenSanPham,s.MaSize
from SanPhams as s
group by s.MaSanPham,s.TenSanPham,s.MaSize