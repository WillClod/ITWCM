using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;     // For set Culture.
using System.Globalization; // For set Culture.
using System.Data;

namespace CM.cm_tran
{
    public partial class cm_tran_select : System.Web.UI.Page
    {
        double vcdTotalAmt = 0.0;

        protected void Page_Load(object sender, EventArgs e)
        {

            // Set culture.
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("es-Mx");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-MX");


            // If create page.
            if (!IsPostBack)
            {
                // Set default values.
                DateTime vldDate = DateTime.Today;
                hdnDate.Value = vldDate.ToString();

                hdnDateClass.Value = "15";

                /*
                if (Request.QueryString["DocDate"] != null)
                    vldDate = Convert.ToDateTime(Request.QueryString["DocDate"].ToString());
                else
                    vldDate = DateTime.Today;
                */
                /*
                if (Session["cm_tran_mobil_select.ApplyDate"] != null)
                    vldDate = Convert.ToDateTime(Session["cm_tran_mobil_select.ApplyDate"].ToString());
                */

                // Restore filters saved.
                pcvRestoreFilters();

                // Set date.
                vldDate = Convert.ToDateTime(hdnDate.Value);
                txtDate.Text = vldDate.ToString("ddd dd/MMM/yyyy");

                pcvSetPostFlag(Convert.ToBoolean(hdnPostFlag.Value));
                pcvSetPastFlag(Convert.ToBoolean(hdnPastFlag.Value));
                if (cmbTranType.SelectedValue != "*")
                    pcvSetTranType(cmbTranType.SelectedValue);

                // List Transactions. 
                pcvListTransactions(fcdSetDateClass(Convert.ToInt16(hdnDateClass.Value)));
            }
            else
            {
                if (Request.Form["__EVENTTARGET"] == "DateSelected")
                {
                    txtDate.Text = Request.Form["__EVENTARGUMENT"];
                    DateTime vldDate = Convert.ToDateTime(txtDate.Text);

                    vldDate = fcdGetFirstDay(vldDate, Convert.ToInt16(hdnDateClass.Value));
                    txtDate.Text = vldDate.ToString("ddd dd/MMM/yyyy");

                    hdnDate.Value = vldDate.ToString();

                    pcvListTransactions(vldDate);
                }

            }
        }

        protected void btnExpense_Click(object sender, ImageClickEventArgs e)
        {
            // Save Filters.
            pcvSaveFilters();

            // Load page to add new record.
            Server.Transfer("cm_tran_mobil_entry.aspx?TranID=0&TranClass=13110&DocDate=" + hdnDate.Value);
        }

        protected void btnTransfer_Click(object sender, ImageClickEventArgs e)
        {
            // Save Filters.
            pcvSaveFilters();

            // Load page to add new record.
            Server.Transfer("cm_tran_mobil_entry.aspx?TranID=0&TranClass=13010&DocDate=" + hdnDate.Value);
        }

        protected void btnRevenue_Click(object sender, ImageClickEventArgs e)
        {
            // Save Filters.
            pcvSaveFilters();

            // Load page to add new record.
            Server.Transfer("cm_tran_mobil_entry.aspx?TranID=0&TranClass=13210&DocDate=" + hdnDate.Value);
        }

        protected void btnPriorDay_Click(object sender, ImageClickEventArgs e)
        {
            // Get actual date.
            DateTime vldDate = Convert.ToDateTime(hdnDate.Value);

            // Get for prior date.
            DateTime vldFirstDay = DateTime.MinValue;
            vldFirstDay = fcdGetFirstDay(vldDate, Convert.ToInt16(hdnDateClass.Value));
            vldDate = vldFirstDay.AddDays(-1);
            vldDate = fcdGetFirstDay(vldDate, Convert.ToInt16(hdnDateClass.Value));

            // Search for prior date.
            hdnDate.Value = vldDate.ToString();
            txtDate.Text = vldDate.ToString("ddd dd/MMM/yyyy");
            pcvListTransactions(vldDate);

        }

