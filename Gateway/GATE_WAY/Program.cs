using Ocelot.DependencyInjection;
using Ocelot.Middleware;


var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options => 
{
    options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());
});

//1
builder.Configuration.SetBasePath(builder.Environment.ContentRootPath)
                        .AddJsonFile("gateway.json", optional:false, reloadOnChange: true);
// Add services to the container.

builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

//2
builder.Services.AddOcelot();
var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseCors(policy => policy.AllowAnyMethod().AllowAnyHeader().AllowAnyOrigin());

app.UseHttpsRedirection();

app.UseAuthorization();


app.MapControllers();
//3
app.UseOcelot().Wait();
app.Run();