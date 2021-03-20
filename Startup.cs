using System;
using app.Models;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace app {
    public class Startup {
        private IConfiguration _configuration;
        public Startup (IWebHostEnvironment env) {
            _configuration = new ConfigurationBuilder ()
                .SetBasePath (env.ContentRootPath)
                .AddJsonFile ("appsettings.json", optional : true, reloadOnChange : true)
                .AddJsonFile ($"appsettings.{env.EnvironmentName}.json", optional : true)
                .AddUserSecrets<Startup>()
                .AddEnvironmentVariables()
                .Build ();
        }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices (IServiceCollection services) {
            foreach (var configurationEntry in _configuration.AsEnumerable ()) {
                Console.WriteLine ("Found config key '" + configurationEntry.Key + "' with value '" + configurationEntry.Value + "'");
            }
            if (_configuration["ConnectionStrings:AspNetCoreOnSqlServerConnectionString"] == null) {
                throw new Exception ("Missing database connection string: AspNetCoreOnSqlServerConnectionString");
            }
            Console.WriteLine ("Using database connection: " + _configuration.GetConnectionString ("AspNetCoreOnSqlServerConnectionString"));

            services.AddDbContext<masterContext> (options =>
                options.UseSqlServer (
                    _configuration.GetConnectionString ("AspNetCoreOnSqlServerConnectionString")));
            services.AddDefaultIdentity<IdentityUser> (options => options.SignIn.RequireConfirmedAccount = true)
                .AddEntityFrameworkStores<masterContext> ();
            services.AddControllersWithViews ();
            services.AddMvc ();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure (IApplicationBuilder app, IWebHostEnvironment env) {
            if (env.IsDevelopment ()) {
                app.UseDeveloperExceptionPage ();
                app.UseMigrationsEndPoint ();
            } else {
                app.UseExceptionHandler ("/Home/Error");
                app.UseHsts ();
            }
            app.UseHttpsRedirection ();
            app.UseStaticFiles ();

            app.UseRouting ();

            app.UseAuthentication ();
            app.UseAuthorization ();

            app.UseEndpoints (endpoints => {
                endpoints.MapControllerRoute (
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
                endpoints.MapRazorPages ();
            });
        }
    }
}