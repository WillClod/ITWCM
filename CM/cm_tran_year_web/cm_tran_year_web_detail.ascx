<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="cm_tran_year_web_detail.ascx.cs" Inherits="CM.cm_tran_year_web.cm_tran_year_web_detail" %>

 <style type="text/css">

        .GridViewDetail
        {
           background-color:cornsilk;
           /*height: 100%;*/
           margin: 2px;              
           position:relative;                          
        }

 </style>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            Height="100%" 
            Width="100%" 
            DataSourceID="srcCMTranBatchRange" 
            DataKeyNames="tran_id" 
            EnablePersistedSelection="True" 
            ShowHeader="False" 
            GridLines="None"

            BackColor="White" 
            BorderStyle="None" 
            BorderWidth="1px" 
            ForeColor="Black"
             
             
            OnRowDataBound="GridView1_RowDataBound" CellPadding="5" CellSpacing="5">
            <Columns>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranID" runat="server" Value='<%# Eval("tran_id") %>'/>
                        <asp:HiddenField ID="hdnTranClass" runat="server" Value='<%# Eval("tran_class") %>'/>
                        <asp:HiddenField ID="hdnTranType" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnTranTypeDesc" runat="server" Value='<%# Eval("tran_type_desc") %>' />
                        <asp:HiddenField ID="hdnCashAcctDescr" runat="server" Value='<%# Eval("cash_acct_descr") %>' />
                        <asp:HiddenField ID="hdnDiscountFlag" runat="server" Value="0" />
                        <asp:HiddenField ID="hdnStarFlag" runat="server" Value='<%# Eval("star_flag") %>' />
                        <asp:HiddenField ID="hdnSeverityClass" runat="server" Value='<%# Eval("severity_class") %>' />
                        <asp:HiddenField ID="hdnApplyDate" runat="server" Value='<%# Eval("apply_date") %>' />
                        <asp:HiddenField ID="hdnDocDate" runat="server" Value='<%# Eval("doc_date", "{0:ddd dd/MM}") %>' />
                        <asp:HiddenField ID="hdnHoldReason" runat="server" Value='<%# Eval("hold_reason") %>' />
                        <asp:HiddenField ID="hdnTranAmt" runat="server" Value='<%# Eval("tran_amt") %>' />
                    <div id="divDetail">

                        <table style="width: 100%; left:100%">
                            <tr>
                                <td>
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
                                    <div id="divDateAmt" style="float: right">                            
                                        <div style="text-align: right">                                
                                                <asp:Label ID="lblApplyDate" runat="server" Font-Names="Arial" Font-Size="Small" Text='<%# Eval("apply_date", "{0:ddd dd/MM}") %>' ></asp:Label>
                                        </div> 
                                        <div style="text-align: right">                                
                                                <asp:Label ID="lblTranAmt" runat="server" Text='<%# Eval("tran_amt", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" Font-Bold="True" ></asp:Label>
                                        </div> 
                                    </div>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="divDesc" style="text-align: left">
                                        <asp:Label ID="lblTranDesc" runat="server" Text='<%# Eval("tran_desc") %>' Font-Names="Arial" Font-Size="Small"></asp:Label>
                                    </div>
                                </td>
                            </tr>
                        </table>
  
                    </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <RowStyle CssClass="GridViewDetail" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        




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
    
    
        




