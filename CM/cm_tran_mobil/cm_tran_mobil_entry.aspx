<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cm_tran_mobil_entry.aspx.cs" Inherits="CM.cm_tran.cm_tran_entry" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style type="text/css">
        #divDates {
            height: 49px;
        }
        #divFlags {
            height: 53px;
        }
    </style>
</head>
 <script type="text/javascript" language="javascript">
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

      function EventSelectedDocDate(sender, args) {
         //var txtClientID = '<%= txtDate.ClientID %>';
         //__doPostBack("DateSelected", document.getElementById(txtClientID).value);

         var vldSelectedDocDate = sender._selectedDate;

         var vlsSelectedDocDate =
                   vldSelectedDocDate.getFullYear() +
             "/" + ("0" + (vldSelectedDocDate.getMonth() + 1)).slice(-2) +
             "/" + ("0" + vldSelectedDocDate.getDate()).slice(-2) +
             " " + ("0" + vldSelectedDocDate.getHours()).slice(-2) +
             ":" + ("0" + vldSelectedDocDate.getMinutes()).slice(-2);

         //alert('hola:' + vlsSelectedDocDate);

          __doPostBack("DateDocSelected", vlsSelectedDocDate);
          //__doPostBack("DateDocSelected", "Hola");
     }

     function IsNumeric(input) {
         return (input - 0) == input && input.length > 0;
     }

     function FieldValidation() {

         // Amount validation.
         if (document.getElementById('txtTranAmt').value == "") {
             alert("Favor de especificar el Monto.")
             document.getElementById('txtTranAmt').focus();
             return false;
         }

         if (!IsNumeric(document.getElementById('txtTranAmt').value)) {
             alert("Monto debe ser numérico.")
             document.getElementById('txtTranAmt').focus();
             return false;
         }

         // Tran Type validation.
         if (document.getElementById('hdnTranClass').value != "13210")
             if (document.getElementById('cmbTranType').selectedIndex == 0) {
                 alert("Favor de seleccionar el Tipo de Transacción.")
                 document.getElementById('cmbTranType').focus();
                 return false;
             }

         // Cash Acct Validation.
         if (document.getElementById('cmbCashAcct').selectedIndex == 0) {
             alert("Favor de seleccionar la Cuenta de Banco.");
             document.getElementById('cmbCashAcct').focus();
             return false;
         }

         // Transfer Cash Acct Validation.
         if (document.getElementById('hdnTranClass').value == "13210")
             if (document.getElementById('cmbTrsfCashAcct').selectedIndex == 0) {
                 alert("Favor de seleccionar la Cuenta de Banco de Entrada.");
                 document.getElementById('cmbTrsfCashAcct').focus();
                 return false;
             }

         // Description validation.
         if (document.getElementById('txtDescription').value == "") {
             alert("Favor de especificar la Descripción.")
             document.getElementById('txtDescription').focus();
             return false;
         }

         // Return ok.
         return true;
     }
 </script>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnTranID" runat="server" />
        <asp:HiddenField ID="hdnDate" runat="server" Value="2012/01/01" />
        <asp:HiddenField ID="hdnDocDate" runat="server" Value="2012/01/01" />
        <asp:HiddenField ID="hdnTranClass" runat="server" />
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" 
            EnableScriptGlobalization="True">
        </asp:ToolkitScriptManager>
         
        <!-- Dates -->
        <div id="divDates">

            <!-- Doc Date -->
            <div style="float:right">
                <div style="text-align:right">
                    <asp:Label ID="Label2" runat="server" Text="Fecha Documento" Font-Bold="True" style="text-align:right"
                    Font-Names="Arial" Font-Size="Small"></asp:Label>
                </div>
                <div>  
                    <asp:TextBox ID="txtDocDate" runat="server" style="text-align:right"
                    ReadOnly="True" Font-Bold="False" 
                    Font-Size="Small" Height="18px" BorderStyle="None" Font-Names="Arial">Fri 21 Dic 2012</asp:TextBox>
                
                    <asp:CalendarExtender ID="txtDocDate_CalendarExtender" runat="server" 
                    TargetControlID="txtDocDate" Format="ddd dd/MMM/yyyy"
                    OnClientDateSelectionChanged="EventSelectedDocDate"
                    ></asp:CalendarExtender>
                </div>
            </div>

            <!-- Apply Date -->
            <div align="left"> 
                <div style="text-align:left">                      
                    <asp:Label ID="Label1" runat="server" Text="Fecha Aplicación" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small"></asp:Label>
                </div>
                <div>
                    <asp:TextBox ID="txtDate" runat="server" style="text-align:left"
                    ReadOnly="True" Font-Bold="False" 
                    Font-Size="Small" Height="18px" BorderStyle="None" Font-Names="Arial">Fri 21 Dic 2012</asp:TextBox>
                    <asp:CalendarExtender ID="txtDate_CalendarExtender" runat="server" 
                    TargetControlID="txtDate" Format="ddd dd/MMM/yyyy"
                    OnClientDateSelectionChanged="EventSelectedDate"
                    ></asp:CalendarExtender>
                </div>
            </div>
            
        </div>

        <!-- Amount -->
        <div>   
            <div align="left">   
                <asp:Label ID="lblTranAmt" runat="server" Text="Monto" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small"></asp:Label> 
            </div>
            <div>
                <asp:TextBox ID="txtTranAmt" runat="server" Width="100%" Font-Names="Arial" 
                    MaxLength="9" TextMode="Number"></asp:TextBox>
            </div>
        </div>
        <!-- Type -->
        <div style="margin: 10px 0px 0px 0px">   
            <div>   
                <asp:Label ID="lblTranType" runat="server" Text="Tipo Transacción" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small"></asp:Label> 
            </div>
            <div>                
                <asp:DropDownList ID="cmbTranType" runat="server" Width="100%" 
                    DataSourceID="srcCMTranType" DataTextField="tran_type_desc" 
                    DataValueField="tran_type" Font-Names="Arial" 
                    ondatabound="cmbTranType_DataBound">
                    <asp:ListItem Value="TIPO1">DESC TIPO1</asp:ListItem>
                    <asp:ListItem Value="TIPO2">DESC TIPO2</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="srcCMTranType" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT tran_type, tran_type_desc 
