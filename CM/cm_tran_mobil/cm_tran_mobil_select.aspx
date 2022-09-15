<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cm_tran_mobil_select.aspx.cs" Inherits="CM.cm_tran.cm_tran_select" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
    <title>ITW Tran Select</title>

    <!-- Mobile layout -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Page Style -->     
    <link href="~/Styles/PageMobile.css" rel="Stylesheet" type="text/css"/>

    <!-- Fix Divs -->        
    <script src="~/Scripts/FixDiv.js" type="text/javascript"></script>	
    <link href="~/Styles/FixDiv.css" rel="Stylesheet" type="text/css"/>

    <!-- FloatButtons -->
    <link rel="stylesheet" href="~\Styles\FloatButton.css"/>
    <script type="text/javascript" src="~\Scripts\FloatButton.js"></script>

    <!-- Bootstrap -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/locales/bootstrap-datepicker.es.min.js" charset="UTF-8"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker3.css"/>
    <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css"/>       
    <script type="text/javascript">
    
        // Set bootstrap datepicker to date field.
        $(function () {
            $("#txtDate").datepicker({
                language: 'es',
                format: "D dd/M/yyyy"
            });
        });

        // Detect date selected to postback action.
        $(document).ready(function () {

            $("#txtDate").datepicker({
                todayBtn: 1,
                autoclose: true,
            }).on('changeDate', function (selected) {

                var vldSelectedDate = new Date(selected.date.valueOf());

                var vlsSelectedDate =
                    vldSelectedDate.getFullYear() +
                    "/" + ("0" + (vldSelectedDate.getMonth() + 1)).slice(-2) +
                    "/" + ("0" + vldSelectedDate.getDate()).slice(-2) +
                    " " + ("0" + vldSelectedDate.getHours()).slice(-2) +
                    ":" + ("0" + vldSelectedDate.getMinutes()).slice(-2);

                //alert(vlsSelectedDate);

                //var txtClientID = '<%= txtDate.ClientID %>';
                __doPostBack("DateSelected", vlsSelectedDate);
            });
        });
        
    </script>

</head>

<script type="text/javascript" lang="javascript" >
        function EventSelectedDate(sender, args) {
         //var txtClientID = '<%= txtDate.ClientID %>';
            //__doPostBack("DateSelected", document.getElementById(txtClientID).value);

            var vldSelectedDate = sender._selectedDate;

            var vlsSelectedDate =
                vldSelectedDate.getFullYear() +
                "/" + ("0" + (vldSelectedDate.getMonth() + 1)).slice(-2) +
                "/" + ("0" + vldSelectedDate.getDate()).slice(-2) +
                " " + ("0" + vldSelectedDate.getHours()).slice(-2) +
                ":" + ("0" + vldSelectedDate.getMinutes()).slice(-2);

            __doPostBack("DateSelected", vlsSelectedDate);

        }
    </script>

