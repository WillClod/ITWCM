<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cm_tran_mobil_entry.aspx.cs" Inherits="CM.cm_tran.cm_tran_entry" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>ITW Tran Entry</title>
         
    <!-- Mobile layout -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <!-- Fix Divs -->        
    <script src="~/Scripts/FixDiv.js" type="text/javascript"></script>	
    <link href="../Styles/FixDiv.css" rel="Stylesheet" type="text/css"/>

    <!-- Page Style -->     
    <link href="~/Styles/PageMobile.css" rel="Stylesheet" type="text/css"/>

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

        $(function () {
            $("#txtDocDate").datepicker({
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
                //__doPostBack("DateSelected", vlsSelectedDate);

                document.getElementById('hdnDate').value = vlsSelectedDate;
            });


            $("#txtDocDate").datepicker({
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
                //__doPostBack("DateSelected", vlsSelectedDate);

                document.getElementById('hdnDocDate').value = vlsSelectedDate;
            });
          
        });

        function btnTest_OnClick() {
            alert("Hola");
        }
        
    </script>

    <!-- Local Scripts -->
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

</head>
<body>
    <form id="form1" runat="server">

       <div id="divHeader" class="divHeader">

           <div id="divHiddens"> 
                <asp:HiddenField ID="hdnTranID" runat="server" />
                <asp:HiddenField ID="hdnDate" runat="server" Value="2012/01/01" />
                <asp:HiddenField ID="hdnDocDate" runat="server" Value="2012/01/01" />
                <asp:HiddenField ID="hdnTranClass" runat="server" />
            </div>

           <div id="divPageBar" class="divPageBar">

               <div id="divLeftButton" class="divLeft">
                   <asp:ImageButton ID="btnBack" runat="server" 
                        ImageUrl="~/Images/Back48.png" OnClick="btnBack_Click" ToolTip="Regresar" />
               </div>

               <div id="divRigthButton" class="divRight">
                   <asp:ImageButton ID="btnSave" runat="server" 
                        ImageUrl="~/Images/Done48.png" onclick="btnSave_Click" ToolTip="Guardar" />
               </div>
                            
               <div id="divTitle" class="divTitle">
                   <asp:Label ID="lblTitle" class="lblTitle" runat="server" Text="Registro de Efectivo"></asp:Label>
               </div>

           </div>

       </div>

       <div id="divBody" class ="divBody" style="margin-top: 10px; margin-left: 10px" >

            <div id="divDates" style="margin-bottom: 10px; height: 50px;">
       
                <div id="divApplyDate" class="divLeft"> 
                    <div>                      
                        <asp:Label ID="lblDate" class="lbl" runat="server" Text="Fecha Aplicación"></asp:Label>
                    </div>
                    <div>
                        <asp:TextBox ID="txtDate" class="txt" runat="server" style="text-align:left"
                        ReadOnly="True" 
                        BorderStyle="None">Fri 21 Dic 2012</asp:TextBox> 
                        <asp:Button ID="btnTest" runat="server" Text="Test" Visible="False" ForeColor="Gray" />
                    </div>
                </div>

                <div id="divDocDate" class="divRight">
                    <div>                        
                        <asp:Label ID="lblDocDate" class="lbl" runat="server" Text="Fecha Documento"></asp:Label>
                    </div>
                    <div>  
                        <asp:TextBox ID="txtDocDate" class="txt" runat="server" style="text-align:right"
                        ReadOnly="True" BorderStyle="None">Fri 21 Dic 2012</asp:TextBox>                                   
                    </div>
                </div>                            

                <div class="DivCenter">

                </div>
            </div>

            <div id="divAmount">   
                <div align="left">   
                    <asp:Label ID="lblTranAmt" class="lbl" runat="server" Text="Monto"></asp:Label> 
                </div>
                <div>
                    <asp:TextBox ID="txtTranAmt" class="txt" runat="server" Width="100%" 
                        MaxLength="9" TextMode="Number"></asp:TextBox>
                </div>
            </div>

            <div id="divType" style="margin: 10px 0px 0px 0px">   
                <div>   
                    <asp:Label ID="lblTranType" class="lbl" runat="server" Text="Tipo Transacción"></asp:Label> 
                </div>
                <div>                
                    <asp:DropDownList ID="cmbTranType" class="cmb" runat="server" Width="100%" 
                        DataSourceID="srcCMTranType" DataTextField="tran_type_desc" 
                        DataValueField="tran_type"  
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

            <div id="divCashAccount" style="margin: 10px 0px 0px 0px">   
                <div>   
                    <asp:Label ID="lblCashAcct" class="lbl" runat="server" Text="Cuenta Banco"></asp:Label> 
                </div>
                <div>                
                    <asp:DropDownList ID="cmbCashAcct" class="cmb" runat="server" Width="100%" 
                        DataSourceID="srcCMCash" DataTextField="cash_acct_desc" 
                        DataValueField="cash_acct_code"  
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

            <div id="divTrsfCashAcct" style="margin: 10px 0px 0px 0px">   
                <div>   
                    <asp:Label ID="lblTrsfCashAcct" class="lbl" runat="server" Text="Cuenta Banco Entrada"  
                        Visible="False"></asp:Label> 
                </div>
                <div>
                    <asp:DropDownList ID="cmbTrsfCashAcct" class="cmb" runat="server" Width="100%" 
                        DataSourceID="srcCMCash" DataTextField="cash_acct_desc" 
                        DataValueField="cash_acct_code" 
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

            <div id="divDescription" style="margin: 10px 0px 0px 0px">   
                <div>   
                    <asp:Label ID="lblDesc" class="lbl" runat="server" Text="Descripción"></asp:Label> 
                </div>
                <div>
                    <asp:TextBox ID="txtDescription" class="txt" runat="server" Width="100%"></asp:TextBox>
                </div>
            </div>

            <div id="divHoldReason" style="margin: 10px 0px 0px 0px">   
                <div>   
                    <asp:Label ID="lblHoldReason" class="lbl" runat="server" Text="Razón de Retención"></asp:Label> 
                </div>
                <div>
                    <asp:TextBox ID="txtHoldReason" class="txt" runat="server" Width="100%"  
                        MaxLength="60"></asp:TextBox>
                </div>
            </div>

            <div id="divFlags" style="margin: 10px 0px 0px 0px">

                <!-- Post Flag -->
                <div id= "divPostFlag" class="divRight">  
                    <div>   
                        <asp:Label ID="lblPostFlag" class="lbl" runat="server" Text="Procesado"></asp:Label> 
                    </div>
                    <div> 
                        <asp:CheckBox ID="chbPostFlag" class="chb" runat="server"/>
                    </div>
                </div>

                <!-- Hold Flag -->
                <div id= "divHoldFlag" class="divLeft">  
                    <div>   
                        <asp:Label ID="lblHoldFlag" class="lbl" runat="server" Text="Retenido"></asp:Label> 
                    </div>
                    <div> 
                        <asp:CheckBox ID="chbHoldFlag" class="chb" runat="server"/>
                    </div>
                </div>

                <!-- Star Flag -->
                <div id= "divStarFlag" class="divCenter">  
                    <div>   
                        <asp:Label ID="lblStarFlag" class="lbl" runat="server" Text="Importante"></asp:Label> 
                    </div>
                    <div> 
                        <asp:CheckBox ID="chbStarFlag" class="chb" runat="server"/>
                    </div>
                </div>

            </div>

            <div id="divButtons" style="margin: 40px 0px 0px 0px">

                <div class="divLeft">
                    
                </div>
                <div class="divRight">
                </div>
                <div id="divDelete" class="divCenter">
                   <asp:Button ID="btnDelete" class="btnAlert" runat="server" Text="Eliminar" OnClick="btnDelete_Click" />
               </div>    
                
            </div>
          
        </div>

       <div id="divFooter" class ="divFooter" style="margin-top: 10px; margin-left: 10px" >

            <div id="divDataSources">
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
            </div>

       </div>

    </form>
</body>
</html>