FROM cmtrantype 
WHERE (@tran_class = 0 OR tran_class = @tran_class)
ORDER BY tran_class DESC, tran_type_desc ">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="0" Name="tran_class" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        <!-- Cash Acct -->
        <div style="margin: 10px 0px 0px 0px">   
            <div>   
                <asp:Label ID="lblCashAcct" runat="server" Text="Cuenta Banco" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small"></asp:Label> 
            </div>
            <div>                
                <asp:DropDownList ID="cmbCashAcct" runat="server" Width="100%" 
                    DataSourceID="srcCMCash" DataTextField="cash_acct_desc" 
                    DataValueField="cash_acct_code" Font-Names="Arial" 
                    ondatabound="cmbChasAcct_DataBound">
                    <asp:ListItem>CTA1</asp:ListItem>
                    <asp:ListItem>CTA2</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="srcCMCash" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT cash_acct_code, cash_acct_desc, cash_acct_descr = SUBSTRING(cash_acct_desc, 1, 4)
FROM cmcash 
ORDER BY cash_acct_desc"></asp:SqlDataSource>
            </div>
        </div>

         <!-- Trsf Cash Acct -->
        <div style="margin: 10px 0px 0px 0px">   
            <div>   
                <asp:Label ID="lblTrsfCashAcct" runat="server" Text="Cuenta Banco Entrada" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small" Visible="False"></asp:Label> 
            </div>
            <div>
                <asp:DropDownList ID="cmbTrsfCashAcct" runat="server" Width="100%" 
                    DataSourceID="srcCMCash" DataTextField="cash_acct_desc" 
                    DataValueField="cash_acct_code" Font-Names="Arial" 
                    ondatabound="cmbTrsfCashAcct_DataBound" Visible="False">
                    <asp:ListItem>CTA1</asp:ListItem>
                    <asp:ListItem>CTA2</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="srcCMConfig" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:IntelywareConnectionString.ProviderName %>" SelectCommand="SELECT 