<body>
    <form id="form1" runat="server">

    <!-- Header. -->
    <div id="divHeader" class="divHeader" style="margin-bottom: 10px" >
                   
        <div id="divPageBar" class="divPageBar">

               <div id="divLeftButton" class="divLeft">
                   <asp:ImageButton ID="btnBack" runat="server" 
                        ImageUrl="~/Images/Back48.png" Visible="False" ToolTip="Regresar" />
               </div>

               <div id="divRigthButton" class="divRight">
                   <asp:ImageButton ID="btnNew" runat="server" 
                        ImageUrl="~/Images/New48.png" Visible="False" ToolTip="Nuevo" />
               </div>
                            
               <div id="divTitle" class="divTitle">
                   <asp:Label ID="lblTitle" class="lblTitle" runat="server" Text="Registros de Efectivo"></asp:Label>
               </div>

        </div>

        <div id="divHeader-Buttons">
            <div style="float: left">
                <asp:ImageButton ID="btnPrior" runat="server" 
                    ImageUrl="~/Images/Prior48.png" onclick="btnPriorDay_Click" />
            </div>
            <div style="float: right">
                <asp:ImageButton ID="btnNext" runat="server" 
                    ImageUrl="~/Images/Next48.png" onclick="btnNextDay_Click" />
            </div>   
            <div align="center" >
            

                <asp:ImageButton ID="btnDay" runat="server" 
                    ImageUrl="~/Images/CalendarDay48_Disable.png" Height="48px" Width="48px" OnClick="btnDay_Click" />
                <asp:ImageButton ID="btnWeek" runat="server" 
                    ImageUrl="~/Images/CalendarWeek48_Disable.png" OnClick="btnWeek_Click" />
                <asp:ImageButton ID="btnFornite" runat="server" 
                    ImageUrl="~/Images/CalendarFornite48.png" OnClick="btnFornite_Click" />
                <asp:ImageButton ID="btnMonth" runat="server" 
                    ImageUrl="~/Images/CalendarMonth48_Disable.png" OnClick="btnMonth_Click" />
                <asp:ImageButton ID="btnYear" runat="server" 
                    ImageUrl="~/Images/CalendarYear48_Disable.png" OnClick="btnYear_Click" Visible="False" />
        
       
            </div>  

        </div>
        <div id="divHeader-Date" align="center"  >
               
                <table  align="center">
                    <tr>
                        <td>
                        <asp:ImageButton ID="btnPostFlag" runat="server" 
                    ImageUrl="~/Images/Post48_Disable.png" OnClick="btnPost_Click" />
                        </td>

                        <td>
                    <asp:TextBox ID="txtDate" class="txt" runat="server" style="text-align:left; margin-bottom: 0px;"
                    ReadOnly="True" Font-Bold="True" 
                    BorderStyle="None" 
                    Width="150px">vier 23/Dic/2012</asp:TextBox> 

                        </td>
                        <td>
                <asp:ImageButton ID="btnPastFlag" runat="server"  
                    ImageUrl="~/Images/Past48.png" OnClick="btnPast_Click" BorderStyle="None" />    

                        </td>
                    </tr>                   
                </table>
 

        </div>
        <div id="dicHeader-TranType" align="center" style="text-align: center">
                
                <table  align="center">
                    <tr>
                        <td>
                            <asp:DropDownList ID="cmbTranType" runat="server" 
                            DataSourceID="srcCMTranType" DataTextField="tran_type_desc" 
                            DataValueField="tran_type" Font-Names="Arial" 
                            ondatabound="cmbTranType_DataBound" AutoPostBack="True" Font-Bold="True" OnSelectedIndexChanged="cmbTranType_SelectedIndexChanged" Visible="False" Font-Size="Large" 
                            style="text-align: center; width:auto;">
                                <asp:ListItem Value="*">Todos</asp:ListItem>                   
                            </asp:DropDownList>
                        </td>
                        <td style="padding-left: 10px;">
                            <asp:ImageButton ID="btnTrantTypeCancel" runat="server" ImageUrl="~/Images/Cancel16.png" OnClick="btnTrantTypeCancel_Click" Visible="False"   />
                        </td>
                    </tr>
                 </table>
                                           
                <asp:SqlDataSource ID="srcCMTranType" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT tran_type, tran_type_desc = SUBSTRING(tran_type_desc, 1, 20)
