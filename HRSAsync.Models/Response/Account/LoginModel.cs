using System.ComponentModel.DataAnnotations;

namespace HRSAsync.Models.Response.Account
{
    public class LoginModel
    {
        [Required]
        [EmailAddress(ErrorMessage = "Invalid email!")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Enter the password!")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Remember me")]
        public bool RememberMe { get; set; }
    }
}