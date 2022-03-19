using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CM.cm_tran_year_web
{
    public partial class GridViewFixHeader : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime vldFirstDay = new DateTime(2019, 11, 1); //DateTime.MinValue;
            DateTime vldLastDay = new DateTime(2019, 11, 30);  //DateTime.MinValue;

            // Filter.
            srcCMTranTypeYear.SelectParameters["from_apply_date"].DefaultValue = vldFirstDay.ToString();
            srcCMTranTypeYear.SelectParameters["to_apply_date"].DefaultValue = vldLastDay.ToString();
            srcCMTranTypeYear.SelectParameters["post_flag"].DefaultValue = false.ToString();
            srcCMTranTypeYear.SelectParameters["tran_type"].DefaultValue = "*";
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            /*
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowIndex == 0)
                    e.Row.Style.Add("margin", "100px");
            }
            */
        }
    }
}