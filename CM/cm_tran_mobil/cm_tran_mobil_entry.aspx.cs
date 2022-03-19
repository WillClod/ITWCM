using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Threading;     // For set Culture.
using System.Globalization; // For set Culture.


namespace CM.cm_tran
{
    public partial class cm_tran_entry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Set culture.
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("es-Mx");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-MX");

            // Set JS events.
            btnBack.Attributes.Add("onClick", "javascript:history.back(); return false;");

            //TranTypeValidation
            btnSave.Attributes.Add("onClick", "javascript: return FieldValidation();");

            // On Create page.
            if (!IsPostBack)
            {

                if (Request.QueryString["TranID"] != null)
                {
                    // If for New Record.
                    if (Request.QueryString["TranID"] == "0")
                    {
                        // Set ID.
                        hdnTranID.Value = "0";

                        DateTime vldApplyDate = DateTime.Today;
                        hdnDate.Value = vldApplyDate.ToString();
                        txtDate.Text = vldApplyDate.ToString("ddd dd/MMM/yyyy");

                        DateTime vldDocDate = vldApplyDate;
                        hdnDocDate.Value = vldDocDate.ToString();
                        txtDocDate.Text = vldDocDate.ToString("ddd dd/MMM/yyyy");

                        btnDelete.Visible = false;
                    }                    
                    else // If for Edit Record.
                    {
                        // Set ID.
                        hdnTranID.Value = Request.QueryString["TranID"];

                        // Get record data.
                        srcCMTranBatch.SelectParameters["tran_id"].DefaultValue = Request.QueryString["TranID"];
                        DataView dwCMTranBatch = (DataView)srcCMTranBatch.Select(DataSourceSelectArguments.Empty);
                        if (dwCMTranBatch.Count > 0)
                        {
                            DateTime vldApplyDate = Convert.ToDateTime(dwCMTranBatch[0]["apply_date"].ToString());
                            txtDate.Text = vldApplyDate.ToString("ddd dd/MMM/yyyy");
                            hdnDate.Value = vldApplyDate.ToString();

                            DateTime vldDocDate = Convert.ToDateTime(dwCMTranBatch[0]["doc_date"].ToString());
                            txtDocDate.Text = vldDocDate.ToString("ddd dd/MMM/yyyy");
                            hdnDocDate.Value = vldDocDate.ToString();

                            txtTranAmt.Text = dwCMTranBatch[0]["tran_amt"].ToString();
                            txtDescription.Text = dwCMTranBatch[0]["tran_desc"].ToString();
                            txtHoldReason.Text = dwCMTranBatch[0]["hold_reason"].ToString();
                            cmbTranType.SelectedValue = dwCMTranBatch[0]["tran_type"].ToString();
                            cmbCashAcct.SelectedValue = dwCMTranBatch[0]["cash_acct_code"].ToString();
                            cmbTrsfCashAcct.SelectedValue = dwCMTranBatch[0]["trsf_cash_acct_code"].ToString();
                            if (dwCMTranBatch[0]["hold_flag"].ToString() == "True") chbHoldFlag.Checked = true;
                            if (dwCMTranBatch[0]["post_flag"].ToString() == "True") chbPostFlag.Checked = true;
                            if (dwCMTranBatch[0]["star_flag"].ToString() == "True") chbStarFlag.Checked = true;

                        }
                    }


                }

                if (Request.QueryString["TranClass"] != null)
                {
                    hdnTranClass.Value = Request.QueryString["TranClass"].ToString();

                    // If expense or revenue transaction.
                    if ((hdnTranClass.Value == "13010") || (hdnTranClass.Value == "13110"))
                    {
                        srcCMTranType.SelectParameters["tran_class"].DefaultValue = hdnTranClass.Value;

                    }

                    // If transfer transaction.
                    if(hdnTranClass.Value == "13210")                    
                    {
                        lblTranType.Visible = false;
                        cmbTranType.Visible = false;

                        lblCashAcct.Text = "Cuenta Banco Salida";

                        lblTrsfCashAcct.Visible = true;
                        cmbTrsfCashAcct.Visible = true;
                    }

                }


            }
            else // If post back
            {

                if (Request.Form["__EVENTTARGET"] == "DateSelected")
                {
                    DateTime vldDate = Convert.ToDateTime(Request.Form["__EVENTARGUMENT"]);
                    hdnDate.Value = vldDate.ToString();
                    txtDate.Text = vldDate.ToString("ddd dd/MMM/yyyy");
                }
                 
                if (Request.Form["__EVENTTARGET"] == "DateDocSelected")
                {
                    DateTime vldDate = Convert.ToDateTime(Request.Form["__EVENTARGUMENT"]);
                    hdnDocDate.Value = vldDate.ToString();
                    txtDocDate.Text = vldDate.ToString("ddd dd/MMM/yyyy");
                }

            }


        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            // Variable definitions.
            string vlsTrfOutTranType = "";
            string vlsTrfInTranType = ""; 

