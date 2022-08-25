using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CM.CMTranYear
{
    public partial class CMTranYearListGrp_Desk : System.Web.UI.Page
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

                // Set colors.
                //gvwMain.Rows[0].Cel
                //gvwMain.Rows[0].DefaultCellStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#e9ecef");
                //gvwMain.Rows[0].BackColor = System.Drawing.ColorTranslator.FromHtml("#e9ecef");

                gvwMain.Columns[0].ItemStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#bdd5ea");
                gvwMain.Columns[1].ItemStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#bdd5ea");

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

            /*
            srcCMTranTypeYear.SelectParameters["from_apply_date"].DefaultValue = vldFirstDay.ToString();
            srcCMTranTypeYear.SelectParameters["to_apply_date"].DefaultValue = vldLastDay.ToString();
            srcCMTranTypeYear.SelectParameters["post_flag"].DefaultValue = false.ToString();
            */

            /* 
            srcCMTranBatchYearGroupGet.SelectParameters["year"].DefaultValue = vpiYear.ToString();            
            //srcCMTranBatchYearGroupGet.SelectParameters["tran_group"].DefaultValue = cmbTranType.SelectedValue;
            srcCMTranBatchYearGroupGet.SelectParameters["tran_group"].DefaultValue = "*";
            srcCMTranBatchYearGroupGet.SelectParameters["post_flag"].DefaultValue = "FALSE";
            srcCMTranBatchYearGroupGet.SelectParameters["start_amt"].DefaultValue = vpdStartAmt.ToString();
            */

            /*
            srcCMTranBatchYearTypeGet.SelectParameters["year"].DefaultValue = vpiYear.ToString();
            srcCMTranBatchYearTypeGet.SelectParameters["tran_group"].DefaultValue = "*";
            srcCMTranBatchYearTypeGet.SelectParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue;
            srcCMTranBatchYearTypeGet.SelectParameters["post_flag"].DefaultValue = "FALSE";
            srcCMTranBatchYearTypeGet.SelectParameters["start_amt"].DefaultValue = vpdStartAmt.ToString();
            */

            srcCMTranBatchYearGroupTypeGet.SelectParameters["year"].DefaultValue = vpiYear.ToString();
            srcCMTranBatchYearGroupTypeGet.SelectParameters["tran_group"].DefaultValue = "*";
            //srcCMTranBatchYearGroupTypeGet.SelectParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue;
            srcCMTranBatchYearGroupTypeGet.SelectParameters["post_flag"].DefaultValue = "FALSE";
            srcCMTranBatchYearGroupTypeGet.SelectParameters["start_amt"].DefaultValue = vpdStartAmt.ToString();


            gvwMain.DataBind();

            //gvwMain.Rows[1].BackColor = System.Drawing.ColorTranslator.FromHtml("#e9ecef");

            //*gvwMain.Rows[1].Cells[1].BackColor = System.Drawing.ColorTranslator.FromHtml("#e9ecef");

            //Attributes.CssStyle.Value = "background-color: DarkRed; color: White";


            //gvwMain.Rows[0].Cells.item = System.Drawing.ColorTranslator.FromHtml("#e9ecef");

            // Center


            // Hide Cluumns without.
            /*
            gvwMain.Columns[2].Visible = false;
            gvwMain.Columns[3].Visible = false;
            gvwMain.Columns[4].Visible = false;
            gvwMain.Columns[5].Visible = false;
            gvwMain.Columns[6].Visible = false;
            gvwMain.Columns[7].Visible = false;
            gvwMain.Columns[8].Visible = false;
            gvwMain.Columns[9].Visible = false;
            gvwMain.Columns[10].Visible = false;
            gvwMain.Columns[11].Visible = false;
            gvwMain.Columns[12].Visible = false;
            gvwMain.Columns[13].Visible = false;
            gvwMain.Columns[14].Visible = false;
            gvwMain.Columns[15].Visible = false;
            gvwMain.Columns[16].Visible = false;
            */

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

        protected void gvwMain_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*
            if (e.Row.RowType == DataControlRowType.Header)
                for (int i = 1; i < gvwMain.Columns.Count; i++)
                {
                    e.Row.Cells[i].HorizontalAlign = HorizontalAlign.Center;
                }
            */


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Get controls.
                HiddenField hdnRecordClass = (HiddenField)e.Row.FindControl("hdnRecordClass");
                Image imgIcon = (Image)e.Row.FindControl("imgIcon");
                Label lblRecordCode = (Label)e.Row.FindControl("lblRecordCode");
                Label lblM01D01 = (Label)e.Row.FindControl("lblM01D01");
                Label lblM01D16 = (Label)e.Row.FindControl("lblM01D16");
                Label lblM02D01 = (Label)e.Row.FindControl("lblM02D01");
                Label lblM02D16 = (Label)e.Row.FindControl("lblM02D16");
                Label lblM03D01 = (Label)e.Row.FindControl("lblM03D01");
                Label lblM03D16 = (Label)e.Row.FindControl("lblM03D16");
                Label lblM04D01 = (Label)e.Row.FindControl("lblM04D01");
                Label lblM04D16 = (Label)e.Row.FindControl("lblM04D16");
                Label lblM05D01 = (Label)e.Row.FindControl("lblM05D01");
                Label lblM05D16 = (Label)e.Row.FindControl("lblM05D16");
                Label lblM06D01 = (Label)e.Row.FindControl("lblM06D01");
                Label lblM06D16 = (Label)e.Row.FindControl("lblM06D16");
                Label lblM07D01 = (Label)e.Row.FindControl("lblM07D01");
                Label lblM07D16 = (Label)e.Row.FindControl("lblM07D16");
                Label lblM08D01 = (Label)e.Row.FindControl("lblM08D01");
                Label lblM08D16 = (Label)e.Row.FindControl("lblM08D16");
                Label lblM09D01 = (Label)e.Row.FindControl("lblM09D01");
                Label lblM09D16 = (Label)e.Row.FindControl("lblM09D16");
                Label lblM10D01 = (Label)e.Row.FindControl("lblM10D01");
                Label lblM10D16 = (Label)e.Row.FindControl("lblM10D16");
                Label lblM11D01 = (Label)e.Row.FindControl("lblM11D01");
                Label lblM11D16 = (Label)e.Row.FindControl("lblM11D16");
                Label lblM12D01 = (Label)e.Row.FindControl("lblM12D01");
                Label lblM12D16 = (Label)e.Row.FindControl("lblM12D16");

                // Assign Icon for group
                if (hdnRecordClass.Value == "0") // Summary
                    imgIcon.Visible = false;

                if (hdnRecordClass.Value == "1") // Group
                    imgIcon.Visible = false;
                /*
                {
                    String vlsImageTranGroup = "~/Images/cmtrangroup/" + lblRecordCode.Text + ".png";
                    if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(vlsImageTranGroup)))
                    {
                        imgIcon.ImageUrl = vlsImageTranGroup;
                    }
                    else imgIcon.Visible = false;
                }
                */

                if (hdnRecordClass.Value == "2") // Type
                {
                    String vlsImageTrantype = "~/Images/cmtrantype/" + lblRecordCode.Text + ".png";
                    if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(vlsImageTrantype)))
                    {
                        imgIcon.ImageUrl = vlsImageTrantype;
                    }
                    else imgIcon.Visible = false;
                }
                
                // Set negative format (red). 
                if (hdnRecordClass.Value == "0")
                { 
                    if (lblM01D01.Text != "") if (Convert.ToDecimal(lblM01D01.Text) < 0) lblM01D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM01D16.Text != "") if (Convert.ToDecimal(lblM01D16.Text) < 0) lblM01D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM02D01.Text != "") if (Convert.ToDecimal(lblM02D01.Text) < 0) lblM02D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM02D16.Text != "") if (Convert.ToDecimal(lblM02D16.Text) < 0) lblM02D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM03D01.Text != "") if (Convert.ToDecimal(lblM03D01.Text) < 0) lblM03D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM03D16.Text != "") if (Convert.ToDecimal(lblM03D16.Text) < 0) lblM03D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM04D01.Text != "") if (Convert.ToDecimal(lblM04D01.Text) < 0) lblM04D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM04D16.Text != "") if (Convert.ToDecimal(lblM04D16.Text) < 0) lblM04D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM05D01.Text != "") if (Convert.ToDecimal(lblM05D01.Text) < 0) lblM05D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM05D16.Text != "") if (Convert.ToDecimal(lblM05D16.Text) < 0) lblM05D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM06D01.Text != "") if (Convert.ToDecimal(lblM06D01.Text) < 0) lblM06D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM06D16.Text != "") if (Convert.ToDecimal(lblM06D16.Text) < 0) lblM06D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM07D01.Text != "") if (Convert.ToDecimal(lblM07D01.Text) < 0) lblM07D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM07D16.Text != "") if (Convert.ToDecimal(lblM07D16.Text) < 0) lblM07D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM08D01.Text != "") if (Convert.ToDecimal(lblM08D01.Text) < 0) lblM08D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM08D16.Text != "") if (Convert.ToDecimal(lblM08D16.Text) < 0) lblM08D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM09D01.Text != "") if (Convert.ToDecimal(lblM09D01.Text) < 0) lblM09D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM09D16.Text != "") if (Convert.ToDecimal(lblM09D16.Text) < 0) lblM09D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM10D01.Text != "") if (Convert.ToDecimal(lblM10D01.Text) < 0) lblM10D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM10D16.Text != "") if (Convert.ToDecimal(lblM10D16.Text) < 0) lblM10D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM11D01.Text != "") if (Convert.ToDecimal(lblM11D01.Text) < 0) lblM11D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM11D16.Text != "") if (Convert.ToDecimal(lblM11D16.Text) < 0) lblM11D16.ForeColor = System.Drawing.Color.Red;
                    if (lblM12D01.Text != "") if (Convert.ToDecimal(lblM12D01.Text) < 0) lblM12D01.ForeColor = System.Drawing.Color.Red;
                    if (lblM12D16.Text != "") if (Convert.ToDecimal(lblM12D16.Text) < 0) lblM12D16.ForeColor = System.Drawing.Color.Red;
                }


                for (int i= 0;i< gvwMain.Columns.Count;i++)
                {
                    // Set Summary records.
                    if (hdnRecordClass.Value == "0") e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#bdd5ea");

                    // Set Group Records.
                    if (hdnRecordClass.Value == "1") e.Row.Cells[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#e9ecef");

                }


            }
        }

        protected void gvwMain_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }
    }
}