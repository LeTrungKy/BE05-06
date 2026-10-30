using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using BE05_06.Models;
using BE05_06.Models.ViewModel;
using PagedList;
using BE05_06.Filters;

namespace BE05_06.Areas.Admin.Controllers
{
    [AdminAuthorize]
    public class ProductsController : Controller
    {
        private MyStoreEntities db = new MyStoreEntities();

        public ActionResult Index(string searchTerm, decimal? minPrice, decimal? maxPrice, string sortOrder, int? page)
        {
            var model = new ProductSearchVM
            {
                SearchTerm = searchTerm,
                MinPrice = minPrice,
                MaxPrice = maxPrice,
                SortOrder = sortOrder,
                PageNumber = page ?? 1,
                PageSize = 5
            };

            var products = db.Products.Include(p => p.Category).AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                model.SearchTerm = searchTerm;
                products = products.Where(p => p.ProductName.Contains(searchTerm)
                                            || p.ProductDescription.Contains(searchTerm)
                                            || p.Category.CategoryName.Contains(searchTerm));
            }

            if (minPrice.HasValue)
            {
                model.MinPrice = minPrice;
                products = products.Where(p => p.ProductPrice >= minPrice.Value);
            }
            if (maxPrice.HasValue)
            {
                model.MaxPrice = maxPrice;
                products = products.Where(p => p.ProductPrice <= maxPrice.Value);
            }

            model.SortOrder = sortOrder;
            switch (sortOrder)
            {
                case "name_asc":
                    products = products.OrderBy(p => p.ProductName);
                    break;
                case "name_desc":
                    products = products.OrderByDescending(p => p.ProductName);
                    break;
                case "price_asc":
                    products = products.OrderBy(p => p.ProductPrice);
                    break;
                case "price_desc":
                    products = products.OrderByDescending(p => p.ProductPrice);
                    break;
                default:
                    products = products.OrderBy(p => p.ProductID);
                    break;
            }

            model.Products = products.ToPagedList(model.PageNumber, model.PageSize);

            return View(model);
        }

        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProductID,CategoryID,ProductName,ProductDescription,ProductPrice,ProductImage,UploadImg")] Product product)
        {
            ValidateImage(product);

            if (ModelState.IsValid)
            {

                if (string.IsNullOrEmpty(product.ProductImage))
                {
                    product.ProductImage = "~/Content/images/default_img.png";
                }

                SaveImage(product);
                db.Products.Add(product);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            return View(product);
        }

        public ActionResult Edit(int? id)
        {

            ActionResult result = Details(id);
            ViewResult viewResult = result as ViewResult;
            if (viewResult != null)
            {
                Product product = (Product)viewResult.Model;
                ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            }
            return result;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProductID,CategoryID,ProductName,ProductDescription,ProductPrice,ProductImage,UploadImg")] Product product)
        {
            ValidateImage(product);

            if (ModelState.IsValid)
            {
                SaveImage(product);
                db.Entry(product).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", product.CategoryID);
            return View(product);
        }

        public ActionResult Delete(int? id)
        {
            return Details(id);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            try
            {
                db.Products.Remove(product);
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                ModelState.AddModelError("", "Không thể xóa sản phẩm này vì đã có trong đơn hàng.");
                return View("Delete", product);
            }
            return RedirectToAction("Index");
        }

        private void ValidateImage(Product product)
        {
            if (product.UploadImg != null && product.UploadImg.ContentLength > 0)
            {
                string ext = Path.GetExtension(product.UploadImg.FileName).ToLower();
                if (ext != ".png" && ext != ".jpg" && ext != ".jpeg" && ext != ".gif")
                {
                    ModelState.AddModelError("UploadImg", "Chỉ chấp nhận các định dạng ảnh PNG, JPG và GIF");
                }
            }
        }

        private void SaveImage(Product product)
        {
            if (product.UploadImg != null && product.UploadImg.ContentLength > 0)
            {
                string filename = Path.GetFileName(product.UploadImg.FileName);
                string savePath = "~/Content/images/";
                product.ProductImage = savePath + filename;
                product.UploadImg.SaveAs(Path.Combine(Server.MapPath(savePath), filename));
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}