        protected void btnNextDay_Click(object sender, ImageClickEventArgs e)
        {
            // Get actual date.
            DateTime vldDate = Convert.ToDateTime(hdnDate.Value);

            // Get next date.
            DateTime vldLastDay = DateTime.MinValue;
            vldLastDay = fcdGetLastDay(vldDate, Convert.ToInt16(hdnDateClass.Value));
            vldDate = vldLastDay.AddDays(1);

            // Search for next date.
            hdnDate.Value = vldDate.ToString();
            txtDate.Text = vldDate.ToString("ddd dd/MMM/yyyy");
            pcvListTransactions(vldDate);
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                // Load page to edit record.
                HiddenField hdnTranID = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnTranID");
                HiddenField hdnTranClass = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnTranClass");
               
                // Save Filters.
                pcvSaveFilters();

                // Show entry page.
                Server.Transfer("cm_tran_mobil_entry.aspx?TranID=" + hdnTranID.Value + "&TranClass=" + hdnTranClass.Value + "&DocDate=" + hdnDate.Value);
            }

            if (e.CommandName == "TranType")
            {
                // Filter by tran type.
                Label lblTranTypeDescFilter = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblTranTypeDesc");
                HiddenField hdnTranTypeFilter = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnTranType");

                pcvSetTranType(hdnTranTypeFilter.Value);

                DateTime vldDate = Convert.ToDateTime(hdnDate.Value);
                pcvListTransactions(vldDate);

            }

