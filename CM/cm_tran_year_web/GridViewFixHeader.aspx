<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewFixHeader.aspx.cs" Inherits="CM.cm_tran_year_web.GridViewFixHeader" %>

<%@ Register src="cm_tran_year_web_detail.ascx" tagname="cm_tran_year_web_detail" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <!--
    <style type="text/css">
        .GVFixedHeader
        {
            font-weight: bold;
            background-color: Green;
            position: relative;
            top: expression(this.parentNode.parentNode.parentNode.scrollTop-1);
        }
        .GridViewContainer
        {
            overflow-y:auto;
            overflow-x:auto;
        }
    </style>
    -->

    <link href="../Styles/web.css" rel="stylesheet" />

    <script type="text/javascript" src="../Scripts/gridviewscroll.js"></script>

    <script type="text/javascript">
        var gridViewScroll = null;
        window.onload = function () {
            gridViewScroll = new GridViewScroll({
                elementID: "gvwCMTranBatch",
                width: 850,
                height: 350,
                freezeColumn: true,
                freezeFooter: true,
                freezeColumnCssClass: "GridViewScrollItemFreeze",
                freezeFooterCssClass: "GridViewScrollFooterFreeze",
                freezeHeaderRowCount: 1,
                freezeColumnCount: 3,
                onscroll: function (scrollTop, scrollLeft) {
                    console.log(scrollTop + " - " + scrollLeft);
                }
            });
            gridViewScroll.enhance();
        }
        function getScrollPosition() {
            var position = gridViewScroll.scrollPosition;
            alert("scrollTop: " + position.scrollTop + ", scrollLeft: " + position.scrollLeft);
        }
        function setScrollPosition() {
            var scrollPosition = { scrollTop: 50, scrollLeft: 50 };

            gridViewScroll.scrollPosition = scrollPosition;
        }
    </script>
  
</head>
<body>
    <form id="form1" runat="server">
    <div id="divGridView" >

        <asp:GridView ID="gvwCMTranBatch" runat="server" DataSourceID="srcCMTranBatch" 
            OnSelectedIndexChanged="gvwCMTranBatch_SelectedIndexChanged">
            <HeaderStyle CssClass="GridViewScrollHeader" />
            <RowStyle CssClass="GridViewScrollItem" />
        </asp:GridView>


    </div>
    <div id="divDataSources">

        <asp:SqlDataSource ID="srcCMTranBatch" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>" SelectCommand="
select * from cmtranbatch where entry_date &gt; '2022/01/01'
"></asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
