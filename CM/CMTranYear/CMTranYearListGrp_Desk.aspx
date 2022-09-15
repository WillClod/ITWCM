<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CMTranYearListGrp_Desk.aspx.cs" Inherits="CM.CMTranYear.CMTranYearListGrp_Desk" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>ITW CM Tran Batch Year Grp</title>

    <!-- Mobile layout -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Fix Divs -->        
    <script src="../Scripts/FixDiv.js" type="text/javascript"></script>	
    <link href="../Styles/FixDiv.css" rel="Stylesheet" type="text/css"/>
        
    <!-- Fix Grid -->    
    <script type="text/javascript" src="../Scripts/gridviewscroll.js"></script>
    <link href="../Styles/web.css" rel="stylesheet" />

    <!--<script src="../Scripts/FixDivGrid.js" type="text/javascript"></script>-->   
    <script type="text/javascript">

        var gridViewScroll = null;

        function Mensaje() {
            //headerx.clientHeight = 100;
            //document.getElementById("headerx").style.height = "100px";

            var vloDivHeader = document.getElementById("divHeater");
            var vloDivBody = document.getElementById("divBody");
            var vloDivFooter = document.getElementById("divFooter");

            //alert('Hola:' + headerx.clientHeight);
            
            alert('Body.offsetTop:' + vloDivBody.offsetTop);
            alert('Body.clientHeight:' + vloDivBody.clientHeight);
            alert('Footer.offsetTop:' + vloDivFooter.offsetTop);
            alert('Footer.clientHeight:' + vloDivFooter.clientHeight);

        }

        window.onload = function () {

            // Set Div Body Height to Footer.
            fgvDivToFooter("divBody", "divFooter");

            // Set Grid to fit in Div Body and Fix Header and cols.
            var vloDivBody = document.getElementById("divBody");
                        
            gridViewScroll = new GridViewScroll({
                elementID: "gvwMain",
                width: vloDivBody.clientWidth,
                height: vloDivBody.clientHeight,
                freezeColumn: true,
                freezeFooter: false,
                freezeColumnCssClass: "GridViewScrollItemFreeze",
                freezeFooterCssClass: "GridViewScrollFooterFreeze",
                freezeHeaderRowCount: 1,
                freezeColumnCount: 2,
                onscroll: function (scrollTop, scrollLeft) {
                    console.log(scrollTop + " - " + scrollLeft);
                }
            });
            gridViewScroll.enhance();
        }

        window.onresize = function () {
          
            // Set Div Body Height to Footer.
            fgvDivToFooter("divBody", "divFooter");

            // Set Grid to fit in Div Body and Fix Header and cols.            
            var vloDivBody = document.getElementById("divBody");

            gridViewScroll.undo();
            gridViewScroll = new GridViewScroll({
                elementID: "gvwMain",
                width: vloDivBody.clientWidth,
                height: vloDivBody.clientHeight,
                freezeColumn: true,
                freezeFooter: false,
                freezeColumnCssClass: "GridViewScrollItemFreeze",
                freezeFooterCssClass: "GridViewScrollFooterFreeze",
                freezeHeaderRowCount: 1,
                freezeColumnCount: 2,
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

        function fgvDivToFooter(vpsDivId, vpsDivFooterId) {
            var vloDiv = document.getElementById(vpsDivId);
            var vloDivFooter = document.getElementById(vpsDivFooterId);

            vloDiv.style.height = (vloDivFooter.offsetTop - vloDiv.offsetTop - 17) + "px";
            //vloDiv.style.height = (vloDivFooter.offsetTop - vloDiv.offsetTop - (vloDivFooter.offsetTop - vloDivFooter.offsetTop - vloDiv.offsetTop)) + "px";
        }

        function fgvDivBodyAdjust(vpsDivHeaderId, vpsDivBodyId, vpsDivFooterId) {
            var vloDivHeader = document.getElementById(vpsDivHeaderId);
            var vloDivBody = document.getElementById(vpsDivBodyId);
            var vloDivFooter = document.getElementById(vpsDivFooterId);
            vloDivBody.style.height = (vloDivFooter.offsetTop - vloDivHeader.style.height) + "px";
        }

        function fgvDivRepplyScroll(vpsDivId, vpsDivToRepplyId) {
            var vloDiv = document.getElementById(vpsDivId);
            var vloDivToRepply = document.getElementById(vpsDivToRepplyId);
            vloDivToRepply.scrollLeft = vloDiv.scrollLeft;
        }
    </script>
   
    
</head>

<body>
    <form id="form1" runat="server">
    
        <div id="divHeader" class="divHeader">
            <div id="divFilters" style="margin-bottom: 10px">
                <asp:DropDownList ID="cmbYear" runat="server" OnSelectedIndexChanged="cmbYear_SelectedIndexChanged" AutoPostBack="True" Font-Size="Small">
                    <asp:ListItem>2019</asp:ListItem>
                    <asp:ListItem>2020</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtStartAmt" runat="server" TextMode="Number" Font-Size="Small" OnTextChanged="txtStartAmt_TextChanged">0.0</asp:TextBox>
                <asp:DropDownList ID="cmbTranType" runat="server" 
                                DataSourceID="srcCMTranType" DataTextField="tran_type_desc" 
                                DataValueField="tran_type" Font-Names="Arial" 
                                ondatabound="cmbTranType_DataBound" AutoPostBack="True" Font-Bold="False" OnSelectedIndexChanged="cmbTranType_SelectedIndexChanged" Font-Size="Small" 
                                style="text-align: center; width:auto;">
                                    <asp:ListItem Value="*">Todos</asp:ListItem>                   
                                </asp:DropDownList>

                <asp:Button ID="Button1" runat="server" Text="Button" OnClientClick="Mensaje()" Visible="False" /> 
            </div>      
            
        </div>
        
        <div id="divBody" class ="divBody" >

            <div id="divGridView">
                                
                <asp:GridView ID="gvwMain" runat="server" 
                    DataSourceID="srcCMTranBatchYearGroupTypeGet" Width="100%" AutoGenerateColumns="False" OnRowDataBound="gvwMain_RowDataBound" OnSelectedIndexChanged="gvwMain_SelectedIndexChanged1">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Image ID="imgIcon" runat="server" Height="32px" ImageUrl="~/Images/cmtrantype/GASOLINA.png" Width="32px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("record_code") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <div id="divHiddens">
                                    <asp:HiddenField ID="hdnRecordClass" runat="server" Value='<%# Bind("record_class") %>' />
                                </div>
                                <div id="divDetail">
                                    <div id="divIcon" style="float: left; margin-right: 0px;">
                                    </div>
                                    <div id="divlabel" style="float: left; margin-right: 0px; vertical-align: middle;">
                                        <asp:Label ID="lblRecordCode" runat="server" Text='<%# Bind("record_code") %>'></asp:Label>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <ControlStyle Width="100px" />
                            <FooterStyle Width="100px" />
                            <HeaderStyle Width="100px" />
                            <ItemStyle Font-Bold="True" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ENE Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("M01D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM01D01" runat="server" Text='<%# Bind("M01D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Width="100px" />
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ENE Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("M01D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM01D16" runat="server" Text='<%# Bind("M01D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Width="100px" />
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FEB Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("M02D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM02D01" runat="server" Text='<%# Bind("M02D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Width="100px" />
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="FEB Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("M02D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM02D16" runat="server" Text='<%# Bind("M02D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Width="100px" />
                            <ItemStyle HorizontalAlign="Right" Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MAR Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("M03D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM03D01" runat="server" Text='<%# Bind("M03D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MAR Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox25" runat="server" Text='<%# Bind("M03D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM03D16" runat="server" Text='<%# Bind("M03D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ABR Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("M04D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM04D01" runat="server" Text='<%# Bind("M04D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ABR Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("M04D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM04D16" runat="server" Text='<%# Bind("M04D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MAY Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("M05D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM05D01" runat="server" Text='<%# Bind("M05D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MAY Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("M05D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM05D16" runat="server" Text='<%# Bind("M05D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="JUN Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("M06D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM06D01" runat="server" Text='<%# Bind("M06D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="JUN Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("M06D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM06D16" runat="server" Text='<%# Bind("M06D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="JUL Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("M07D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM07D01" runat="server" Text='<%# Bind("M07D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="JUL Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("M07D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM07D16" runat="server" Text='<%# Bind("M07D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AGO Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("M08D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM08D01" runat="server" Text='<%# Bind("M08D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AGO Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox16" runat="server" Text='<%# Bind("M08D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM08D16" runat="server" Text='<%# Bind("M08D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SEP Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox17" runat="server" Text='<%# Bind("M09D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM09D01" runat="server" Text='<%# Bind("M09D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="SEP Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox18" runat="server" Text='<%# Bind("M09D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM09D16" runat="server" Text='<%# Bind("M09D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="OCT Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox19" runat="server" Text='<%# Bind("M10D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM10D01" runat="server" Text='<%# Bind("M10D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="OCT Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox20" runat="server" Text='<%# Bind("M10D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM10D16" runat="server" Text='<%# Bind("M10D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="NOV Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox21" runat="server" Text='<%# Bind("M11D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM11D01" runat="server" Text='<%# Bind("M11D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="NOV Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox22" runat="server" Text='<%# Bind("M11D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM11D16" runat="server" Text='<%# Bind("M11D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DIC Q1">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox23" runat="server" Text='<%# Bind("M12D01") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM12D01" runat="server" Text='<%# Bind("M12D01", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DIC Q2">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox24" runat="server" Text='<%# Bind("M12D16") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblM12D16" runat="server" Text='<%# Bind("M12D16", "{0:###,###,###}") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="GridViewScrollHeader" HorizontalAlign="Center" />
                    <RowStyle CssClass="GridViewScrollItem" />
                </asp:GridView>
                

                <!--
            <asp:GridView ID="gvwMain2" runat="server" 
                    DataSourceID="srcCMTranBatch">
            <HeaderStyle CssClass="GridViewScrollHeader" />
            <RowStyle CssClass="GridViewScrollItem" />
            </asp:GridView>
                -->

            </div>

        </div>

        <div id="divFooter" class ="divFooter" >

            <div id="divDataSources">

            <asp:SqlDataSource ID="srcCMTranTypeYear" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="
    SELECT 
    TR.tran_type,
    MIN(TY.tran_type_desc) AS tran_desc,
    TY.severity_class, 
    TY.sequence,
    'M01D01' AS M01D01, 'M01D16' AS M01D16,
    'M02D01' AS M02D01, 'M02D16' AS M02D16,
    'M03D01' AS M03D01, 'M03D16' AS M03D16,
    'M04D01' AS M04D01, 'M04D16' AS M04D16,
    'M05D01' AS M05D01, 'M05D16' AS M05D16,
    'M06D01' AS M06D01, 'M06D16' AS M06D16,
    'M07D01' AS M07D01, 'M07D16' AS M07D16,
    'M08D01' AS M08D01, 'M08D16' AS M08D16,
    'M09D01' AS M09D01, 'M09D16' AS M09D16,
    'M10D01' AS M10D01, 'M10D16' AS M10D16,
    'M11D01' AS M11D01, 'M11D16' AS M11D16,
    'M12D01' AS M12D01, 'M12D16' AS M12D16
    FROM cmtranbatch AS TR 
    INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type 
    INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code 
    LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code 
    WHERE (TR.apply_date BETWEEN @from_apply_date AND @to_apply_date) 
    AND (TR.post_flag = @post_flag) 
    AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
    GROUP BY TY.tran_class, TR.tran_type, TY.severity_class, TY.sequence
    ORDER BY TY.tran_class, TY.severity_class, TY.sequence, TR.tran_type
    ">
                <SelectParameters>
                    <asp:Parameter Name="from_apply_date" Type="DateTime" />
                    <asp:Parameter Name="to_apply_date" Type="DateTime" />
                    <asp:Parameter Name="post_flag" Type="Boolean" />
                    <asp:Parameter Name="tran_type" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="srcCMTranType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT tran_type, tran_type_desc = SUBSTRING(tran_type_desc, 1, 20)
    FROM cmtrantype 
    WHERE (@tran_class = 0 OR tran_class = @tran_class)
    ORDER BY tran_class DESC, tran_type_desc ">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="tran_class" />
                        </SelectParameters>
                    </asp:SqlDataSource>

            <asp:SqlDataSource ID="srcCMTranBatchYearGroupGet" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>" SelectCommand="EXEC CMTranBatchYearGroupGet @year, @tran_group, @post_flag, @start_amt ">
                <SelectParameters>
                    <asp:Parameter DbType="Int16" Name="year" />
                    <asp:Parameter DbType="String" Name="tran_group" />
                    <asp:Parameter DbType="Boolean" Name="post_flag" />
                    <asp:Parameter DbType="Decimal" Name="start_amt" />
                </SelectParameters>
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="srcCMTranBatchYearTypeGet" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>" SelectCommand="EXEC CMTranBatchYearTypeGet @year, @tran_group, @tran_type, @post_flag, @start_amt">
                <SelectParameters>
                    <asp:Parameter DbType="Int16" Name="year" />
                    <asp:Parameter DbType="String" Name="tran_group" />
                    <asp:Parameter DbType="String" Name="tran_type" />
                    <asp:Parameter DbType="Boolean" Name="post_flag" />
                    <asp:Parameter DbType="Decimal" Name="start_amt" />
                </SelectParameters>
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="srcCMTranBatchYearGroupTypeGet" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>" SelectCommand="EXEC CMTranBatchYearGroupTypeGet @year, @tran_group, @post_flag, @start_amt">
                <SelectParameters>
                    <asp:Parameter DbType="Int16" Name="year" />
                    <asp:Parameter DbType="String" Name="tran_group" />
                    <asp:Parameter DbType="Boolean" Name="post_flag" />
                    <asp:Parameter DbType="Currency" Name="start_amt" />
                </SelectParameters>
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="srcCMTranBatch" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>" SelectCommand="
select * from cmtranbatch where entry_date &gt; '2022/01/01'
"></asp:SqlDataSource>

            </div>
            
        </div>

    </form>
</body>

</html>
