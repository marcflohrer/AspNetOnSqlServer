using System;
using Microsoft.AspNetCore.Identity;

namespace app
{
    public class ApplicationUser : IdentityUser<Guid>
    {
        public string CustomTag { get; set; }
    }
}