FROM cmtrantype 
WHERE (@tran_class = 0 OR tran_class = @tran_class)
ORDER BY tran_class DESC, tran_type_desc ">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="0" Name="tran_class" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
        </div>

    </div>

    <!-- Body -->
    <div id="divBody" class ="divBody">                        
        <div >
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            Height="100%" Width="100%" DataSourceID="srcCMTranBatch" 
            EmptyDataText="No hay registros para el periodo especificado." 
            onrowcommand="GridView1_RowCommand" DataKeyNames="tran_id" 
            EnablePersistedSelection="True" 
            onrowdatabound="GridView1_RowDataBound" ShowHeader="False" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
            <Columns>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                    <div id="divDetail">
                        <asp:HiddenField ID="hdnTranID" runat="server" Value='<%# Eval("tran_id") %>'/>
                        <asp:HiddenField ID="hdnTranClass" runat="server" Value='<%# Eval("tran_class") %>'/>
                        <asp:HiddenField ID="hdnTranType" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnDiscountFlag" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnStarFlag" runat="server" Value='<%# Eval("star_flag") %>' />
                        <asp:HiddenField ID="hdnSeverityClass" runat="server" Value='<%# Eval("severity_class") %>' />
                        <asp:HiddenField ID="hdnApplyDate" runat="server" Value='<%# Eval("apply_date") %>' />
                        <asp:HiddenField ID="hdnDocDate" runat="server" Value='<%# Eval("doc_date") %>' />
                        <asp:HiddenField ID="hdnHoldReason" runat="server" Value='<%# Eval("hold_reason") %>' />
                        <div id="divIcon" style="float: left; margin-right: 0px;">
                            <asp:Image ID="imgDet" runat="server" ImageUrl="~/Images/1346353503_notification_warning.png"/>
                        </div>
                        <div id="divFlags" style="float: left; margin-right: 0px;">
                            <div>
                                <asp:Image ID="imgStar" runat="server" ImageUrl="~/Images/star.png" Height="16px" Width="16px" />
                            </div>
                            <div>
                                <asp:Image ID="ImgNote" runat="server" ImageUrl="~/Images/note.png" Height="16px" Width="16px" />                        
                            </div>
                        </div>
                        <div style="float: right">                            
                            <div style="text-align: right">                                
                                    <asp:Label ID="lblTranAmt" runat="server" Text='<%# Eval("tran_amt") %>' Font-Names="Arial" Font-Size="Small" Font-Bold="True" Width="60px"></asp:Label>
                            </div> 
                            <div style="text-align: right">
                                    <asp:Label ID="lblCashAcctDescr" runat="server" Text='<%# Eval("cash_acct_descr") %>' Font-Names="Arial" Font-Size="Small" Width="60px"></asp:Label>
                            </div> 
                        </div>   
                        <div style="float: right">                            
                            <div style="text-align: right">                                
                                    <asp:Label ID="lblApplyDate" runat="server" Font-Names="Arial" Font-Size="Small" Text='<%# Eval("apply_date", "{0:ddd dd/MM}") %>' Font-Bold="True"></asp:Label>
                            </div> 
                            <div style="text-align: right">
                                    <asp:Label ID="lblDocDate" runat="server" Font-Bold="False" Font-Names="Arial" Font-Size="Small" Text='<%# Eval("doc_date", "{0:dd/MM}") %>' ForeColor="Silver"></asp:Label>
                            </div> 
                        </div>                           
                        <div style="text-align: left">                            
                            <div>
                                <asp:Label ID="lblTranTypeDesc" runat="server" Text='<%# Eval("tran_type_desc") %>' Font-Names="Arial" Font-Size="Small" Font-Bold="True"></asp:Label>
                            </div>  
                            <div>
                                <asp:Label ID="lblTranDesc" runat="server" Text='<%# Eval("tran_desc") %>' Font-Names="Arial" Font-Size="Small"></asp:Label>
                            </div>
                        </div>
                    </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        </div>

    
    </div>

    <!-- Float Buttons -->
    <div id="divFloatButtons">        
        <div id="container-floating">            
            <div class="nd4 nds" data-toggle="tooltip" data-placement="left" data-original-title="Transferencia">
                <asp:ImageButton ID="ImageButton3" runat="server" class="nd-aspx" 
                    ImageUrl="~/Images/Transfer32.png" OnClick="btnRevenue_Click" BorderStyle="None" />    
            </div>
            <div class="nd3 nds" data-toggle="tooltip" data-placement="left" data-original-title="Ingreso">
                <asp:ImageButton ID="ImageButton1" runat="server" class="nd-aspx" 
                    ImageUrl="~/Images/Plus32.png" OnClick="btnTransfer_Click" BorderStyle="None" />    
            </div>
            <div class="nd1 nds" data-toggle="tooltip" data-placement="left" data-original-title="Gasto" style="vertical-align: middle; text-align: center;">
                <asp:ImageButton ID="ImageButton2" runat="server" class="nd-aspx"  
                    ImageUrl="~/Images/Minus32.png" OnClick="btnExpense_Click" BorderStyle="None" ImageAlign="Middle" />    
            </div>
            <div id="floating-button" data-toggle="tooltip" data-placement="left" data-original-title="Create" onclick="newmail()">
                <p class="plus">+</p>
                <img class="edit" src="https://ssl.gstatic.com/bt/C3341AA7A1A076756462EE2E5CD71C11/1x/bt_compose2_1x.png" />
            </div>

        </div>
    </div>

    <!-- Footer -->
    <div id="divFooter" class ="divFooter" style="margin: 10px 0px 0px 0px">     
        <div id="divFooter-Totals" style="height: 52px" >                           
            <div align="center">
            <asp:Label ID="lblTotalAmt" runat="server" Text="0.00" Font-Names="Arial Black" Font-Size="XX-Large" Font-Bold="True"></asp:Label>
            </div>    
        </div>  
        <div id="divFooter-Bottons">             
            <div style="float: left">
                <%--<asp:ImageButton ID="btnExpense" 
                    runat="server" ImageUrl="~/Images/Expense.png" 
                    onclick="btnExpense_Click" />--%>
            </div>
            <div style="float: right">
                <%--<asp:ImageButton ID="btnTransfer" 
                    runat="server" ImageUrl="~/Images/Revenue.png" 
                    onclick="btnTransfer_Click" />--%>
            </div>   
            <div align="center">
                <%--<asp:ImageButton ID="btnRevenue" 
                    runat="server" ImageUrl="~/Images/Transfer.png" 
                    onclick="btnRevenue_Click" />--%>
            </div>  
        </div>     
                
    </div>

    <asp:HiddenField ID="hdnDate" runat="server" Value="2012/01/01" />

    <asp:HiddenField ID="hdnDateClass" runat="server" Value="15" />

    <asp:HiddenField ID="hdnPostFlag" runat="server" Value="false" />

    <asp:HiddenField ID="hdnPastFlag" runat="server" Value="true" />
    
    <asp:SqlDataSource ID="srcCMTranBatchRange" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT TR.tran_id, TR.comp_id, TR.tran_num, TR.tran_desc, TR.entry_date, TR.doc_date, TR.post_date, TR.post_flag, TR.user_id, CASE WHEN TR.tran_class &lt;&gt; 13210 THEN TR.tran_type ELSE TR.tran_type + '-' + TR.trsf_tran_type END AS tran_type, TY.tran_type_desc, TR.cash_acct_code, C.cash_acct_desc, CASE WHEN TR.tran_class &lt;&gt; 13210 THEN SUBSTRING(C.cash_acct_desc , 1 , 4) ELSE SUBSTRING(C.cash_acct_desc , 1 , 4) + '-' + SUBSTRING(CT.cash_acct_desc , 1 , 4) END AS cash_acct_descr, CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * - 1 ELSE TR.tran_amt END AS tran_amt, TR.tran_class, TR.apply_date, TY.severity_class, TR.star_flag, TR.hold_reason FROM cmtranbatch AS TR INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code WHERE (TR.apply_date BETWEEN @from_apply_date AND @to_apply_date) AND (TR.post_flag = @post_flag) 
