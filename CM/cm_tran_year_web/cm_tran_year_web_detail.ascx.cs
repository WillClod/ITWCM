using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CM.cm_tran_year_web
{
    public partial class cm_tran_year_web_detail : System.Web.UI.UserControl, INotifyPropertyChanged
    {
        public DateTime vcdFirstDay { get; set; }
        public DateTime vcdLastDay { get; set; }
        public string vcdTrantype { get; set; }

        public bool vcbPostFlag { get; set; }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChenged(string propName)
        {
            if (string.IsNullOrEmpty(propName) && PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(propName));
            }

            srcCMTranBatchRange.SelectParameters["from_apply_date"].DefaultValue = vcdFirstDay.ToString();
            srcCMTranBatchRange.SelectParameters["to_apply_date"].DefaultValue = vcdLastDay.ToString();
            srcCMTranBatchRange.SelectParameters["post_flag"].DefaultValue = vcbPostFlag.ToString();
            srcCMTranBatchRange.SelectParameters["tran_type"].DefaultValue = vcdTrantype;
            srcCMTranBatchRange.DataBind();

        }

        private int _Idx;

        public int Idx
        {
            get { return _Idx; }
            set
            {
                _Idx = value;
                OnPropertyChenged("Idx");
            }
        }


        public void pcvAlert(string vpsMessage)
        {
            // Cleans the message to allow single quotation marks. 
            string vlsCleanMessage = vpsMessage.Replace("'", " ");
            vlsCleanMessage = vlsCleanMessage.Replace("\n", "\\n");
            vlsCleanMessage = vlsCleanMessage.Replace("\r", "\\r");
            string vlsScript = "<script language=JavaScript>alert('" + vpsMessage + "');</script>";

            // Gets the executing web page. 
            Page page = HttpContext.Current.CurrentHandler as Page;

            // Checks if the handler is a Page and that the script isn't allready on the Page. 
            if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('" + vlsCleanMessage + "');", true);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Set values.
            if (vcdTrantype == "") vcdTrantype = "*";

            // Filter.
            srcCMTranBatchRange.SelectParameters["from_apply_date"].DefaultValue = vcdFirstDay.ToString();
            srcCMTranBatchRange.SelectParameters["to_apply_date"].DefaultValue = vcdLastDay.ToString();
            srcCMTranBatchRange.SelectParameters["post_flag"].DefaultValue = vcbPostFlag.ToString();
            srcCMTranBatchRange.SelectParameters["tran_type"].DefaultValue = vcdTrantype;
        }


        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                // Get controls.
                Image imgDet = (Image)e.Row.FindControl("imgDet");
                Image imgStar = (Image)e.Row.FindControl("imgStar");
                Image imgNote = (Image)e.Row.FindControl("imgNote");
                Label lblApplyDate = (Label)e.Row.FindControl("lblApplyDate");

                Label lblTranDesc = (Label)e.Row.FindControl("lblTranDesc");
                Label lblTranAmt = (Label)e.Row.FindControl("lblTranAmt");
                HiddenField hdnTranClass = (HiddenField)e.Row.FindControl("hdnTranClass");
                HiddenField hdnSeverityClass = (HiddenField)e.Row.FindControl("hdnSeverityClass");
                HiddenField hdnApplyDate = (HiddenField)e.Row.FindControl("hdnApplyDate");
                HiddenField hdnDocDate = (HiddenField)e.Row.FindControl("hdnDocDate");
                HiddenField hdnStarFlag = (HiddenField)e.Row.FindControl("hdnStarFlag");
                HiddenField hdnHoldReason = (HiddenField)e.Row.FindControl("hdnHoldReason");
                HiddenField hdnTranTypeDesc = (HiddenField)e.Row.FindControl("hdnTranTypeDesc");
                HiddenField hdnTranType = (HiddenField)e.Row.FindControl("hdnTranType");
                HiddenField hdnCashAcctDescr = (HiddenField)e.Row.FindControl("hdnCashAcctDescr");
                HiddenField hdnTranAmt = (HiddenField)e.Row.FindControl("hdnTranAmt");

                DateTime vpdApplyDate = Convert.ToDateTime(hdnApplyDate.Value);


                // Set controls.
                if (hdnTranClass.Value == "13110") imgDet.ImageUrl = "~/Images/ExpenseIcon.png";
                if (hdnTranClass.Value == "13010") imgDet.ImageUrl = "~/Images/RevenueIcon.png";
                if (hdnTranClass.Value == "13210") imgDet.ImageUrl = "~/Images/TransferIcon.png";

                if (fcbIsDueDate(vpdApplyDate)) lblApplyDate.ForeColor = System.Drawing.Color.Red;

                //if (hdnStarFlag.Value == "False") imgStar.ImageUrl = "";
                if (hdnStarFlag.Value == "False") imgStar.ImageUrl = "~/Images/1616_Blank.png";

                if (hdnHoldReason.Value == "") imgNote.ImageUrl = "~/Images/1616_Blank.png";
                imgNote.ToolTip = hdnHoldReason.Value;

                imgDet.ToolTip = hdnTranTypeDesc.Value;
                lblTranAmt.ToolTip = hdnCashAcctDescr.Value;
                lblApplyDate.ToolTip = hdnDocDate.Value;

                if(lblApplyDate.Text != hdnDocDate.Value)
                    lblApplyDate.Font.Underline = true;

                String vlsImageTrantype = "~/Images/cmtrantype/" + hdnTranType.Value + ".png";
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(vlsImageTrantype)))
                {
                    imgDet.ImageUrl = vlsImageTrantype;
                }

                if(Convert.ToDecimal(hdnTranAmt.Value) < 0)
                {
                    lblTranAmt.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        bool fcbIsDueDate(DateTime vpdDay)
        {
            if (vpdDay < DateTime.Today) return true;

            return false;
        }
    }
}