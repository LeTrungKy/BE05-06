using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace BE05_06.Filters
{
    public static class AdminAuth
    {
        public const string Role = "A";

        public const string SessionKey = "AdminUser";
    }

    public class AdminAuthorizeAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session[AdminAuth.SessionKey] == null)
            {
                string returnUrl = filterContext.HttpContext.Request.RawUrl;
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new
                    {
                        area = "Admin",
                        controller = "Auth",
                        action = "Login",
                        returnUrl = returnUrl
                    }));
            }
        }
    }
}
