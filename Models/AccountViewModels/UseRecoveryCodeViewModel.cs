using System.ComponentModel.DataAnnotations;

namespace app.Models.AccountViewModels
{
    public class UseRecoveryCodeViewModel
    {
        [Required]
        public string Code { get; set; }

        public string ReturnUrl { get; set; }
    }
}