            // If transfer transaction.
            if (hdnTranClass.Value == "13210")
            {
                // Get dataview from data source with parameters.
                srcCMConfig.SelectParameters["comp_id"].DefaultValue = "1";
                DataView vloCMConfigDW = (DataView)srcCMConfig.Select(DataSourceSelectArguments.Empty);

                if (vloCMConfigDW.Count > 0)
                {
                    vlsTrfOutTranType = (string)vloCMConfigDW[0]["trfout_tran_type"];
                    vlsTrfInTranType = (string)vloCMConfigDW[0]["trfin_tran_type"];
                }
            }


            // If new transaction ...
            if (hdnTranID.Value == "0")
            {
                // Insert transaction.
                srcCMTranBatch.InsertParameters["comp_id"].DefaultValue = "1";
                srcCMTranBatch.InsertParameters["tran_num"].DefaultValue = null;
                srcCMTranBatch.InsertParameters["tran_desc"].DefaultValue = txtDescription.Text;
                srcCMTranBatch.InsertParameters["hold_reason"].DefaultValue = txtHoldReason.Text;
                srcCMTranBatch.InsertParameters["entry_date"].DefaultValue = DateTime.Today.ToString();
                //srcCMTranBatch.InsertParameters["apply_date"].DefaultValue = txtDate.Text;
                srcCMTranBatch.InsertParameters["apply_date"].DefaultValue = hdnDate.Value;
                //srcCMTranBatch.InsertParameters["doc_date"].DefaultValue = txtDocDate.Text;
                srcCMTranBatch.InsertParameters["doc_date"].DefaultValue = hdnDocDate.Value;
                srcCMTranBatch.InsertParameters["hold_flag"].DefaultValue = chbHoldFlag.Checked.ToString();
                srcCMTranBatch.InsertParameters["post_flag"].DefaultValue = chbPostFlag.Checked.ToString();
                srcCMTranBatch.InsertParameters["star_flag"].DefaultValue = chbStarFlag.Checked.ToString();
                srcCMTranBatch.InsertParameters["user_id"].DefaultValue = "1";

                // If no transafer transaction.
                if (hdnTranClass.Value != "13210")
                {
                    srcCMTranBatch.InsertParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue.ToString();
                    srcCMTranBatch.InsertParameters["cash_acct_code"].DefaultValue = cmbCashAcct.SelectedValue.ToString();
                }
                else
                {
                    srcCMTranBatch.InsertParameters["tran_type"].DefaultValue = vlsTrfOutTranType;
                    srcCMTranBatch.InsertParameters["trsf_tran_type"].DefaultValue = vlsTrfInTranType;

                    srcCMTranBatch.InsertParameters["cash_acct_code"].DefaultValue = cmbCashAcct.SelectedValue.ToString();
                    srcCMTranBatch.InsertParameters["trsf_cash_acct_code"].DefaultValue = cmbTrsfCashAcct.SelectedValue.ToString();
                }

                srcCMTranBatch.InsertParameters["tran_amt"].DefaultValue = txtTranAmt.Text;
                srcCMTranBatch.InsertParameters["tran_class"].DefaultValue = hdnTranClass.Value;

                try
                {
                    srcCMTranBatch.Insert();
                }
                catch (Exception x)           
                {
                    pcvAlert(x.Message);
                    return;
                }
               
                Server.Transfer("cm_tran_mobil_select.aspx?DocDate=" + hdnDate.Value);

            }
            else // If edit tran. 
            {
                // Update transaction.                                
                srcCMTranBatch.UpdateParameters["tran_id"].DefaultValue = hdnTranID.Value;
                srcCMTranBatch.UpdateParameters["tran_desc"].DefaultValue = txtDescription.Text;
                srcCMTranBatch.UpdateParameters["hold_reason"].DefaultValue = txtHoldReason.Text;
                //srcCMTranBatch.UpdateParameters["apply_date"].DefaultValue = txtDate.Text;
                srcCMTranBatch.UpdateParameters["apply_date"].DefaultValue = hdnDate.Value;
                //srcCMTranBatch.UpdateParameters["doc_date"].DefaultValue = txtDocDate.Text;
                srcCMTranBatch.UpdateParameters["doc_date"].DefaultValue = hdnDocDate.Value;

                // If no transafer transaction.
                if (hdnTranClass.Value != "13210")
                {
                    srcCMTranBatch.UpdateParameters["tran_type"].DefaultValue = cmbTranType.SelectedValue.ToString();
                    srcCMTranBatch.UpdateParameters["cash_acct_code"].DefaultValue = cmbCashAcct.SelectedValue.ToString();
                }
                else
                {
                    srcCMTranBatch.UpdateParameters["tran_type"].DefaultValue = vlsTrfOutTranType;
                    srcCMTranBatch.UpdateParameters["trsf_tran_type"].DefaultValue = vlsTrfInTranType;

                    srcCMTranBatch.UpdateParameters["cash_acct_code"].DefaultValue = cmbCashAcct.SelectedValue.ToString();
                    srcCMTranBatch.UpdateParameters["trsf_cash_acct_code"].DefaultValue = cmbTrsfCashAcct.SelectedValue.ToString();
                }

                srcCMTranBatch.UpdateParameters["tran_amt"].DefaultValue = txtTranAmt.Text;

                srcCMTranBatch.UpdateParameters["hold_flag"].DefaultValue = chbHoldFlag.Checked.ToString();
                srcCMTranBatch.UpdateParameters["post_flag"].DefaultValue = chbPostFlag.Checked.ToString();
                srcCMTranBatch.UpdateParameters["star_flag"].DefaultValue = chbStarFlag.Checked.ToString();

                try
                {
                    srcCMTranBatch.Update();
                }
                catch (Exception x)
                {
                    pcvAlert(x.Message);
                    return;
                }
                
                Server.Transfer("cm_tran_mobil_select.aspx?DocDate=" + hdnDate.Value);                
            }
        }

        protected void btnDelete_Click(object sender, ImageClickEventArgs e)
        {
            // Delete transaction.                                
            srcCMTranBatch.DeleteParameters["tran_id"].DefaultValue = hdnTranID.Value;

            try
            {
                srcCMTranBatch.Delete();
            }
            catch (Exception x)
            {
                pcvAlert(x.Message);
                return;
            }
            
            Server.Transfer("cm_tran_mobil_select.aspx?DocDate=" + hdnDate.Value);
        }

        protected void cmbTranType_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "";
            cmbTranType.Items.Insert(0, listItem);
        }

        protected void cmbChasAcct_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "";
            cmbCashAcct.Items.Insert(0, listItem);
        }

        protected void cmbTrsfCashAcct_DataBound(object sender, EventArgs e)
        {
            // Add item empty. 
            ListItem listItem = new ListItem();
            listItem.Text = "";
            listItem.Value = "";
            cmbTrsfCashAcct.Items.Insert(0, listItem);
        }

        public void pcvAlert(string vpsMessage)
        {
            // Cleans the message to allow single quotation marks 
            string vlsCleanMessage = vpsMessage.Replace("'", " ");
            vlsCleanMessage = vlsCleanMessage.Replace("\n", "\\n");
            vlsCleanMessage = vlsCleanMessage.Replace("\r", "\\r");
            string vlsScript = "<script language=JavaScript>alert('" + vpsMessage + "');</script>";

            // Gets the executing web page 
            Page page = HttpContext.Current.CurrentHandler as Page;

            // Checks if the handler is a Page and that the script isn't allready on the Page 
            if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", "alert('" + vlsCleanMessage + "');", true);
            }
        }

        protected void btnBack_Click(object sender, ImageClickEventArgs e)
        {

        }
    }
}