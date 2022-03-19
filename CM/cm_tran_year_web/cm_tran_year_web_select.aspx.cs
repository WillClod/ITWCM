using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CM.cm_tran_year_web
{
    public partial class cm_tran_year_web : System.Web.UI.Page
    {
        int vciHideCount = 0;

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
            // Set Variables.
            vciHideCount = 0;

            // If create page.
            if (!IsPostBack)
            {
                // Set var.
                int vliYear = DateTime.Today.Year;

                // Fill year combo.
                cmbYear.Items.Clear();
                ListItem vlolistItem;

                vliYear--;
                vlolistItem = new ListItem();
                vlolistItem.Text = vliYear.ToString();
                vlolistItem.Value = vliYear.ToString();
                cmbYear.Items.Insert(0, vlolistItem);

                vliYear++;
                vlolistItem = new ListItem();
                vlolistItem.Text = vliYear.ToString();
                vlolistItem.Value = vliYear.ToString();
                cmbYear.Items.Insert(1, vlolistItem);

                vliYear++;
                vlolistItem = new ListItem();
                vlolistItem.Text = vliYear.ToString();
                vlolistItem.Value = vliYear.ToString();
                cmbYear.Items.Insert(2, vlolistItem);

                // Set filter default.
                cmbYear.SelectedIndex = 1;

                // Bind data grids.
                pcvListYearTransactions(Convert.ToInt16(cmbYear.Text), Convert.ToDecimal(txtStartAmt.Text), cmbTranType.SelectedValue);
                //GridViewMain.Columns["Tipo"].Frozen = true;
                //GridView2.Columns["Tipo"].Frozen = true;
            }

        }

        void pcvListYearTransactions(int vpiYear, decimal vpdStartAmt, string vpsTranType)
        {
            DateTime vldFirstDay = new DateTime(vpiYear, 1, 1);
            DateTime vldLastDay = new DateTime(vpiYear, 12, 31);

            // Filter.
            srcCMTranTypeYearHeader.SelectParameters["year"].DefaultValue = vpiYear.ToString();
            srcCMTranTypeYearHeader.SelectParameters["start_amt"].DefaultValue = vpdStartAmt.ToString();
            srcCMTranTypeYearHeader.SelectParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue;
            GridView2.DataBind();

            // Filter.
            srcCMTranTypeYear.SelectParameters["from_apply_date"].DefaultValue = vldFirstDay.ToString();
            srcCMTranTypeYear.SelectParameters["to_apply_date"].DefaultValue = vldLastDay.ToString();
            srcCMTranTypeYear.SelectParameters["post_flag"].DefaultValue = false.ToString();
            srcCMTranTypeYear.SelectParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue;
            gvwMain.DataBind();
        }

        protected void FormView1_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {

        }

        protected void gvwMain_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }


        protected void gvwMain_DataBound(object sender, EventArgs e)
        {
            // Set Variables.
            HiddenField hdnTranType;
            HiddenField hdnRangeType;
            int vliMonth = 1;
            int vliDay = 1;
            int vliYear = Convert.ToInt16(cmbYear.Text);
            cm_tran_year_web_detail _cm_tran_year_web_detail;

            DateTime vldFirstDay = DateTime.MinValue;  
            DateTime vldLastDay = DateTime.MinValue;


            foreach (GridViewRow gvRow in gvwMain.Rows)
            {
                for (int i = 1; i < gvRow.Cells.Count; i++)
                {
                    // Get control cell.
                    hdnTranType = (HiddenField) gvRow.FindControl("hdnTranType" + i.ToString());
                    hdnRangeType = (HiddenField)gvRow.FindControl("hdnRangeType" + i.ToString());

                    vliMonth = Convert.ToInt16(hdnRangeType.Value.Substring(1, 2));
                    vliDay = Convert.ToInt16(hdnRangeType.Value.Substring(4, 2));

                    vldFirstDay = new DateTime(vliYear, vliMonth, vliDay);
                    vldLastDay = fcdGetLastDay(vldFirstDay, 15);

                    _cm_tran_year_web_detail = (cm_tran_year_web_detail)gvRow.FindControl("cm_tran_year_web_detail" + i.ToString());
                    _cm_tran_year_web_detail.vcdFirstDay = vldFirstDay;
                    _cm_tran_year_web_detail.vcdLastDay = vldLastDay;
                    _cm_tran_year_web_detail.vcbPostFlag = false;
                    _cm_tran_year_web_detail.vcdTrantype = hdnTranType.Value;
                    _cm_tran_year_web_detail.Idx = 0;
                }

            }

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

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // If count row hide columns with out transactions.
            if ((e.Row.RowType == DataControlRowType.DataRow) && (e.Row.RowIndex == 0))
            {
                // Set Variables.
                HiddenField hdnRangeType;
                vciHideCount = 0;
                for (int i = 1; i < e.Row.Cells.Count; i++)
                {
                    // Get cell control .
                    hdnRangeType = (HiddenField)e.Row.FindControl("hdnRangeType" + (24 + i).ToString());

                    // Hide colmns with out transactions.
                    ///
                    /*
                    if (hdnRangeType.Value == "0.00")
                    {
                        vciHideCount++;
                        GridView1.Columns[i].Visible = false;
                        GridView2.Columns[i].Visible = false;
                    }
                    */

                }

            }

            // Set records displayed.
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                // Set Variables.
                HiddenField hdnRangeType;
                Label lblRangeType;
                for (int i = 1; i < e.Row.Cells.Count; i++)
                {
                    // Get cell control .
                    hdnRangeType = (HiddenField)e.Row.FindControl("hdnRangeType" + (24 + i).ToString());
                    lblRangeType = (Label)e.Row.FindControl("lblRangeType" + (24 + i).ToString());

                    // Color negative as red.
                    if (Convert.ToDecimal(hdnRangeType.Value) < 0)
                    {
                        lblRangeType.ForeColor = System.Drawing.Color.Red;
                    }

                    // If end amont row...
                    if (e.Row.RowIndex == 4)
                    {
                        lblRangeType.Font.Bold = true;
                    }

                }

            }
        }

        protected void GridView2_DataBound(object sender, EventArgs e)
        {
            // Adjust grid width.
            gvwMain.Width = 200 + (24 - vciHideCount) * 200;
            GridView2.Width = gvwMain.Width;

            // Hide count row.
            GridView2.Rows[0].Visible = false;
        }

        protected void cmbYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Bind data grids.
            pcvListYearTransactions(Convert.ToInt16(cmbYear.Text), Convert.ToDecimal(txtStartAmt.Text), cmbTranType.SelectedValue);
        }

        protected void txtStartAmt_TextChanged(object sender, EventArgs e)
        {
            // Bind data grids.
            pcvListYearTransactions(Convert.ToInt16(cmbYear.Text), Convert.ToDecimal(txtStartAmt.Text), cmbTranType.SelectedValue);
        }

        protected void cmbTranType_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Bind data grids.
            pcvListYearTransactions(Convert.ToInt16(cmbYear.Text), Convert.ToDecimal(txtStartAmt.Text), cmbTranType.SelectedValue);
        }

        protected void cmbTranType_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "Todos";
            listItem.Value = "*";
            cmbTranType.Items.Insert(0, listItem);
        }

        protected void gvwMain_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


    }
}