trfout_tran_type,
trfin_tran_type 
FROM CMConfig
WHERE comp_id = @comp_id">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="1" Name="comp_id" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>

        <!-- Description -->
        <div style="margin: 10px 0px 0px 0px">   
            <div>   
                <asp:Label ID="lblDesc" runat="server" Text="Descripción" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small"></asp:Label> 
            </div>
            <div>
                <asp:TextBox ID="txtDescription" runat="server" Width="100%" Font-Names="Arial" 
                    MaxLength="60"></asp:TextBox>
            </div>
        </div>

        <!-- Hold Reason -->
        <div style="margin: 10px 0px 0px 0px">   
            <div>   
                <asp:Label ID="lblHoldReason" runat="server" Text="Razón de Retención" Font-Bold="True" 
                    Font-Names="Arial" Font-Size="Small"></asp:Label> 
            </div>
            <div>
                <asp:TextBox ID="txtHoldReason" runat="server" Width="100%" Font-Names="Arial" 
                    MaxLength="60"></asp:TextBox>
            </div>
        </div>

        <!-- Flags -->
        <div id="divFlags" style="margin: 10px 0px 0px 0px">

            <!-- Post Flag -->
            <div id= "divPostFlag" style="float: right;" align="right">  
                <div>   
                    <asp:Label ID="lblPostFlag" runat="server" Text="Procesado" Font-Bold="True" 
                        Font-Names="Arial" Font-Size="Small"></asp:Label> 
                </div>
                <div> 
                    <asp:CheckBox ID="chbPostFlag" runat="server" />
                </div>
            </div>

            <!-- Hold Flag -->
            <div id= "divHoldFlag" style="float: left;" >  
                <div>   
                    <asp:Label ID="lblHoldFlag" runat="server" Text="Retenido" Font-Bold="True" 
                        Font-Names="Arial" Font-Size="Small"></asp:Label> 
                </div>
                <div> 
                    <asp:CheckBox ID="chbHoldFlag" runat="server" />
                </div>
            </div>

            <!-- Star Flag -->
            <div id= "divStarFlag"  align="center" >  
                <div>   
                    <asp:Label ID="lblStarFlag" runat="server" Text="Importante" Font-Bold="True" 
                        Font-Names="Arial" Font-Size="Small"></asp:Label> 
                </div>
                <div> 
                    <asp:CheckBox ID="chbStarFlag" runat="server" />
                </div>
            </div>

        </div>

        <!-- Buttons -->
        <div style="margin: 10px 0px 0px 0px">
            <div style="float: left"  >
                <asp:ImageButton ID="btnBack" runat="server" 
                    ImageUrl="~/Images/Back.png" OnClick="btnBack_Click" />
            </div>
            <div style="float: right"  >
                <asp:ImageButton ID="btnSave" runat="server" 
                    ImageUrl="~/Images/Save.png" onclick="btnSave_Click" />
            </div>
            <div align="center">
                <asp:ImageButton ID="btnDelete" runat="server" 
                    ImageUrl="~/Images/Delete.png" onclick="btnDelete_Click" />
            </div>                 
        </div>
    
        <asp:SqlDataSource ID="srcCMTranBatch" runat="server" 
            ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT tran_id, comp_id, tran_num, tran_desc, entry_date, doc_date, post_date, post_flag, user_id, tran_type, cash_acct_code, tran_amt, tran_class, trsf_tran_type, trsf_cash_acct_code, apply_date, hold_flag, hold_reason, star_flag FROM cmtranbatch WHERE (tran_id = @tran_id)" InsertCommand="INSERT INTO cmtranbatch(comp_id, tran_num, tran_desc, entry_date, doc_date, post_date, post_flag, user_id, tran_type, cash_acct_code, tran_amt, tran_class, trsf_tran_type, trsf_cash_acct_code, hold_flag, apply_date, star_flag, hold_reason) VALUES (@comp_id, @tran_num, @tran_desc, @entry_date, @doc_date, @post_date, @post_flag, @user_id, @tran_type, @cash_acct_code, @tran_amt, @tran_class, @trsf_tran_type, @trsf_cash_acct_code, @hold_flag, @apply_date, @star_flag, @hold_reason)" UpdateCommand="UPDATE cmtranbatch SET tran_desc = @tran_desc, doc_date = @doc_date, tran_type = @tran_type, cash_acct_code = @cash_acct_code, tran_amt = @tran_amt, trsf_tran_type = @trsf_tran_type, trsf_cash_acct_code = @trsf_cash_acct_code, post_flag = @post_flag, hold_flag = @hold_flag, apply_date = @apply_date, star_flag = @star_flag, hold_reason = @hold_reason WHERE (tran_id = @tran_id)" DeleteCommand="DELETE cmtranbatch 
WHERE tran_id	= @tran_id
">
            <DeleteParameters>
                <asp:Parameter Name="tran_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="comp_id" Type="Int32" />
                <asp:Parameter Name="tran_num" Type="String" />
                <asp:Parameter Name="tran_desc" Type="String" />
                <asp:Parameter Name="entry_date" Type="DateTime" />
                <asp:Parameter Name="doc_date" Type="DateTime" />
                <asp:Parameter Name="post_date" Type="DateTime" />
                <asp:Parameter Name="post_flag" Type="Boolean" />
                <asp:Parameter Name="user_id" Type="Int32" />
                <asp:Parameter Name="tran_type" Type="String" />
                <asp:Parameter Name="cash_acct_code" Type="String" />
                <asp:Parameter Name="tran_amt" Type="Decimal" />
                <asp:Parameter Name="tran_class" Type="Int32" />
                <asp:Parameter Name="trsf_tran_type" Type="String" />
                <asp:Parameter Name="trsf_cash_acct_code" Type="String" />
                <asp:Parameter Name="hold_flag" Type="Boolean" />
                <asp:Parameter Name="apply_date" Type="DateTime" />
                <asp:Parameter Name="star_flag" Type="Boolean" />
                <asp:Parameter Name="hold_reason" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="tran_id" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="tran_desc" Type="String" />
                <asp:Parameter Name="doc_date" Type="DateTime" />
                <asp:Parameter Name="tran_type" Type="String" />
                <asp:Parameter Name="cash_acct_code" Type="String" />
                <asp:Parameter Name="tran_amt" Type="Decimal" />
                <asp:Parameter Name="tran_id" Type="Int32" />
                <asp:Parameter Name="trsf_tran_type" Type="String" />
                <asp:Parameter Name="trsf_cash_acct_code" Type="String" />
                <asp:Parameter Name="post_flag" Type="Boolean" />
                <asp:Parameter Name="hold_flag" Type="Boolean" />
                <asp:Parameter Name="apply_date" Type="DateTime" />
                <asp:Parameter Name="star_flag" Type="Boolean" />
                <asp:Parameter Name="hold_reason" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </form>
</body>
</html>