            if (e.CommandName == "Discount")
            {
                Image imgDet = (Image)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgDet");
                HiddenField hdnTranClass = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnTranClass");
                HiddenField hdnDiscountFlag = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnDiscountFlag");
                HiddenField hdnApplyDate = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnApplyDate");
                HiddenField hdnDocDate = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnDocDate");
                HiddenField hdnTranType = (HiddenField)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("hdnTranType");
                DateTime vpdApplyDate = Convert.ToDateTime(hdnApplyDate.Value);
                DateTime vpdDocDate = Convert.ToDateTime(hdnDocDate.Value);

                Label lblTranTypeDesc = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblTranTypeDesc");
                Label lblApplyDate = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblApplyDate");
                Label lblDocDate = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblDocDate");
                Label lblTranDesc = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblTranDesc");
                Label lblCashAcctDescr = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblCashAcctDescr");
                Label lblTranAmt = (Label)GridView1.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblTranAmt");

                double vldTotalAmt = Convert.ToDouble(lblTotalAmt.Text);

                if (hdnDiscountFlag.Value == "0")
                { 
                    if (hdnTranClass.Value == "13110") imgDet.ImageUrl = "~/Images/ExpenseIconDIS.png";
                    if (hdnTranClass.Value == "13010") imgDet.ImageUrl = "~/Images/RevenueIconDIS.png";
                    if (hdnTranClass.Value == "13210") imgDet.ImageUrl = "~/Images/TransferIconDIS.png";
                    vldTotalAmt -= Convert.ToDouble(lblTranAmt.Text);
                    hdnDiscountFlag.Value = "1";
                    lblTranTypeDesc.Font.Bold = false;
                    lblApplyDate.Font.Bold = false;
                    lblTranAmt.Font.Bold = false;
                    if (GridView1.Rows[Convert.ToInt32(e.CommandArgument)].BackColor == System.Drawing.Color.Silver)
                    {
                        lblTranTypeDesc.ForeColor = System.Drawing.Color.Gray;
                        lblApplyDate.ForeColor = System.Drawing.Color.Gray;
                        lblDocDate.ForeColor = System.Drawing.Color.Gray;
                        lblTranDesc.ForeColor = System.Drawing.Color.Gray;
                        lblCashAcctDescr.ForeColor = System.Drawing.Color.Gray;
                        lblTranAmt.ForeColor = System.Drawing.Color.Gray;
                    }
                    else
                    {
                        lblTranTypeDesc.ForeColor = System.Drawing.Color.Silver;
                        lblApplyDate.ForeColor = System.Drawing.Color.Silver;
                        lblDocDate.ForeColor = System.Drawing.Color.Silver;
                        lblTranDesc.ForeColor = System.Drawing.Color.Silver;
                        lblCashAcctDescr.ForeColor = System.Drawing.Color.Silver;
                        lblTranAmt.ForeColor = System.Drawing.Color.Silver;
                    }
                }
                else
                {
                    if (hdnTranClass.Value == "13110") imgDet.ImageUrl = "~/Images/ExpenseIcon.png";
                    if (hdnTranClass.Value == "13010") imgDet.ImageUrl = "~/Images/RevenueIcon.png";
                    if (hdnTranClass.Value == "13210") imgDet.ImageUrl = "~/Images/TransferIcon.png";
                    vldTotalAmt += Convert.ToDouble(lblTranAmt.Text);
                    hdnDiscountFlag.Value = "0";

                    lblTranTypeDesc.Font.Bold = true;
                    lblApplyDate.Font.Bold = true;
                    lblTranAmt.Font.Bold = true;

                    if (GridView1.Rows[Convert.ToInt32(e.CommandArgument)].BackColor == System.Drawing.Color.Silver)
                        lblDocDate.ForeColor = System.Drawing.Color.Black;
                    else
                        lblDocDate.ForeColor = System.Drawing.Color.Silver;

                    lblTranTypeDesc.ForeColor = System.Drawing.Color.Black;
                    lblApplyDate.ForeColor = System.Drawing.Color.Black;
                    
                    lblTranDesc.ForeColor = System.Drawing.Color.Black;
                    lblCashAcctDescr.ForeColor = System.Drawing.Color.Black;
                    lblTranAmt.ForeColor = System.Drawing.Color.Black;

                }

                lblTotalAmt.Text = vldTotalAmt.ToString();

                if (fcbIsDueDate(vpdApplyDate)) lblApplyDate.ForeColor = System.Drawing.Color.Red;
                if (fcbIsDueDate(vpdDocDate)) lblDocDate.ForeColor = System.Drawing.Color.Red;

                //GridView1.Rows[Convert.ToInt32(e.CommandArgument)].BackColor = System.Drawing.Color.Yellow; 

                String vlsImageTrantype = "~/Images/cmtrantype/" + hdnTranType.Value + ".png";
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(vlsImageTrantype)))
                {
                    imgDet.ImageUrl = vlsImageTrantype;
                }

            }
        }



        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {                
                // Get controls.
                Image imgDet = (Image)e.Row.FindControl("imgDet");
                Image imgStar = (Image)e.Row.FindControl("imgStar");
                Image imgNote = (Image)e.Row.FindControl("imgNote");
                Label lblTranTypeDesc = (Label)e.Row.FindControl("lblTranTypeDesc");
                Label lblApplyDate = (Label)e.Row.FindControl("lblApplyDate");
                Label lblDocDate = (Label)e.Row.FindControl("lblDocDate");

                Label lblTranDesc = (Label)e.Row.FindControl("lblTranDesc");
                Label lblCashAcctDescr = (Label)e.Row.FindControl("lblCashAcctDescr");
                Label lblTranAmt = (Label)e.Row.FindControl("lblTranAmt");
                HiddenField hdnTranClass = (HiddenField)e.Row.FindControl("hdnTranClass");
                HiddenField hdnSeverityClass = (HiddenField)e.Row.FindControl("hdnSeverityClass");
                HiddenField hdnApplyDate = (HiddenField)e.Row.FindControl("hdnApplyDate");
                HiddenField hdnDocDate = (HiddenField)e.Row.FindControl("hdnDocDate");
                HiddenField hdnStarFlag = (HiddenField)e.Row.FindControl("hdnStarFlag");
                HiddenField hdnHoldReason = (HiddenField)e.Row.FindControl("hdnHoldReason");
                HiddenField hdnTranType = (HiddenField)e.Row.FindControl("hdnTranType");
                DateTime vpdApplyDate = Convert.ToDateTime(hdnApplyDate.Value);
                DateTime vpdDocDate = Convert.ToDateTime(hdnDocDate.Value);


                // Set controls.
                if (hdnTranClass.Value == "13110") imgDet.ImageUrl = "~/Images/ExpenseIcon.png";
                if (hdnTranClass.Value == "13010") imgDet.ImageUrl = "~/Images/RevenueIcon.png";
                if (hdnTranClass.Value == "13210") imgDet.ImageUrl = "~/Images/TransferIcon.png";

                //e.Row.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.DataItemIndex, true);
                imgDet.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "Discount$" + e.Row.DataItemIndex, true);

                lblTranTypeDesc.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "TranType$" + e.Row.DataItemIndex, true);
                lblApplyDate.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.DataItemIndex, true);
                lblTranDesc.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.DataItemIndex, true);
                lblCashAcctDescr.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.DataItemIndex, true);
                lblTranAmt.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(GridView1, "Select$" + e.Row.DataItemIndex, true);

                DateTime vldDate = Convert.ToDateTime(hdnDate.Value);

                vcdTotalAmt = vcdTotalAmt + Convert.ToDouble(lblTranAmt.Text);

                if (hdnSeverityClass.Value == "1") e.Row.BackColor = System.Drawing.Color.Yellow;
                if (hdnSeverityClass.Value == "3")
                {
                    e.Row.BackColor = System.Drawing.Color.Silver;
                    lblDocDate.ForeColor = System.Drawing.Color.Black;
                }

                if (fcbIsDueDate(vpdApplyDate)) lblApplyDate.ForeColor = System.Drawing.Color.Red;
                if (fcbIsDueDate(vpdDocDate)) lblDocDate.ForeColor = System.Drawing.Color.Red;

                //if (hdnStarFlag.Value == "False") imgStar.ImageUrl = "";
                if (hdnStarFlag.Value == "False") imgStar.ImageUrl = "~/Images/1616_Blank.png";

                if (hdnHoldReason.Value == "") imgNote.ImageUrl = "~/Images/1616_Blank.png";  
                imgNote.ToolTip = hdnHoldReason.Value;

                String vlsImageTrantype = "~/Images/cmtrantype/" + hdnTranType.Value + ".png";
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(vlsImageTrantype)))
                {
                    imgDet.ImageUrl = vlsImageTrantype;
                }

            }

        }


        void pcvListTransactions(DateTime vpdDate)
        {

            // Set Variables.
            DateTime vldFirstDay = DateTime.MinValue;
            DateTime vldLastDay = DateTime.MinValue;

            // Get record data.
            
            if (!Convert.ToBoolean(hdnPastFlag.Value))
            {
                vldFirstDay = fcdGetFirstDay(vpdDate, Convert.ToInt16(hdnDateClass.Value));
                vldLastDay = fcdGetLastDay(vpdDate, Convert.ToInt16(hdnDateClass.Value));
                srcCMTranBatchRange.SelectParameters["from_apply_date"].DefaultValue = vldFirstDay.ToString();
                srcCMTranBatchRange.SelectParameters["to_apply_date"].DefaultValue = vldLastDay.ToString();
                srcCMTranBatchRange.SelectParameters["post_flag"].DefaultValue = hdnPostFlag.Value;
                srcCMTranBatchRange.SelectParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue;                
                GridView1.DataSourceID = srcCMTranBatchRange.ID;
            }
            else
            {
                vldLastDay = fcdGetLastDay(vpdDate, Convert.ToInt16(hdnDateClass.Value));
                srcCMTranBatchToDate.SelectParameters["apply_date"].DefaultValue = vldLastDay.ToString();
                srcCMTranBatchToDate.SelectParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue;
                GridView1.DataSourceID = srcCMTranBatchToDate.ID;
            }

            vcdTotalAmt = 0.0; 
            GridView1.DataBind();
            lblTotalAmt.Text = vcdTotalAmt.ToString();
        }

        protected void chbPostFlag_CheckedChanged(object sender, EventArgs e)
        {
            DateTime vldDate = Convert.ToDateTime(txtDate.Text);
            pcvListTransactions(vldDate);
        }

        DateTime fcdGetFirstDay(DateTime vpdDay, int vpiDateType)
        {
            // Set Variables.
            DateTime vldFirstDay = DateTime.MinValue;

            // Get first day of Date Type selected.
            switch (vpiDateType)
            {
                case 1: // Day.
                    vldFirstDay = vpdDay;
                    break;

                case 7: // Week.
                    Double vldDayOfWeek = Convert.ToDouble(vpdDay.DayOfWeek);
                    if (vldDayOfWeek == 0) vldDayOfWeek = 7;
                    vldFirstDay = vpdDay.AddDays(1 - vldDayOfWeek);
                    break;

                case 15: // Fortnite.

                    if (vpdDay.Day <= 15)
                        vldFirstDay = new DateTime(vpdDay.Year, vpdDay.Month, 1);
                    else
                        vldFirstDay = new DateTime(vpdDay.Year, vpdDay.Month, 16);

                    break;

                case 30: // Month.
                    vldFirstDay = new DateTime(vpdDay.Year, vpdDay.Month, 1);
                    break;

                case 365: // Year.
                    vldFirstDay = new DateTime(vpdDay.Year, 1, 1);
                    break;
            }

            return vldFirstDay;
        }

        DateTime fcdGetLastDay(DateTime vpdDay, int vpiDateType)
        {
            // Set Variables.
            DateTime vldFirstDay = DateTime.MinValue;
            DateTime vldLastDay = DateTime.MinValue;


            // Get last day depending Data Range.
            switch (vpiDateType)
            {
                case 1: // Day.
                    vldLastDay = vpdDay;
                    break;

                case 7: // Week.
                    Double vldDayOfWeek = Convert.ToDouble(vpdDay.DayOfWeek);
                    if (vldDayOfWeek == 0) vldDayOfWeek = 7;
                    vldFirstDay = vpdDay.AddDays(1 - vldDayOfWeek);
                    vldLastDay = vldFirstDay.AddDays(6);
                    break;

                case 15: // Fortnite.

                    if (vpdDay.Day <= 15)
                        vldLastDay = new DateTime(vpdDay.Year, vpdDay.Month, 15);
                    else
                    {
                        if (vpdDay.Month < 12)
                            vldLastDay = new DateTime(vpdDay.Year, vpdDay.Month + 1, 1);
                        else
                            vldLastDay = new DateTime(vpdDay.Year + 1, 1, 1);

                        vldLastDay = vldLastDay.AddDays(-1);
                    }

                    break;

                case 30: // Month.

                    if (vpdDay.Month < 12)
                        vldLastDay = new DateTime(vpdDay.Year, vpdDay.Month + 1, 1);
                    else
                        vldLastDay = new DateTime(vpdDay.Year + 1, 1, 1);

                    vldLastDay = vldLastDay.AddDays(-1);

                    break;

                case 365: // Month.

                    vldLastDay = new DateTime(vpdDay.Year, 12, 31);

                    break;
            }

            return vldLastDay;
        }

        protected void cmbDateType_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Set Variables.
            DateTime vldDate = Convert.ToDateTime(txtDate.Text);
            DateTime vldFirstDay = DateTime.MinValue;

            // Get first day of Date Type selected.
            vldFirstDay = fcdGetFirstDay(vldDate, Convert.ToInt16(hdnDateClass.Value));

            // Change date.
            hdnDate.Value = vldFirstDay.ToString();
            txtDate.Text = vldFirstDay.ToString("ddd dd/MMM/yyyy");

            pcvListTransactions(vldFirstDay);

        }
        bool fcbIsDueDate(DateTime vpdDay)
        {
            //DateTime vldStartDate = Convert.ToDateTime(txtDate.Text);
            DateTime vldStartDate = Convert.ToDateTime(hdnDate.Value);

            if (vpdDay < DateTime.Today) return true;
            if (vpdDay < vldStartDate) return true;

            return false;
        }

        protected void btnDay_Click(object sender, ImageClickEventArgs e)
        {
            // Grid databind.
            pcvListTransactions(fcdSetDateClass(1));
        }

        protected void btnWeek_Click(object sender, ImageClickEventArgs e)
        {
            // Grid databind.
            pcvListTransactions(fcdSetDateClass(7));

        }

        protected void btnFornite_Click(object sender, ImageClickEventArgs e)
        {
            // Grid databind.
            pcvListTransactions(fcdSetDateClass(15));
        }

        protected void btnMonth_Click(object sender, ImageClickEventArgs e)
        {
            // Grid databind.
            pcvListTransactions(fcdSetDateClass(30));
        }

        protected void btnPost_Click(object sender, ImageClickEventArgs e)
        {
            pcvSetPostFlag(!Convert.ToBoolean(hdnPostFlag.Value));

            DateTime vldDate = Convert.ToDateTime(txtDate.Text);

            pcvListTransactions(vldDate);
        }

        protected void btnPast_Click(object sender, ImageClickEventArgs e)
        {
            pcvSetPastFlag(!Convert.ToBoolean(hdnPastFlag.Value));

            DateTime vldDate = Convert.ToDateTime(txtDate.Text);

            pcvListTransactions(vldDate);
        }

        protected void btnYear_Click(object sender, ImageClickEventArgs e)
        {
            // Grid databind.            
            pcvListTransactions(fcdSetDateClass(365));
        }

        protected void btnTrantTypeCancel_Click(object sender, ImageClickEventArgs e)
        {
            DateTime vldDate = DateTime.Today;
            cmbTranType.SelectedValue = "*";
        
            cmbTranType.Visible = false;
            btnYear.Visible = false;
            btnTrantTypeCancel.Visible = false;

            if (hdnDateClass.Value == "365")
            {
                hdnDateClass.Value = "30";
                btnMonth.ImageUrl = "~/Images/CalendarMonth48.png";
                btnYear.ImageUrl = "~/Images/CalendarYear48_Disable.png";
                
                DateTime vldFirstDay = DateTime.MinValue;
                vldFirstDay = fcdGetFirstDay(vldDate, Convert.ToInt16(hdnDateClass.Value));
                hdnDate.Value = vldFirstDay.ToString();
                txtDate.Text = vldFirstDay.ToString("ddd dd/MMM/yyyy");
            }

            vldDate = Convert.ToDateTime(hdnDate.Value);
            pcvListTransactions(vldDate);
        }

        protected void cmbTranType_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "Todos";
            listItem.Value = "*";
            cmbTranType.Items.Insert(0, listItem);
        }

        protected void cmbTranType_SelectedIndexChanged(object sender, EventArgs e)
        {
            DateTime vldDate = Convert.ToDateTime(hdnDate.Value);
            pcvListTransactions(vldDate);
        }

        void pcvSaveFilters()
        {
            Session["cm_tran_mobil_select.ApplyDate"] = hdnDate.Value;
            Session["cm_tran_mobil_select.DateClass"] = hdnDateClass.Value;
            Session["cm_tran_mobil_select.PostFlag"] = hdnPostFlag.Value;
            Session["cm_tran_mobil_select.PastFlag"] = hdnPastFlag.Value;
            Session["cm_tran_mobil_select.TranType"] = cmbTranType.SelectedValue;
            
        }

        void pcvRestoreFilters()
        {
            if (Session["cm_tran_mobil_select.ApplyDate"] != null)
                hdnDate.Value = Session["cm_tran_mobil_select.ApplyDate"].ToString();

            if (Session["cm_tran_mobil_select.DateClass"] != null)
                hdnDateClass.Value = Session["cm_tran_mobil_select.DateClass"].ToString();

            if (Session["cm_tran_mobil_select.PostFlag"] != null)
                hdnPostFlag.Value = Session["cm_tran_mobil_select.PostFlag"].ToString();

            if (Session["cm_tran_mobil_select.PastFlag"] != null)
                hdnPastFlag.Value = Session["cm_tran_mobil_select.PastFlag"].ToString();

            if (Session["cm_tran_mobil_select.TranType"] != null)
                cmbTranType.SelectedValue = Session["cm_tran_mobil_select.TranType"].ToString();
        }

        DateTime fcdSetDateClass(int vpiDateClass)
        {
            // Set default values.
            DateTime vldDate = DateTime.Today;
            DateTime vldFirstDay = DateTime.MinValue;

            // Disable all dates.
            btnDay.ImageUrl = "~/Images/CalendarDay48_Disable.png";
            btnWeek.ImageUrl = "~/Images/CalendarWeek48_Disable.png";
            btnFornite.ImageUrl = "~/Images/CalendarFornite48_Disable.png";
            btnMonth.ImageUrl = "~/Images/CalendarMonth48_Disable.png";
            btnYear.ImageUrl = "~/Images/CalendarYear48_Disable.png";

            // Enable defined date.
            switch (vpiDateClass)
            {
                case 1: // Day.
                    btnDay.ImageUrl = "~/Images/CalendarDay48.png";
                    break;

                case 7: // Week.
                    // Enable image selected.
                    btnWeek.ImageUrl = "~/Images/CalendarWeek48.png";
                    break;

                case 15: // Fortnite.
                    btnFornite.ImageUrl = "~/Images/CalendarFornite48.png";
                    break;

                case 30: // Month.
                    btnMonth.ImageUrl = "~/Images/CalendarMonth48.png";
                    break;

                case 365: // Month.
                    btnYear.ImageUrl = "~/Images/CalendarYear48.png";
                    break;
            }

            // Set Variables.
            hdnDateClass.Value = vpiDateClass.ToString();

            // Get first day of Date Type selected.
            vldFirstDay = fcdGetFirstDay(vldDate, Convert.ToInt16(hdnDateClass.Value));

            // Change date.
            hdnDate.Value = vldFirstDay.ToString();
            txtDate.Text = vldFirstDay.ToString("ddd dd/MMM/yyyy");

            // Return date.
            return vldFirstDay;
        }

        void pcvSetPostFlag(bool vpbPostFlag)
        {
            if (!vpbPostFlag)
            {
                hdnPostFlag.Value = "false";
                btnPostFlag.ImageUrl = "~/Images/Post48_Disable.png";

                btnPastFlag.Visible = true;

                hdnPastFlag.Value = "true";
                btnPastFlag.ImageUrl = "~/Images/Past48.png";

            }
            else
            {
                hdnPostFlag.Value = "true";
                btnPostFlag.ImageUrl = "~/Images/Post48.png";

                btnPastFlag.Visible = false;

                hdnPastFlag.Value = "false";
                btnPastFlag.ImageUrl = "~/Images/Past48_Disable.png";
            }
        }

        void pcvSetPastFlag(bool vpbPastFlag)
        {
            if (!vpbPastFlag)
            {
                hdnPastFlag.Value = "false";
                btnPastFlag.ImageUrl = "~/Images/Past48_Disable.png";
            }
            else
            {
                hdnPastFlag.Value = "true";
                btnPastFlag.ImageUrl = "~/Images/Past48.png";
            }
        }

        void pcvSetTranType(string vpsTranType)
        {
            cmbTranType.DataBind();

            cmbTranType.SelectedValue = vpsTranType;

            cmbTranType.Visible = true;

            btnYear.Visible = true;
            btnTrantTypeCancel.Visible = true;
        }

        }
    }