using BLL.Interfaces;
using BLL;
using DAL.Interfaces;
using DAL;
using DataAccessLayer;
using BusinessLogicLayer;

var builder = WebApplication.CreateBuilder(args);


builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

// Add services to the container.
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();

builder.Services.AddTransient<ISanPhamRepository, SanPhamRepository>();
builder.Services.AddTransient<ISanPhamBUS, SanPhamBUS>();
builder.Services.AddTransient<IHoaDonBanRepository, HoaDonBanRepository>();
builder.Services.AddTransient<IHoaDonBanBUS, HoaDonBanBUS>();

builder.Services.AddTransient<IDatHangRepository, DatHangRepository>();
builder.Services.AddTransient<IDatHangBusiness, DatHangBusiness>();



builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseRouting();
app.UseCors(x => x
    .AllowAnyOrigin()
    .AllowAnyMethod()
    .AllowAnyHeader());

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();


