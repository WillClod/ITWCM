<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cm_tran_year_web_select.aspx.cs" Inherits="CM.cm_tran_year_web.cm_tran_year_web" %>
<%@ Register src="cm_tran_year_web_detail.ascx" tagname="cm_tran_year_web_detail" tagprefix="uc1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>

    <script src="../scripts/FixDiv.js" type="text/javascript"></script>	
    <script src="../scripts/FixDivGrid.js" type="text/javascript"></script>	
    <script  src="../scripts/GridViewScroll.js" type="text/javascript"></script>

    <%--    <link href="../Styles/FixDiv.css" rel="Stylesheet" type="text/css" />--%>
    <link href="../Styles/web.css" rel="stylesheet" />
    <style type="text/css">

        .GVFixedHeader
        {
            background-color:lightskyblue;
            position: relative;
            top: expression(this.parentNode.parentNode.parentNode.scrollTop-1);
            color:black;
            font-size:small;   
            height:25px;            
        }
        .GridColumnType{            
            width: 200px;
        }
        .GridColumnDate{            
            width: 200px;
        }
        .GridRowHeader{
            border:none;
        }
        .divHeaderTotals{
            text-align: right;
            margin-right: 13px;
        }
        </style>
</head>

<body>
    <form id="form1" runat="server">
    <div> 
        <div id="divHeader" class="divHeader">
            <div id="divFilters">
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
            </div>      
            <div id="divGridHeader"  class="GridViewContainerHeader" onscroll="fgvDivRepplyScroll('divGridHeader', 'divGridView')">

                <asp:SqlDataSource ID="srcCMTranType" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="SELECT tran_type, tran_type_desc = SUBSTRING(tran_type_desc, 1, 20)
    FROM cmtrantype 
    WHERE (@tran_class = 0 OR tran_class = @tran_class)
    ORDER BY tran_class DESC, tran_type_desc ">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="tran_class" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                
                <asp:SqlDataSource ID="srcCMTranTypeYearHeader" runat="server" ConnectionString="<%$ ConnectionStrings:IntelywareConnectionString %>" SelectCommand="EXEC CMTranBatchYearSumGet @year, @tran_type, 0, @start_amt
    ">
                    <SelectParameters>
                        <asp:Parameter Name="year" Type="Int16" />
                        <asp:Parameter DefaultValue="0.0" Name="start_amt" Type="Decimal" />
                        <asp:Parameter DefaultValue="*" Name="tran_type" Type="String" />
                    </SelectParameters>
            </asp:SqlDataSource>

                <asp:GridView 
                    ID    ="GridView2" 
                    runat="server" 
                    AutoGenerateColumns="False" 
                    DataSourceID="srcCMTranTypeYearHeader"
                                    
                    Width="4900px"                              
                    HeaderStyle-CssClass="GVFixedHeader" Font-Names="Arial" BorderStyle="None" Font-Bold="False" BorderWidth="0px" GridLines="None" OnDataBound="GridView2_DataBound" OnRowDataBound="GridView2_RowDataBound"                             
                   >
                <Columns>
                    <asp:BoundField HeaderText="Tipo" DataField="sum_desc" >                                   
                        <ItemStyle CssClass="GridColumnType"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="ENE.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType25" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType25" runat="server" Value='<%# Eval("M01D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail25" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType25" runat="server" Text='<%# Eval("M01D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ENE.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType26" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType26" runat="server" Value='<%# Eval("M01D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail26" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType26" runat="server" Text='<%# Eval("M01D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FEB.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType27" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType27" runat="server" Value='<%# Eval("M02D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail27" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType27" runat="server" Text='<%# Eval("M02D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FEB.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType28" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType28" runat="server" Value='<%# Eval("M02D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail28" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType28" runat="server" Text='<%# Eval("M02D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAR.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType29" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType29" runat="server" Value='<%# Eval("M03D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail29" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType29" runat="server" Text='<%# Eval("M03D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAR.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType30" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType30" runat="server" Value='<%# Eval("M03D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail30" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType30" runat="server" Text='<%# Eval("M03D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ABR.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType31" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType31" runat="server" Value='<%# Eval("M04D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail31" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType31" runat="server" Text='<%# Eval("M04D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ABR.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType32" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType32" runat="server" Value='<%# Eval("M04D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail32" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType32" runat="server" Text='<%# Eval("M04D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAY.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType33" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType33" runat="server" Value='<%# Eval("M05D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail33" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType33" runat="server" Text='<%# Eval("M05D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAY.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType34" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType34" runat="server" Value='<%# Eval("M05D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail34" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType34" runat="server" Text='<%# Eval("M05D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUN.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType35" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType35" runat="server" Value='<%# Eval("M06D01") %>' />   
                            <asp:Label ID="lblRangeType35" runat="server" Text='<%# Eval("M06D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            <div class="divHeaderTotals">
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail35" runat="server" />  
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUN.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType36" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType36" runat="server" Value='<%# Eval("M06D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail36" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType36" runat="server" Text='<%# Eval("M06D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUL.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType37" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType37" runat="server" Value='<%# Eval("M07D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail37" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType37" runat="server" Text='<%# Eval("M07D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUL.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType38" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType38" runat="server" Value='<%# Eval("M07D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail38" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType38" runat="server" Text='<%# Eval("M07D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AGO.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType39" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType39" runat="server" Value='<%# Eval("M08D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail39" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType39" runat="server" Text='<%# Eval("M08D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AGO.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType40" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType40" runat="server" Value='<%# Eval("M08D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail40" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType40" runat="server" Text='<%# Eval("M08D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SEP.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType41" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType41" runat="server" Value='<%# Eval("M09D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail41" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType41" runat="server" Text='<%# Eval("M09D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SEP.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType42" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType42" runat="server" Value='<%# Eval("M09D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail42" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType42" runat="server" Text='<%# Eval("M09D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OCT.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType43" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType43" runat="server" Value='<%# Eval("M10D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail43" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType43" runat="server" Text='<%# Eval("M10D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small"></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OCT.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType44" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType44" runat="server" Value='<%# Eval("M10D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail44" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType44" runat="server" Text='<%# Eval("M10D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NOV.Q1" >
                        <ItemTemplate>                        
                            <asp:HiddenField ID="hdnTranType45" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType45" runat="server" Value='<%# Eval("M11D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail45" runat="server" />                          
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType45" runat="server" Text='<%# Eval("M11D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NOV.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType46" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType46" runat="server" Value='<%# Eval("M11D16") %>' />
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail46" runat="server" />                           
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType46" runat="server" Text='<%# Eval("M11D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DIC.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType47" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType47" runat="server" Value='<%# Eval("M12D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail47" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType47" runat="server" Text='<%# Eval("M12D01", "{0:c}") %>' Font-Names="Arial" Font-Size="Small"></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DIC.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType48" runat="server" Value='<%# Eval("sum_type") %>' />
                            <asp:HiddenField ID="hdnRangeType48" runat="server" Value='<%# Eval("M12D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail48" runat="server" />  
                            <div class="divHeaderTotals">
                            <asp:Label ID="lblRangeType48" runat="server" Text='<%# Eval("M12D16", "{0:c}") %>' Font-Names="Arial" Font-Size="Small" ></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                </Columns>

    <HeaderStyle CssClass="GVFixedHeader" Font-Bold="False" BorderStyle="None"></HeaderStyle>

                    <RowStyle BorderStyle="None" Height="1px" BorderColor="White" CssClass="GridRowHeader" />
            </asp:GridView>   

            </div>
        </div>
        <div id="divBody" class ="divBody" onscroll="fgvDivRepplyScroll('divBody', 'divHeader')">
            <div id="divGridView">
                <asp:GridView 
                    ID="gvwMain" 
                    runat="server" 
                    AutoGenerateColumns="False" 
                    DataSourceID="srcCMTranTypeYear" 

                    OnRowDataBound="gvwMain_RowDataBound" 
                    OnDataBound="gvwMain_DataBound" 
               
                    Width="4900px"                              
                    HeaderStyle-CssClass="GVFixedHeader" 
                    ShowHeader="False" BorderColor="#CCCCCC" BorderStyle="None" Font-Names="Arial" GridLines="Horizontal" OnSelectedIndexChanged="gvwMain_SelectedIndexChanged"                                     
                   >
                <Columns>
                    <asp:BoundField HeaderText="Tipo" DataField="tran_desc" >               
                        <ItemStyle CssClass="GridColumnType"></ItemStyle>
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="ENE.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType1" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType1" runat="server" Value='<%# Eval("M01D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail1" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ENE.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType2" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType2" runat="server" Value='<%# Eval("M01D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail2" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FEB.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType3" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType3" runat="server" Value='<%# Eval("M02D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail3" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="FEB.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType4" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType4" runat="server" Value='<%# Eval("M02D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail4" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAR.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType5" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType5" runat="server" Value='<%# Eval("M03D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail5" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAR.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType6" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType6" runat="server" Value='<%# Eval("M03D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail6" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ABR.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType7" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType7" runat="server" Value='<%# Eval("M04D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail7" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ABR.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType8" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType8" runat="server" Value='<%# Eval("M04D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail8" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAY.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType9" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType9" runat="server" Value='<%# Eval("M05D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail9" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="MAY.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType10" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType10" runat="server" Value='<%# Eval("M05D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail10" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUN.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType11" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType11" runat="server" Value='<%# Eval("M06D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail11" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUN.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType12" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType12" runat="server" Value='<%# Eval("M06D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail12" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUL.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType13" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType13" runat="server" Value='<%# Eval("M07D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail13" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="JUL.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType14" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType14" runat="server" Value='<%# Eval("M07D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail14" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AGO.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType15" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType15" runat="server" Value='<%# Eval("M08D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail15" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AGO.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType16" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType16" runat="server" Value='<%# Eval("M08D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail16" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SEP.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType17" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType17" runat="server" Value='<%# Eval("M09D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail17" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SEP.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType18" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType18" runat="server" Value='<%# Eval("M09D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail18" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OCT.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType19" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType19" runat="server" Value='<%# Eval("M10D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail19" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="OCT.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType20" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType20" runat="server" Value='<%# Eval("M10D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail20" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NOV.Q1" >
                        <ItemTemplate>                        
                            <asp:HiddenField ID="hdnTranType21" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType21" runat="server" Value='<%# Eval("M11D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail21" runat="server" />                          
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="NOV.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType22" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType22" runat="server" Value='<%# Eval("M11D16") %>' />
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail22" runat="server" />                           
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DIC.Q1">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType23" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType23" runat="server" Value='<%# Eval("M12D01") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail23" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DIC.Q2">
                        <ItemTemplate>
                            <asp:HiddenField ID="hdnTranType24" runat="server" Value='<%# Eval("tran_type") %>' />
                            <asp:HiddenField ID="hdnRangeType24" runat="server" Value='<%# Eval("M12D16") %>' />   
                            <uc1:cm_tran_year_web_detail ID="cm_tran_year_web_detail24" runat="server" />  
                        </ItemTemplate>
                        <ItemStyle CssClass="GridColumnDate" />
                    </asp:TemplateField>
                </Columns>
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />

    <HeaderStyle CssClass="GVFixedHeader" BackColor="#333333" Font-Bold="True" ForeColor="White"></HeaderStyle>

                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle VerticalAlign="Top" />
                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>   
            </div>
        </div>
        <div id="divFooter" class ="divFooter">
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
            </div>
        </div>
    </div>
    </form>
</body>

</html>
