<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DivHeaderMainFooter.aspx.cs" Inherits="CM.cm_tran_year_web.FormDivHeaderMainFooter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>

    <style type="text/css">

html,
body {
   margin:0;
   padding:0;
   height:100%;
}
#container {
   min-height:100%;
   position:relative;
}
#header {
   background:#ff0;
   padding:10px;
}
#body {
   padding:10px;
   padding-bottom:60px;   /* Height of the footer */
}
#footer {
   position:absolute;
   bottom:0;
   width:100%;
   height:60px;   /* Height of the footer */
   background:#6cf;
}

    </style>

    <script type="text/javascript" lang="javascript">

         function Mensaje() {
             headerx.clientHeight = 100;
             document.getElementById("headerx").style.height = "100px";
             alert('Hola:' + headerx.clientHeight);
     }

 </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div id="container" style="border: thin solid #FF00FF">

	        <div id="headerx" style="border: medium solid #FFFF00; height: 50px;">
                <asp:Button ID="Button1" runat="server" Text="Button" OnClientClick="Mensaje()" /> 
	        </div>

	        <div id="body" style="border: thin solid #0000FF">
                    <p>ksdjfksdj sdfopskdpf[
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\

                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk
                    
                    ;skdflkdsl;  [psdlfpldspf podskfods 
                    lksdmjfkjsdf  sdpokfosdkjfpk

                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                    s;odkfo;ksdof spo[dkfosdkopfmksdf lkjgtklfjdgkjfdklg  potekroktoprekptokopekotkertk erpotkpoerkt ret opermte t ert ert mpertomeromtore ter\
                </p>
	        </div>

        </div>

        <div id="footer" style="border: thin solid #FF0000">

        </div>
    
    </div>
    </form>
</body>
</html>