AND (@tran_type = '*' OR @tran_type = TR.tran_type) 
ORDER BY TY.severity_class, TY.sequence, TR.apply_date" 
            
            
            ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:Parameter Name="from_apply_date" Type="DateTime" />
                <asp:Parameter Name="to_apply_date" Type="DateTime" />
                <asp:Parameter Name="post_flag" Type="Boolean" />
                <asp:Parameter Name="tran_type" Type="String" DefaultValue="*" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="srcCMTranBatchToDate" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT TR.tran_id, TR.comp_id, TR.tran_num, TR.tran_desc, TR.entry_date, TR.doc_date, TR.post_date, TR.post_flag, TR.user_id, CASE WHEN TR.tran_class &lt;&gt; 13210 THEN TR.tran_type ELSE TR.tran_type + '-' + TR.trsf_tran_type END AS tran_type, TY.tran_type_desc, TR.cash_acct_code, C.cash_acct_desc, CASE WHEN TR.tran_class &lt;&gt; 13210 THEN SUBSTRING(C.cash_acct_desc , 1 , 4) ELSE SUBSTRING(C.cash_acct_desc , 1 , 4) + '-' + SUBSTRING(CT.cash_acct_desc , 1 , 4) END AS cash_acct_descr, CASE TY.tran_class WHEN 13110 THEN TR.tran_amt * - 1 ELSE TR.tran_amt END AS tran_amt, TR.tran_class, TR.apply_date, TY.severity_class, TR.star_flag, TR.hold_reason FROM cmtranbatch AS TR INNER JOIN cmtrantype AS TY ON TY.comp_id = TR.comp_id AND TY.tran_type = TR.tran_type INNER JOIN cmcash AS C ON C.comp_id = TR.comp_id AND C.cash_acct_code = TR.cash_acct_code LEFT OUTER JOIN cmcash AS CT ON CT.comp_id = TR.comp_id AND CT.cash_acct_code = TR.trsf_cash_acct_code WHERE (TR.apply_date &lt;= @apply_date) AND (TR.post_flag = 0) 
AND (@tran_type = TR.tran_type OR @tran_type = '*') 
ORDER BY TY.severity_class, TY.sequence, TR.apply_date" 
            
            
            ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:Parameter Name="apply_date" Type="DateTime" />
                <asp:Parameter Name="tran_type" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </form>
</body>
</html>
