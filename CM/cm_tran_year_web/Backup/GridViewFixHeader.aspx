<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GridViewFixHeader.aspx.cs" Inherits="CM.cm_tran_year_web.GridViewFixHeader" %>

<%@ Register src="cm_tran_year_web_detail.ascx" tagname="cm_tran_year_web_detail" tagprefix="uc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
  
</head>
<body>
    <form id="form1" runat="server">
    <div class="GridViewContainer" >
    
 <asp:SqlDataSource ID="srcCMTranTypeYear" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="
SELECT 
TR.tran_type,
MIN(TR.tran_desc) AS tran_desc,
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
GROUP BY TR.tran_type, TY.severity_class, TY.sequence
ORDER BY TY.severity_class, TY.sequence">
            <SelectParameters>
                <asp:Parameter Name="from_apply_date" Type="DateTime" />
                <asp:Parameter Name="to_apply_date" Type="DateTime" />
                <asp:Parameter Name="post_flag" Type="Boolean" />
                <asp:Parameter Name="tran_type" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
            <asp:GridView 
                ID    ="GridView1" 
                runat="server" 
                AutoGenerateColumns="False" 
                DataSourceID="srcCMTranTypeYear" 
                
                Width="5000px"                              
                GridLines="None" 
                HeaderStyle-CssClass="GVFixedHeader"     
               >
            <Columns>
                <asp:BoundField HeaderText="Tipo" DataField="tran_type">
                <ItemStyle Width="300px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="ENE.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType1" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType1" runat="server" Value='<%# Eval("M01D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail1" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ENE.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType2" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType2" runat="server" Value='<%# Eval("M01D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail2" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FEB.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType3" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType3" runat="server" Value='<%# Eval("M02D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail3" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FEB.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType4" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType4" runat="server" Value='<%# Eval("M02D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail4" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MAR.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType5" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType5" runat="server" Value='<%# Eval("M03D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail5" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MAR.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType6" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType6" runat="server" Value='<%# Eval("M03D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail6" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ABR.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType7" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType7" runat="server" Value='<%# Eval("M04D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail7" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ABR.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType8" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType8" runat="server" Value='<%# Eval("M04D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail8" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MAY.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType9" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType9" runat="server" Value='<%# Eval("M05D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail9" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MAY.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType10" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType10" runat="server" Value='<%# Eval("M05D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail10" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JUN.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType11" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType11" runat="server" Value='<%# Eval("M06D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail11" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JUN.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType12" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType12" runat="server" Value='<%# Eval("M06D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail12" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JUL.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType13" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType13" runat="server" Value='<%# Eval("M07D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail13" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JUL.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType14" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType14" runat="server" Value='<%# Eval("M07D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail14" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AGO.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType15" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType15" runat="server" Value='<%# Eval("M08D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail15" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AGO.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType16" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType16" runat="server" Value='<%# Eval("M08D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail16" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SEP.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType17" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType17" runat="server" Value='<%# Eval("M09D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail17" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SEP.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType18" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType18" runat="server" Value='<%# Eval("M09D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail18" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="OCT.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType19" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType19" runat="server" Value='<%# Eval("M10D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail19" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="OCT.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType20" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType20" runat="server" Value='<%# Eval("M10D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail20" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="NOV.Q1" >
                    <ItemTemplate>                        
                        <asp:HiddenField ID="hdnTranType21" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType21" runat="server" Value='<%# Eval("M11D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail21" runat="server" />                          
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="NOV.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType22" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType22" runat="server" Value='<%# Eval("M11D16") %>' />
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail22" runat="server" />                           
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DIC.Q1">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType23" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType23" runat="server" Value='<%# Eval("M12D01") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail23" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DIC.Q2">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnTranType24" runat="server" Value='<%# Eval("tran_type") %>' />
                        <asp:HiddenField ID="hdnRangeType24" runat="server" Value='<%# Eval("M12D16") %>' />   
                        <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail24" runat="server" />  
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle VerticalAlign="Top" />
        </asp:GridView>   
    
    </div>
    </form>
</body>
</html>
